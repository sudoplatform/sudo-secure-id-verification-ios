//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging
import SudoUser
import AWSAppSync
import AWSS3
import SudoConfigManager
import SudoApiClient

public enum SudoIdentityVerificationClientError: Error {

    /// Indicates the bad data was found in cache or in backend response..
    case badData

    ///  Indicates the identity could not be verified based on the input provided.
    case identityNotVerified

    ///  Indicates the identity verification result cannot be found for the user.
    case verificationResultNotFound

    /// Indicates that an attempt to register was made but there's already one in progress.
    case registerOperationAlreadyInProgress

    /// Indicates the client has not been registered to the Sudo platform backend.
    case notRegistered

    /// Indicates the ownership proof provided for the new vau
    /// Indicates that the configuration dictionary passed to initialize the client was not valid.
    case invalidConfig

    /// Indicates that the input to the API was invalid.
    case invalidInput

    /// Indicates the requested operation failed because the user account is locked.
    case accountLocked

    /// Indicates the API being called requires the client to sign in.
    case notSignedIn

    /// Indicates that the request operation failed due to authorization error. This maybe due to the authentication
    /// token being invalid or other security controls that prevent the user from accessing the API.
    case notAuthorized

    /// Indicates API call failed due to it requiring tokens to be refreshed but something else is already in
    /// middle of refreshing the tokens.
    case refreshTokensOperationAlreadyInProgress

    /// Indicates API call  failed due to it exceeding some limits imposed for the API. For example, this error
    /// can occur if the vault size was too big.
    case limitExceeded

    /// Indicates that the user does not have sufficient entitlements to perform the requested operation.
    case insufficientEntitlements

    /// Indicates the version of the vault that is getting updated does not match the current version of the vault stored
    /// in the backend. The caller should retrieve the current version of the vault and reconcile the difference.
    case versionMismatch

    /// Indicates that an internal server error caused the operation to fail. The error is possibly transient and
    /// retrying at a later time may cause the operation to complete successfully
    case serviceError

    /// Indicates that the request failed due to connectivity, availability or access error.
    case requestFailed(response: HTTPURLResponse?, cause: Error?)

    /// Indicates that there were too many attempts at sending API requests within a short period of time.
    case rateLimitExceeded

    /// Indicates that a GraphQL error was returned by the backend.
    case graphQLError(description: String)

    /// Indicates that a fatal error occurred. This could be due to coding error, out-of-memory condition or other
    /// conditions that is beyond control of `SudoIdentityVerificationClient` implementation.
    case fatalError(description: String)

}

extension SudoIdentityVerificationClientError {

    struct Constants {
        static let errorType = "errorType"
    }

    static func fromApiOperationError(error: Error) -> SudoIdentityVerificationClientError {
        switch error {
        case ApiOperationError.accountLocked:
            return .accountLocked
        case ApiOperationError.notSignedIn:
            return .notSignedIn
        case ApiOperationError.notAuthorized:
            return .notAuthorized
        case ApiOperationError.refreshTokensOperationAlreadyInProgress:
            return .refreshTokensOperationAlreadyInProgress
        case ApiOperationError.limitExceeded:
            return .limitExceeded
        case ApiOperationError.insufficientEntitlements:
            return .insufficientEntitlements
        case ApiOperationError.serviceError:
            return .serviceError
        case ApiOperationError.versionMismatch:
            return .versionMismatch
        case ApiOperationError.invalidRequest:
            return .invalidInput
        case ApiOperationError.rateLimitExceeded:
            return .rateLimitExceeded
        case ApiOperationError.graphQLError(let cause):
            return .graphQLError(description: "Unexpected GraphQL error: \(cause)")
        case ApiOperationError.requestFailed(let response, let cause):
            return .requestFailed(response: response, cause: cause)
        default:
            return .fatalError(description: "Unexpected API operation error: \(error)")
        }
    }

}

/// Options for controlling the behaviour of query APIs.
///
/// - cacheOnly: returns query result from the local cache only.
/// - remoteOnly: performs the query in the backend and ignores any cached entries.
public enum QueryOption {
    case cacheOnly
    case remoteOnly
}

/// Protocol encapsulating a set of functions for identity verification..
public protocol SudoIdentityVerificationClient: AnyObject {

    /// Retrieves the list of supported countries for identity verification.
    ///
    /// - Parameter completion: The completion handler to invoke to pass the list of support countries or error.
    func listSupportedCountries(completion: @escaping (Swift.Result<[String], Error>) -> Void) throws

    /// Verifies an identity against the known public records and returns a result indicating whether or not the identity
    /// details provided was verified with enough confidence to grant the user access to Sudo platform functions such
    /// as provisioning a virtual card.
    ///
    /// - Parameters:
    ///   - firstName: First name. Case insensitive.
    ///   - lastName: Last name. Case insensitive.
    ///   - address: Address. Case insensitive.
    ///   - city: City. Case insensitive.
    ///   - state: State. This is abbreviated name for the state, e.g. ‘NY’ not ‘New York’.
    ///   - postalCode: Postal code.
    ///   - country: ISO 3166-1 alpha-2 country code. Must be one of countries retrieved via `getSupportedCountries` API.
    ///   - dateOfBirth: Date of birth formatted in "yyyy-MM-dd".
    ///   - completion: The completion handler to invoke to pass the verification result.
    func verifyIdentity(firstName: String,
                        lastName: String,
                        address: String,
                        city: String?,
                        state: String?,
                        postalCode: String,
                        country: String,
                        dateOfBirth: String,
                        completion: @escaping (Swift.Result<VerifiedIdentity, Error>) -> Void)

    /// Checks the identity verification status of the currently signed in user.
    ///
    /// - Parameters:
    ///   - option: Option to determine whether to check the status in the backend or return the cached result.
    ///   - completion: The completion handler to invoke to pass the verification result.
    func checkIdentityVerification(option: QueryOption, completion: @escaping (Swift.Result<VerifiedIdentity, Error>) -> Void) throws

    /// Resets any cached data.
    ///
    /// - Throws: `SudoIdentityVerificationClientError`
    func reset() throws

}

/// Default implementation of `SudoIdentityVerificationClient`.
public class DefaultSudoIdentityVerificationClient: SudoIdentityVerificationClient {

    public struct Config {

        // Configuration namespace.
        struct Namespace {
            static let identityVerificationService = "IdentityVerificationService"
        }

    }

    /// Default logger for the client.
    private let logger: Logger

    ///`SudoUserClient` instance required to issue authentication tokens and perform cryptographic operations.
    private let sudoUserClient: SudoUserClient

    /// GraphQL client for communicating with the identity verification service.
    private let graphQLClient: SudoApiClient

    /// Operation queue used for serializing and rate controlling expensive remote API calls.
    private let sudoOperationQueue = SudoOperationQueue()

    /// Intializes a new `DefaultSudoIdentityVerificationClient` instance.
    ///
    /// - Parameters:
    ///   - sudoUserClient: `SudoUserClient` instance required to issue authentication tokens and perform cryptographic operations.
    ///   - logger: A logger to use for logging messages. If none provided then a default internal logger will be used.
    /// - Throws: `SudoIdentityVerificationClientError`
    convenience public init(sudoUserClient: SudoUserClient, logger: Logger? = nil) throws {
        var config: [String: Any] = [:]

        if let configManager = DefaultSudoConfigManager(),
            let identityVerificationServiceConfig = configManager.getConfigSet(namespace: Config.Namespace.identityVerificationService) {
            config[Config.Namespace.identityVerificationService] = identityVerificationServiceConfig
        }

        guard let graphQLClient = try SudoApiClientManager.instance?.getClient(sudoUserClient: sudoUserClient) else {
            throw SudoIdentityVerificationClientError.invalidConfig
        }

        try self.init(config: config, sudoUserClient: sudoUserClient, logger: logger, graphQLClient: graphQLClient)
    }

    /// Intializes a new `DefaultSudoIdentityVerificationClient` instance with the specified backend configuration.
    ///
    /// - Parameters:
    ///   - config: Configuration parameters for the client.
    ///   - sudoUserClient: `SudoUserClient` instance required to issue authentication tokens and perform cryptographic operations.
    ///   - logger: A logger to use for logging messages. If none provided then a default internal logger will be used.
    ///   - graphQLClient: Optional GraphQL client to use. Mainly used for unit testing.
    /// - Throws: `SudoIdentityVerificationClientError`
    public init(config: [String: Any], sudoUserClient: SudoUserClient, logger: Logger? = nil, graphQLClient: SudoApiClient? = nil) throws {

        #if DEBUG
            AWSDDLog.sharedInstance.logLevel = .verbose
            AWSDDLog.add(AWSDDTTYLogger.sharedInstance)
        #endif

        let logger = logger ?? Logger.sudoIdentityVerificationClientLogger
        self.logger = logger
        self.sudoUserClient = sudoUserClient

        if let graphQLClient = graphQLClient {
            self.graphQLClient = graphQLClient
        } else {
            guard let sudoIdentityVerificationServiceConfig = config[Config.Namespace.identityVerificationService] as? [String: Any],
                let configProvider = SudoIdentityVerificationClientConfigProvider(config: sudoIdentityVerificationServiceConfig) else {
                throw SudoIdentityVerificationClientError.invalidConfig
            }

            self.graphQLClient = try SudoApiClient(configProvider: configProvider, sudoUserClient: self.sudoUserClient)
        }
    }

    public func listSupportedCountries(completion: @escaping (Swift.Result<[String], Error>) -> Void) throws {
        self.logger.info("Retrieving the list of supported countries for identity verification.")

        do {
            try self.graphQLClient.fetch(
                query: GetSupportedCountriesForIdentityVerificationQuery(),
                cachePolicy: .fetchIgnoringCacheData,
                resultHandler: { (result, error) in
                    if let error = error {
                        return completion(.failure(SudoIdentityVerificationClientError.fromApiOperationError(error: error)))
                    }

                    guard let result = result else {
                        return completion(.failure(SudoIdentityVerificationClientError.fatalError(description: "Query returned nil result.")))
                    }

                    if let error = result.errors?.first {
                        self.logger.error("Query failed with errors: \(error)")
                        return completion(.failure(SudoIdentityVerificationClientError.fromApiOperationError(error: error)))
                    }

                    guard let countryList = result.data?.getSupportedCountriesForIdentityVerification?.countryList else {
                        return completion(.success([]))
                    }

                    completion(.success(countryList))
                }
            )
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func verifyIdentity(firstName: String,
                               lastName: String,
                               address: String,
                               city: String?,
                               state: String?,
                               postalCode: String,
                               country: String,
                               dateOfBirth: String,
                               completion: @escaping (Swift.Result<VerifiedIdentity, Error>) -> Void) {
        self.logger.info("Verifying an identity.")

        let verifyIdentityOp = VerifyIdentity(graphQLClient: self.graphQLClient, firstName: firstName, lastName: lastName, address: address, city: city, state: state, postalCode: postalCode, country: country, dateOfBirth: dateOfBirth)
        let completionOp = BlockOperation {
            if let error = verifyIdentityOp.error {
                self.logger.error("Failed verify the identity: \(error)")
                completion(.failure(error))
            } else {
                guard let verifiedIdentity = verifyIdentityOp.verifiedIdentity else {
                    self.logger.error("The identity could not be verified.")
                    return completion(.failure(SudoIdentityVerificationClientError.identityNotVerified))
                }

                self.logger.info("The identity verified successfully.")
                completion(.success(verifiedIdentity))
            }
        }

        self.sudoOperationQueue.addOperations([verifyIdentityOp, completionOp], waitUntilFinished: false)
    }

    public func checkIdentityVerification(option: QueryOption, completion: @escaping (Swift.Result<VerifiedIdentity, Error>) -> Void) throws {
        self.logger.info("Checking the identity verification status.")

        let cachePolicy: CachePolicy
        switch option {
        case .cacheOnly:
            cachePolicy = .returnCacheDataDontFetch
        case .remoteOnly:
            cachePolicy = .fetchIgnoringCacheData
        }

        do {
            try self.graphQLClient.fetch(
                query: CheckIdentityVerificationQuery(),
                cachePolicy: cachePolicy,
                resultHandler: { (result, error) in
                    if let error = error {
                        return completion(.failure(SudoIdentityVerificationClientError.fromApiOperationError(error: error)))
                    }

                    guard let result = result else {
                        return completion(.failure(SudoIdentityVerificationClientError.fatalError(description: "Query returned nil result.")))
                    }

                    if let error = result.errors?.first {
                        self.logger.error("Query failed with errors: \(error)")
                        return completion(.failure(SudoIdentityVerificationClientError.fromApiOperationError(error: error)))
                    }

                    guard let verifiedIdentity = result.data?.checkIdentityVerification else {
                        return completion(.failure(SudoIdentityVerificationClientError.verificationResultNotFound))
                    }

                    var verifiedAt: Date?
                    if let verifiedAtEpochMs = verifiedIdentity.verifiedAtEpochMs {
                        verifiedAt = Date(millisecondsSinceEpoch: verifiedAtEpochMs)
                    }

                    completion(
                        .success(
                            VerifiedIdentity(
                                owner: verifiedIdentity.owner,
                                verified: verifiedIdentity.verified,
                                verifiedAt: verifiedAt,
                                verificationMethod: verifiedIdentity.verificationMethod,
                                canAttemptVerificationAgain: verifiedIdentity.canAttemptVerificationAgain,
                                idScanUrl: verifiedIdentity.idScanUrl
                            )
                        )
                    )
                }
            )
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func reset() throws {
        self.logger.info("Resetting client state.")

        try self.graphQLClient.clearCaches(options: .init(clearQueries: true, clearMutations: true, clearSubscriptions: true))
    }

}
