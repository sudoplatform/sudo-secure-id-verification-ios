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

    /// Default logger for the client.
    private let logger: Logger

    /// `SudoUserClient` instance required to issue authentication tokens and perform cryptographic operations.
    private let sudoUserClient: SudoUserClient

    /// GraphQL client for communicating with the identity verification service.
    private let graphQLClient: SudoApiClient

    /// Initializes a new `DefaultSudoIdentityVerificationClient` instance.
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

    /// Initializes a new `DefaultSudoIdentityVerificationClient` instance with the specified backend configuration.
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
                query: GraphQL.GetIdentityVerificationCapabilitiesQuery(),
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

            guard let countryList = result.data?.getIdentityVerificationCapabilities?.supportedCountries else {
                return []
            }

            return countryList
        } catch let error as ApiOperationError {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func isFaceImageRequired() async throws -> Bool {
        self.logger.info("Retrieving flag for requirement to provide face image with ID document.")

        do {
            let (result, error) = try await self.graphQLClient.fetch(
                query: GraphQL.GetIdentityVerificationCapabilitiesQuery(),
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

            guard let faceImageRequired = result.data?.getIdentityVerificationCapabilities?.faceImageRequiredWithDocument else {
                return false
            }

            return faceImageRequired
        } catch let error as ApiOperationError {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func verifyIdentity(input: VerifyIdentityInput) async throws -> VerifiedIdentity {
        self.logger.info("Verifying an identity.")

        let input = GraphQL.VerifyIdentityInput(
            address: input.address,
            city: input.city,
            country: input.country,
            dateOfBirth: input.dateOfBirth,
            firstName: input.firstName,
            lastName: input.lastName,
            postalCode: input.postalCode,
            state: input.state,
            verificationMethod: VerificationMethod.knowledgeOfPii.toGraphQL()
        )

        do {
            let (result, error) = try await self.graphQLClient.perform(mutation: GraphQL.VerifyIdentityMutation(input: input))

            if let error = error {
                throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
            }

            guard let result = result else {
                throw SudoIdentityVerificationClientError.fatalError(description: "Mutation returned nil result.")
            }

            if let error = result.errors?.first {
                self.logger.error("Mutation failed with errors: \(error)")
                throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
            }

            guard let verifiedIdentity = result.data?.verifyIdentity else {
                throw SudoIdentityVerificationClientError.fatalError(description: "Mutation result did not contain required object.")
            }

            return VerifiedIdentity(
                owner: verifiedIdentity.owner,
                verified: verifiedIdentity.verified,
                verifiedAtEpochMs: verifiedIdentity.verifiedAtEpochMs,
                verificationMethod: verifiedIdentity.verificationMethod,
                canAttemptVerificationAgain: verifiedIdentity.canAttemptVerificationAgain,
                idScanUrl: verifiedIdentity.idScanUrl,
                requiredVerificationMethod: verifiedIdentity.requiredVerificationMethod,
                acceptableDocumentTypes: verifiedIdentity.acceptableDocumentTypes,
                documentVerificationStatus: verifiedIdentity.documentVerificationStatus
            )
        } catch let error as ApiOperationError {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func verifyIdentityDocument(input: VerifyIdentityDocumentInput) async throws -> VerifiedIdentity {
        self.logger.info("Verifying an identity document")
        let input = GraphQL.VerifyIdentityDocumentInput(
            backImageBase64: input.backImage.base64EncodedString(),
            country: input.country,
            documentType: input.documentType.toGraphQL(),
            faceImageBase64: input.faceImage?.base64EncodedString(),
            imageBase64: input.image.base64EncodedString(),
            verificationMethod: VerificationMethod.governmentId.toGraphQL()
        )

        do {
            let (result, error) = try await self.graphQLClient.perform(mutation: GraphQL.VerifyIdentityDocumentMutation(input: input))
            if let error = error {
                throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
            }
            guard let result = result else {
                throw SudoIdentityVerificationClientError.fatalError(description: "Mutation returned nil result.")
            }
            if let error = result.errors?.first {
                self.logger.error("Mutation failued with errors: \(error)")
                throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
            }
            guard let verifiedIdentity = result.data?.verifyIdentityDocument else {
                throw SudoIdentityVerificationClientError.fatalError(description: "Mutation result did not contain required")
            }
            return VerifiedIdentity(
                owner: verifiedIdentity.owner,
                verified: verifiedIdentity.verified,
                verifiedAtEpochMs: verifiedIdentity.verifiedAtEpochMs,
                verificationMethod: verifiedIdentity.verificationMethod,
                canAttemptVerificationAgain: verifiedIdentity.canAttemptVerificationAgain,
                idScanUrl: verifiedIdentity.idScanUrl,
                requiredVerificationMethod: verifiedIdentity.requiredVerificationMethod,
                acceptableDocumentTypes: verifiedIdentity.acceptableDocumentTypes,
                documentVerificationStatus: verifiedIdentity.documentVerificationStatus
            )
        } catch let error as ApiOperationError {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func captureAndVerifyIdentityDocument(input: VerifyIdentityDocumentInput) async throws -> VerifiedIdentity {
        self.logger.info("Capturing an identity document and verifying identity")
        let input = GraphQL.VerifyIdentityDocumentInput(
            backImageBase64: input.backImage.base64EncodedString(),
            country: input.country,
            documentType: input.documentType.toGraphQL(),
            faceImageBase64: input.faceImage?.base64EncodedString(),
            imageBase64: input.image.base64EncodedString(),
            verificationMethod: VerificationMethod.governmentId.toGraphQL()
        )

        do {
            let (result, error) = try await self.graphQLClient.perform(mutation: GraphQL.CaptureAndVerifyIdentityDocumentMutation(input: input))
            if let error = error {
                throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
            }
            guard let result = result else {
                throw SudoIdentityVerificationClientError.fatalError(description: "Mutation returned nil result.")
            }
            if let error = result.errors?.first {
                self.logger.error("Mutation failued with errors: \(error)")
                throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
            }
            guard let verifiedIdentity = result.data?.captureAndVerifyIdentityDocument else {
                throw SudoIdentityVerificationClientError.fatalError(description: "Mutation result did not contain required")
            }
            return VerifiedIdentity(
                owner: verifiedIdentity.owner,
                verified: verifiedIdentity.verified,
                verifiedAtEpochMs: verifiedIdentity.verifiedAtEpochMs,
                verificationMethod: verifiedIdentity.verificationMethod,
                canAttemptVerificationAgain: verifiedIdentity.canAttemptVerificationAgain,
                idScanUrl: verifiedIdentity.idScanUrl,
                requiredVerificationMethod: verifiedIdentity.requiredVerificationMethod,
                acceptableDocumentTypes: verifiedIdentity.acceptableDocumentTypes,
                documentVerificationStatus: verifiedIdentity.documentVerificationStatus
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

            return VerifiedIdentity(
                owner: verifiedIdentity.owner,
                verified: verifiedIdentity.verified,
                verifiedAtEpochMs: verifiedIdentity.verifiedAtEpochMs,
                verificationMethod: verifiedIdentity.verificationMethod,
                canAttemptVerificationAgain: verifiedIdentity.canAttemptVerificationAgain,
                idScanUrl: verifiedIdentity.idScanUrl,
                requiredVerificationMethod: verifiedIdentity.requiredVerificationMethod,
                acceptableDocumentTypes: verifiedIdentity.acceptableDocumentTypes,
                documentVerificationStatus: verifiedIdentity.documentVerificationStatus
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
