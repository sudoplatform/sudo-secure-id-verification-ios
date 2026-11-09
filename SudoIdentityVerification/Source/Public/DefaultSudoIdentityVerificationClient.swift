//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import PassKit
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

    // Sign-in guard to permit in-line callback for signing in when required
    private let signInGuard: SignInGuard

    /// Requests identity documents from the user's Wallet.
    private let identityDocumentRequester: IdentityDocumentRequester

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
        self.init(sudoUserClient: sudoUserClient, graphQLClient: graphQLClient, logger: logger)
    }

    /// Initializes a new `DefaultSudoIdentityVerificationClient` instance with the specified backend configuration.
    /// - Parameters:
    ///   - sudoUserClient: `SudoUserClient` instance required to issue authentication tokens and perform cryptographic operations.
    ///   - graphQLClient: GraphQL client to use.
    ///   - logger: A logger to use for logging messages. If none provided then a default internal logger will be used.
    convenience public init(
        sudoUserClient: SudoUserClient,
        graphQLClient: SudoApiClient,
        logger: Logger? = nil
    ) {
        self.init(
            sudoUserClient: sudoUserClient,
            graphQLClient: graphQLClient,
            identityDocumentRequester: PassKitIdentityDocumentRequester(),
            logger: logger
        )
    }

    init(
        sudoUserClient: SudoUserClient,
        graphQLClient: SudoApiClient,
        identityDocumentRequester: IdentityDocumentRequester,
        logger: Logger? = nil
    ) {
        self.sudoUserClient = sudoUserClient
        signInGuard = SignInGuard(userClient: sudoUserClient)
        self.graphQLClient = graphQLClient
        self.identityDocumentRequester = identityDocumentRequester
        self.logger = logger ?? Logger.sudoIdentityVerificationClientLogger
    }

    // MARK: - Conformance: SudoIdentityVerificationClient

    public func setSignInDelegate(_ delegate: SudoPlatformSignInDelegate?) async {
        await signInGuard.setDelegate(delegate)
    }

    public func listSupportedCountries() async throws -> [String] {
        logger.info("Retrieving the list of supported countries for identity verification.")
        try await ensureSignedIn()
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
        try await ensureSignedIn()
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
        try await ensureSignedIn()
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
        try await ensureSignedIn()
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

    public func isConsentRequiredForVerification() async throws -> Bool {
        logger.info("Retrieving flag for whether consent for identity data processing is required.")
        try await ensureSignedIn()
        do {
            let result = try await graphQLClient.fetch(query: GraphQL.GetIdentityVerificationCapabilitiesQuery())
            guard let consentRequired = result.getIdentityVerificationCapabilities?.consentRequired else {
                return false
            }
            return consentRequired
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func isDigitalCredentialVerificationEnabled() async throws -> Bool {
        logger.info("Retrieving flag for whether identity verification with a digital credential is enabled.")
        try await ensureSignedIn()
        do {
            let result = try await graphQLClient.fetch(query: GraphQL.GetIdentityVerificationCapabilitiesQuery())
            return result.getIdentityVerificationCapabilities?.canVerifyWithDigitalCredential ?? false
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func verifyIdentity(input: VerifyIdentityInput) async throws -> VerifiedIdentity {
        logger.info("Verifying an identity.")
        try await ensureSignedIn()

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
                verificationLastAttemptedAtEpochMs: verifiedIdentity.verificationLastAttemptedAtEpochMs,
                attemptsRemaining: verifiedIdentity.attemptsRemaining,
                consented: verifiedIdentity.consented
            )
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func verifyIdentityDocument(input: VerifyIdentityDocumentInput) async throws -> VerifiedIdentity {
        logger.info("Verifying an identity document")
        try await ensureSignedIn()
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
                verificationLastAttemptedAtEpochMs: verifiedIdentity.verificationLastAttemptedAtEpochMs,
                attemptsRemaining: verifiedIdentity.attemptsRemaining,
                consented: verifiedIdentity.consented
            )
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func captureAndVerifyIdentityDocument(input: VerifyIdentityDocumentInput) async throws -> VerifiedIdentity {
        logger.info("Capturing an identity document and verifying identity")
        try await ensureSignedIn()
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
                verificationLastAttemptedAtEpochMs: verifiedIdentity.verificationLastAttemptedAtEpochMs,
                attemptsRemaining: verifiedIdentity.attemptsRemaining,
                consented: verifiedIdentity.consented
            )
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func verifyIdentityWithDigitalCredential(
        input: VerifyIdentityWithDigitalCredentialInput
    ) async throws -> DigitalCredentialVerificationOutcome {
        logger.info("Verifying an identity using a digital credential.")
        try await ensureSignedIn()

        let digitalCredentialRequest = try await initiateDigitalCredentialVerification(teamId: input.teamId)
        guard let flowRequest = digitalCredentialRequest.flow.asAppleVerifyWithWalletFlowRequest else {
            throw SudoIdentityVerificationClientError.fatalError(
                description: "Unexpected digital credential flow: \(digitalCredentialRequest.flow.__typename)"
            )
        }
        let walletRequest = try WalletIdentityRequestBuilder.request(for: flowRequest, merchantIdentifier: input.merchantIdentifier)
        let response = try await requestWalletIdentityDocument(walletRequest).base64EncodedString()

        // The service rejects a response for an expired request too, but only with an untyped error.
        let expiresAt = Date(timeIntervalSince1970: digitalCredentialRequest.expiryAtEpochSeconds)
        try ensureNotExpired(expiresAt)

        guard let verifiedIdentity = try await finalizeDigitalCredentialVerification(response: response, address: nil) else {
            return .residentialAddressRequired(PendingDigitalCredentialVerification(response: response, expiresAt: expiresAt))
        }
        return .completed(verifiedIdentity)
    }

    public func completeDigitalCredentialVerification(
        pending: PendingDigitalCredentialVerification,
        address: ResidentialAddressInput
    ) async throws -> VerifiedIdentity {
        logger.info("Completing a digital credential verification with a residential address.")
        try await ensureSignedIn()

        // The service rejects a response for an expired request too, but only with an untyped error.
        try ensureNotExpired(pending.expiresAt)

        guard let verifiedIdentity = try await finalizeDigitalCredentialVerification(response: pending.response, address: address) else {
            // The service only asks for an address when a submission has none.
            throw SudoIdentityVerificationClientError.fatalError(
                description: "Service required a residential address although one was supplied."
            )
        }
        return verifiedIdentity
    }

    public func initiateIdentityDocumentCapture() async throws -> IdentityDocumentCaptureInitiationInfo {
        logger.info("Initiating web based capture of an identity document")
        try await ensureSignedIn()
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
        try await ensureSignedIn()
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
                verificationLastAttemptedAtEpochMs: verifiedIdentity.verificationLastAttemptedAtEpochMs,
                attemptsRemaining: verifiedIdentity.attemptsRemaining,
                consented: verifiedIdentity.consented
            )
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func getIdentityDataProcessingConsentContent(input: IdentityDataProcessingConsentContentInput) async throws -> IdentityDataProcessingConsentContent {
        logger.info("Retrieving identity data processing consent content.")
        try await ensureSignedIn()
        let gqlInput = GraphQL.IdentityDataProcessingConsentContentInput(
            preferredContentType: input.preferredContentType,
            preferredLanguage: input.preferredLanguage
        )
        do {
            let result = try await graphQLClient.fetch(query: GraphQL.GetIdentityDataProcessingConsentContentQuery(input: gqlInput))
            guard let content = result.getIdentityDataProcessingConsentContent else {
                throw SudoIdentityVerificationClientError.fatalError(description: "Query result did not contain consent content.")
            }
            return IdentityDataProcessingConsentContent(
                content: content.content,
                contentType: content.contentType,
                language: content.language
            )
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func getIdentityDataProcessingConsentStatus() async throws -> IdentityDataProcessingConsentStatus {
        logger.info("Retrieving identity data processing consent status.")
        try await ensureSignedIn()
        do {
            let result = try await graphQLClient.fetch(query: GraphQL.GetIdentityDataProcessingConsentStatusQuery())
            guard let status = result.getIdentityDataProcessingConsentStatus else {
                throw SudoIdentityVerificationClientError.fatalError(description: "Query result did not contain consent status.")
            }
            return IdentityDataProcessingConsentStatus(
                consented: status.consented,
                consentedAtEpochMs: status.consentedAtEpochMs,
                consentWithdrawnAtEpochMs: status.consentWithdrawnAtEpochMs,
                content: status.content,
                contentType: status.contentType,
                language: status.language
            )
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func provideIdentityDataProcessingConsent(input: IdentityDataProcessingConsentInput) async throws -> IdentityDataProcessingConsentResponse {
        logger.info("Providing identity data processing consent.")
        try await ensureSignedIn()
        let gqlInput = GraphQL.IdentityDataProcessingConsentInput(
            content: input.content,
            contentType: input.contentType,
            language: input.language
        )
        do {
            let result = try await graphQLClient.perform(mutation: GraphQL.ProvideIdentityDataProcessingConsentMutation(input: gqlInput))
            guard let response = result.provideIdentityDataProcessingConsent else {
                throw SudoIdentityVerificationClientError.fatalError(description: "Mutation result did not contain consent response.")
            }
            return IdentityDataProcessingConsentResponse(processed: response.processed)
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    public func withdrawIdentityDataProcessingConsent() async throws -> IdentityDataProcessingConsentResponse {
        logger.info("Withdrawing identity data processing consent.")
        try await ensureSignedIn()
        do {
            let result = try await graphQLClient.perform(mutation: GraphQL.WithdrawIdentityDataProcessingConsentMutation())
            guard let response = result.withdrawIdentityDataProcessingConsent else {
                throw SudoIdentityVerificationClientError.fatalError(description: "Mutation result did not contain consent response.")
            }
            return IdentityDataProcessingConsentResponse(processed: response.processed)
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
    }

    /// Checks if user is signed in and invokes delegate if needed.
    /// Only performs check if delegate is configured.
    ///
    /// - Throws: Any error thrown by the sign-in delegate
    private func ensureSignedIn() async throws {
        try await signInGuard.ensureSignedIn()
    }
    
    public func reset() throws {
        logger.info("Resetting client state.")
    }

    // MARK: - Helpers: Digital credential verification

    /// Opens a digital credential verification session with the service for the Apple Verify with
    /// Wallet flow.
    /// - Parameter teamId: Apple Developer team identifier of the calling application.
    private func initiateDigitalCredentialVerification(
        teamId: String
    ) async throws -> GraphQL.InitiateDigitalCredentialVerificationMutation.Data.InitiateDigitalCredentialVerification {
        let gqlInput = GraphQL.InitiateDigitalCredentialVerificationInput(flow: .appleVerifyWithWallet, teamId: teamId)
        let result: GraphQL.InitiateDigitalCredentialVerificationMutation.Data
        do {
            result = try await graphQLClient.perform(mutation: GraphQL.InitiateDigitalCredentialVerificationMutation(input: gqlInput))
        } catch {
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
        guard let digitalCredentialRequest = result.initiateDigitalCredentialVerification else {
            throw SudoIdentityVerificationClientError.fatalError(description: "Mutation result did not contain required object.")
        }
        return digitalCredentialRequest
    }

    /// Prompts the user to present the requested identity document from their Wallet.
    /// - Returns: Encrypted document response, decryptable only by the identity verification service.
    private func requestWalletIdentityDocument(_ request: PKIdentityRequest) async throws -> Data {
        guard let descriptor = request.descriptor, await identityDocumentRequester.canRequestDocument(descriptor) else {
            throw SudoIdentityVerificationClientError.digitalCredentialUnavailable
        }
        do {
            return try await identityDocumentRequester.requestDocument(request)
        } catch let error as PKIdentityError {
            switch error.code {
            case .cancelled:
                throw SudoIdentityVerificationClientError.digitalCredentialCancelled
            case .notSupported, .regionNotSupported:
                throw SudoIdentityVerificationClientError.digitalCredentialUnavailable
            default:
                throw SudoIdentityVerificationClientError.digitalCredentialRequestFailed(cause: error)
            }
        } catch {
            throw SudoIdentityVerificationClientError.digitalCredentialRequestFailed(cause: error)
        }
    }

    /// Submits a Wallet response to the service, with the user's residential address if given.
    /// - Parameters:
    ///   - response: Base64 encoded encrypted Wallet response.
    ///   - address: The user's residential address.
    /// - Returns: The verification result, or nil if the service requires a residential address that
    ///   the credential does not carry and none was given. The response may then be submitted again
    ///   with an address.
    private func finalizeDigitalCredentialVerification(
        response: String,
        address: ResidentialAddressInput?
    ) async throws -> VerifiedIdentity? {
        let gqlAddress = address.map {
            GraphQL.DigitalCredentialResidentialAddressInput(
                address: $0.address,
                city: $0.city,
                country: $0.country,
                postalCode: $0.postalCode,
                state: $0.state
            )
        }
        let gqlInput = GraphQL.FinalizeDigitalCredentialVerificationInput(residentialAddress: gqlAddress, response: response)
        let result: GraphQL.FinalizeDigitalCredentialVerificationMutation.Data
        do {
            result = try await graphQLClient.perform(mutation: GraphQL.FinalizeDigitalCredentialVerificationMutation(input: gqlInput))
        } catch {
            let errorType = SudoIdentityVerificationClientError.graphQLErrorType(of: error)
            if errorType == SudoIdentityVerificationClientError.Constants.digitalCredentialResidentialAddressRequiredError {
                return nil
            }
            throw SudoIdentityVerificationClientError.fromApiOperationError(error: error)
        }
        guard let verifiedIdentity = result.finalizeDigitalCredentialVerification else {
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
            verificationLastAttemptedAtEpochMs: verifiedIdentity.verificationLastAttemptedAtEpochMs,
            attemptsRemaining: verifiedIdentity.attemptsRemaining,
            consented: verifiedIdentity.consented
        )
    }

    private func ensureNotExpired(_ expiresAt: Date) throws {
        guard Date() < expiresAt else {
            throw SudoIdentityVerificationClientError.digitalCredentialRequestExpired
        }
    }
}
