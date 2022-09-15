//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging
import SudoUser
import AWSAppSync
import AWSCore
import SudoConfigManager
import SudoApiClient

/// Default implementation of `SudoIdentityVerificationClient`.
public class DefaultSudoIdentityVerificationClient: SudoIdentityVerificationClient {

    public struct Config {

        // Configuration namespace.
        struct Namespace {
            static let identityVerificationService = "IdentityVerificationService"
        }

    }

    /// Methods of verification.
    enum VerificationMethod: String {
        case knowledgeOfPii = "KNOWLEDGE_OF_PII"
        case governmentId = "GOVERNMENT_ID"
    }

    /// Default logger for the client.
    private let logger: Logger

    /// `SudoUserClient` instance required to issue authentication tokens and perform cryptographic operations.
    private let sudoUserClient: SudoUserClient

    /// GraphQL client for communicating with the identity verification service.
    private let graphQLClient: SudoApiClient

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
    public init(
        config: [String: Any],
        sudoUserClient: SudoUserClient,
        logger: Logger? = nil,
        graphQLClient: SudoApiClient? = nil
    ) throws {

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

    public func listSupportedCountries() async throws -> [String] {
        self.logger.info("Retrieving the list of supported countries for identity verification.")

        do {
            let (result, error) = try await self.graphQLClient.fetch(
                query: GraphQL.GetSupportedCountriesForIdentityVerificationQuery(),
                cachePolicy: .fetchIgnoringCacheData
            )
            if let error = error {
                throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
            }

            guard let result = result else {
                throw SudoIdentityVerificationClientError.fatalError(description: "Query returned nil result.")
            }

            if let error = result.errors?.first {
                self.logger.error("Query failed with errors: \(error)")
                throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
            }

            guard let countryList = result.data?.getSupportedCountriesForIdentityVerification?.countryList else {
                return []
            }

            return countryList
        } catch let error as ApiOperationError {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func verifyIdentity(input: VerifyIdentityInput) async throws -> VerifiedIdentity {
        self.logger.info("Verifying an identity.")

        let input = GraphQL.VerifyIdentityInput(
            verificationMethod: VerificationMethod.knowledgeOfPii.rawValue,
            firstName: input.firstName,
            lastName: input.lastName,
            address: input.address,
            city: input.city,
            state: input.state,
            postalCode: input.postalCode,
            country: input.country,
            dateOfBirth: input.dateOfBirth
        )

        do {
            let (result, error) = try await self.graphQLClient.perform(mutation: GraphQL.VerifyIdentityMutation(input: input))

            if let error = error {
                throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
            }

            guard let result = result else {
                throw SudoIdentityVerificationClientError.fatalError(description: "Query returned nil result.")
            }

            if let error = result.errors?.first {
                self.logger.error("Mutation failed with errors: \(error)")
                throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
            }

            guard let verifiedIdentity = result.data?.verifyIdentity else {
                throw SudoIdentityVerificationClientError.fatalError(description: "Mutation result did not contain required object.")
            }

            var verifiedAt: Date?
            if let verifiedAtEpochMs = verifiedIdentity.verifiedAtEpochMs {
                verifiedAt = Date(millisecondsSinceEpoch: verifiedAtEpochMs)
            }

            return VerifiedIdentity(
                owner: verifiedIdentity.owner,
                verified: verifiedIdentity.verified,
                verifiedAt: verifiedAt,
                verificationMethod: verifiedIdentity.verificationMethod,
                canAttemptVerificationAgain: verifiedIdentity.canAttemptVerificationAgain,
                idScanUrl: verifiedIdentity.idScanUrl
            )
        } catch let error as ApiOperationError {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func verifyIdentityDocument(input: VerifyIdentityDocumentInput) async throws -> VerifiedIdentity {
        self.logger.info("Verifying an identity document")
        let input = GraphQL.VerifyIdentityDocumentInput(
            verificationMethod: VerificationMethod.governmentId.rawValue,
            imageBase64: input.image.base64EncodedString(),
            backImageBase64: input.backImage.base64EncodedString(),
            country: input.country,
            documentType: input.documentType.rawValue
        )

        do {
            let (result, error) = try await self.graphQLClient.perform(mutation: GraphQL.VerifyIdentityDocumentMutation(input: input))
            if let error = error {
                throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
            }
            guard let result = result else {
                throw SudoIdentityVerificationClientError.fatalError(description: "Query returned nil result.")
            }
            if let error = result.errors?.first {
                self.logger.error("Mutation failued with errors: \(error)")
                throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
            }
            guard let verifiedIdentity = result.data?.verifyIdentityDocument else {
                throw SudoIdentityVerificationClientError.fatalError(description: "Mutation result did not contain required")
            }
            var verifiedAt: Date?
            if let verifiedAtEpochMs = verifiedIdentity.verifiedAtEpochMs {
                verifiedAt = Date(millisecondsSinceEpoch: verifiedAtEpochMs)
            }
            return VerifiedIdentity(
                owner: verifiedIdentity.owner,
                verified: verifiedIdentity.verified,
                verifiedAt: verifiedAt,
                verificationMethod: verifiedIdentity.verificationMethod,
                canAttemptVerificationAgain: verifiedIdentity.canAttemptVerificationAgain,
                idScanUrl: verifiedIdentity.idScanUrl
            )
        } catch let error as ApiOperationError {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func checkIdentityVerification(option: QueryOption) async throws -> VerifiedIdentity {
        self.logger.info("Checking the identity verification status.")

        let cachePolicy: CachePolicy
        switch option {
        case .cacheOnly:
            cachePolicy = .returnCacheDataDontFetch
        case .remoteOnly:
            cachePolicy = .fetchIgnoringCacheData
        }

        do {
            let (result, error) = try await self.graphQLClient.fetch(
                query: GraphQL.CheckIdentityVerificationQuery(),
                cachePolicy: cachePolicy
            )

            if let error = error {
                throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
            }

            guard let result = result else {
                throw SudoIdentityVerificationClientError.fatalError(description: "Query returned nil result.")
            }

            if let error = result.errors?.first {
                self.logger.error("Query failed with errors: \(error)")
                throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
            }

            guard let verifiedIdentity = result.data?.checkIdentityVerification else {
                throw SudoIdentityVerificationClientError.verificationResultNotFound
            }

            var verifiedAt: Date?
            if let verifiedAtEpochMs = verifiedIdentity.verifiedAtEpochMs {
                verifiedAt = Date(millisecondsSinceEpoch: verifiedAtEpochMs)
            }

            return VerifiedIdentity(
                owner: verifiedIdentity.owner,
                verified: verifiedIdentity.verified,
                verifiedAt: verifiedAt,
                verificationMethod: verifiedIdentity.verificationMethod,
                canAttemptVerificationAgain: verifiedIdentity.canAttemptVerificationAgain,
                idScanUrl: verifiedIdentity.idScanUrl
            )
        } catch let error as ApiOperationError {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func reset() throws {
        self.logger.info("Resetting client state.")

        try self.graphQLClient.clearCaches(options: .init(clearQueries: true, clearMutations: true, clearSubscriptions: true))
    }

}
