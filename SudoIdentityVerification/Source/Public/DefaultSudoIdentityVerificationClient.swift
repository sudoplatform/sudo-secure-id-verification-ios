//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoApiClient
import SudoConfigManager
import SudoLogging
import SudoUser

/// Default implementation of `SudoIdentityVerificationClient`.
public class DefaultSudoIdentityVerificationClient: SudoIdentityVerificationClient {

    // MARK: - Supplementary

    struct Config {

        // Configuration namespace.
        struct Namespace {
            static let identityVerificationService = "IdentityVerificationService"
        }
    }

    // MARK: - Properties

    /// Default logger for the client.
    private let logger: Logger

    /// `SudoUserClient` instance required to issue authentication tokens and perform cryptographic operations.
    private let sudoUserClient: SudoUserClient

    /// GraphQL client for communicating with the identity verification service.
    private let graphQLClient: SudoApiClient

    // MARK: - Lifecycle

    /// Initializes a new `DefaultSudoIdentityVerificationClient` instance.
    /// - Parameters:
    ///   - sudoUserClient: `SudoUserClient` instance required to issue authentication tokens and perform cryptographic operations.
    ///   - logger: A logger to use for logging messages. If none provided then a default internal logger will be used.
    /// - Throws: `SudoIdentityVerificationClientError`
    convenience public init(sudoUserClient: SudoUserClient, logger: Logger? = nil) throws {
        guard let graphQLClient = try SudoApiClientManager.instance?.getClient(
            sudoUserClient: sudoUserClient,
            configNamespace: Config.Namespace.identityVerificationService
        ) else {
            throw SudoIdentityVerificationClientError.invalidConfig
        }
        self.init(sudoUserClient: sudoUserClient,  graphQLClient: graphQLClient, logger: logger)
    }

    /// Initializes a new `DefaultSudoIdentityVerificationClient` instance with the specified backend configuration.
    /// - Parameters:
    ///   - sudoUserClient: `SudoUserClient` instance required to issue authentication tokens and perform cryptographic operations.
    ///   - graphQLClient: GraphQL client to use.
    ///   - logger: A logger to use for logging messages. If none provided then a default internal logger will be used.
    public init(
        sudoUserClient: SudoUserClient,
        graphQLClient: SudoApiClient,
        logger: Logger? = nil
    ) {
        self.sudoUserClient = sudoUserClient
        self.graphQLClient = graphQLClient
        self.logger = logger ?? Logger.sudoIdentityVerificationClientLogger
    }

    // MARK: - Conformance: SudoIdentityVerificationClient

    public func listSupportedCountries() async throws -> [String] {
        logger.info("Retrieving the list of supported countries for identity verification.")
        do {
            let result = try await graphQLClient.fetch(query: GraphQL.GetIdentityVerificationCapabilitiesQuery())
            guard let countryList = result.getIdentityVerificationCapabilities?.supportedCountries else {
                return []
            }
            return countryList
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func isFaceImageRequiredWithDocumentCapture() async throws -> Bool {
        logger.info("Retrieving flag for requirement to provide face image with ID document capture.")
        do {
            let result = try await graphQLClient.fetch(query: GraphQL.GetIdentityVerificationCapabilitiesQuery())
            guard let faceImageRequiredWithDocumentCapture = result.getIdentityVerificationCapabilities?.faceImageRequiredWithDocumentCapture else {
                return false
            }
            return faceImageRequiredWithDocumentCapture
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func isFaceImageRequiredWithDocumentVerification() async throws -> Bool {
        logger.info("Retrieving flag for requirement to provide face image with ID document verification.")
        do {
            let result = try await graphQLClient.fetch(query: GraphQL.GetIdentityVerificationCapabilitiesQuery())
            guard let faceImageRequiredWithDocumentVerification = result.getIdentityVerificationCapabilities?.faceImageRequiredWithDocumentVerification else {
                return false
            }
            return faceImageRequiredWithDocumentVerification
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func isDocumentCaptureInitiationEnabled() async throws -> Bool {
        logger.info("Retrieving flag for whether web based identity document capture is enabled.")
        do {
            let result = try await graphQLClient.fetch(query: GraphQL.GetIdentityVerificationCapabilitiesQuery())
            guard let canInitiateDocumentCapture = result.getIdentityVerificationCapabilities?.canInitiateDocumentCapture else {
                return false
            }
            return canInitiateDocumentCapture
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func verifyIdentity(input: VerifyIdentityInput) async throws -> VerifiedIdentity {
        logger.info("Verifying an identity.")

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
            let result = try await graphQLClient.perform(mutation: GraphQL.VerifyIdentityMutation(input: input))
            guard let verifiedIdentity = result.verifyIdentity else {
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
                documentVerificationStatus: verifiedIdentity.documentVerificationStatus,
                verificationLastAttemptedAtEpochMs: verifiedIdentity.verificationLastAttemptedAtEpochMs
            )
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func verifyIdentityDocument(input: VerifyIdentityDocumentInput) async throws -> VerifiedIdentity {
        logger.info("Verifying an identity document")
        let input = GraphQL.VerifyIdentityDocumentInput(
            backImageBase64: input.backImage.base64EncodedString(),
            country: input.country,
            documentType: input.documentType.toGraphQL(),
            faceImageBase64: input.faceImage?.base64EncodedString(),
            imageBase64: input.image.base64EncodedString(),
            verificationMethod: VerificationMethod.governmentId.toGraphQL()
        )
        do {
            let result = try await graphQLClient.perform(mutation: GraphQL.VerifyIdentityDocumentMutation(input: input))
            guard let verifiedIdentity = result.verifyIdentityDocument else {
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
                documentVerificationStatus: verifiedIdentity.documentVerificationStatus,
                verificationLastAttemptedAtEpochMs: verifiedIdentity.verificationLastAttemptedAtEpochMs
            )
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func captureAndVerifyIdentityDocument(input: VerifyIdentityDocumentInput) async throws -> VerifiedIdentity {
        logger.info("Capturing an identity document and verifying identity")
        let input = GraphQL.VerifyIdentityDocumentInput(
            backImageBase64: input.backImage.base64EncodedString(),
            country: input.country,
            documentType: input.documentType.toGraphQL(),
            faceImageBase64: input.faceImage?.base64EncodedString(),
            imageBase64: input.image.base64EncodedString(),
            verificationMethod: VerificationMethod.governmentId.toGraphQL()
        )
        do {
            let result = try await graphQLClient.perform(mutation: GraphQL.CaptureAndVerifyIdentityDocumentMutation(input: input))
            guard let verifiedIdentity = result.captureAndVerifyIdentityDocument else {
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
                documentVerificationStatus: verifiedIdentity.documentVerificationStatus,
                verificationLastAttemptedAtEpochMs: verifiedIdentity.verificationLastAttemptedAtEpochMs
            )
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func initiateIdentityDocumentCapture() async throws -> IdentityDocumentCaptureInitiationInfo {
        logger.info("Initiating web based capture of an identity document")
        do {
            let result = try await graphQLClient.perform(mutation: GraphQL.InitiateIdentityDocumentCaptureMutation())
            guard let identityDocumentCaptureInitiationInfo = result.initiateIdentityDocumentCapture else {
                throw SudoIdentityVerificationClientError.fatalError(description: "Mutation result did not contain required")
            }
            return IdentityDocumentCaptureInitiationInfo(
                documentCaptureUrl: identityDocumentCaptureInitiationInfo.documentCaptureUrl,
                expiryAtEpochSeconds: identityDocumentCaptureInitiationInfo.expiryAtEpochSeconds
            )
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func checkIdentityVerification() async throws -> VerifiedIdentity {
        logger.info("Checking the identity verification status.")
        do {
            let result = try await graphQLClient.fetch(query: GraphQL.CheckIdentityVerificationQuery())
            guard let verifiedIdentity = result.checkIdentityVerification else {
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
                documentVerificationStatus: verifiedIdentity.documentVerificationStatus,
                verificationLastAttemptedAtEpochMs: verifiedIdentity.verificationLastAttemptedAtEpochMs
            )
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func reset() throws {
        logger.info("Resetting client state.")
    }
}
