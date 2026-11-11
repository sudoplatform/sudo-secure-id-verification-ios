//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoUser

/// Protocol encapsulating a set of functions for identity verification..
public protocol SudoIdentityVerificationClient: AnyObject {

    /// Retrieves the list of supported countries for identity verification.
    ///
    /// - Returns: List of support countries.
    func listSupportedCountries() async throws -> [String]

    /// Retrieves the flag for whether face image is required with ID document
    /// capture.
    ///
    /// - Returns: Boolean flag.
    func isFaceImageRequiredWithDocumentCapture() async throws -> Bool

    /// Retrieves the flag for whether face image is required with ID document
    /// verification.
    ///
    /// - Returns: Boolean flag.
    func isFaceImageRequiredWithDocumentVerification() async throws -> Bool

    /// Retrieves the flag for whether document capture can be initiated using 
    /// initiateIdentityDocumentCapture().
    ///
    /// - Returns: Boolean flag.
    func isDocumentCaptureInitiationEnabled() async throws -> Bool

    /// Retrieves the flag for whether consent is required in order to perform identity
    /// data processing.
    ///
    /// - Returns: Boolean flag.
    func isConsentRequiredForVerification() async throws -> Bool

    /// Retrieves the flag for whether the service accepts identity verification with a digital
    /// credential using `verifyIdentityWithDigitalCredential(input:)`. This reflects the service
    /// configuration only; it does not indicate whether the device or the user's Wallet can present a
    /// credential.
    ///
    /// - Returns: Boolean flag.
    func isDigitalCredentialVerificationEnabled() async throws -> Bool

    /// Verifies an identity against the known public records and returns a result indicating whether or not the identity
    /// details provided were verified with enough confidence to grant the user access to Sudo platform functions such
    /// as provisioning a virtual card.
    ///
    /// - Parameter input: Input variables for API.
    ///
    /// - Returns: Verification result.
    func verifyIdentity(input: VerifyIdentityInput) async throws -> VerifiedIdentity

    /// Attempts to verify an identity based on provided identity documents.
    ///
    /// - Parameter input: Input variables for API.
    ///
    /// - Returns: Verification result.
    func verifyIdentityDocument(input: VerifyIdentityDocumentInput) async throws -> VerifiedIdentity

    /// Attempts to capture identity information from provided identity documents, then verify
    /// identity using that information.
    ///
    /// - Parameter input: Input variables for API.
    ///
    /// - Returns: Verification result.
    func captureAndVerifyIdentityDocument(input: VerifyIdentityDocumentInput) async throws -> VerifiedIdentity

    /// Verifies an identity using a digital credential, such as a mobile driver's licence or Digital ID,
    /// held in the user's Wallet. Requests a presentation from the service, prompts the user to present
    /// the requested document elements from their Wallet, then submits the encrypted Wallet response to
    /// the service for verification.
    ///
    /// Where the service accepts several document types, the user may present any one of them. Document
    /// types the device cannot request are left out of the Wallet prompt; Digital ID requires iOS 26 or
    /// later.
    ///
    /// A successful verification completes identity verification on its own; the knowledge of PII step
    /// performed by `verifyIdentity(input:)` is not required.
    ///
    /// Where the service requires a residential address and the presented credential carries none, the
    /// outcome is `.residentialAddressRequired`. Collect the user's address and pass the pending
    /// verification to `completeDigitalCredentialVerification(pending:address:)`.
    ///
    /// The calling application requires the identity document request entitlement
    /// (`com.apple.developer.in-app-identity-presentment`) with `merchantIdentifier` among its
    /// merchant identifiers.
    ///
    /// - Parameter input: Input variables for API.
    ///
    /// - Returns: Verification outcome.
    ///
    /// - Throws: `SudoIdentityVerificationClientError`, including:
    ///   - `digitalCredentialUnavailable` if no credential can be requested from the Wallet.
    ///   - `digitalCredentialCancelled` if the user dismissed the Wallet prompt.
    ///   - `digitalCredentialRequestFailed` if the Wallet request failed.
    ///   - `digitalCredentialRequestExpired` if the request expired before a credential was presented.
    ///   - `unsupportedDigitalCredentialRequest` if the service asked for a credential this version of
    ///     the SDK cannot request.
    ///   - `digitalCredentialVerificationFailed` if the presented credential was rejected as malformed
    ///     or not authentic.
    ///   - `digitalCredentialIssuerNotTrusted` if the presented credential's issuer is not trusted.
    ///   - `digitalCredentialNotAccepted` if the presented credential is not of an accepted type.
    ///   - `digitalCredentialNoLongerValid` if the presented credential, or the certificate that signed
    ///     it, has expired or been revoked.
    ///   - `identityAlreadyVerified` if the user's identity is already verified.
    ///   - `identityCaptureRetriesExceeded` if the user has no verification attempts remaining.
    ///   - `unsupportedVerificationMethod` if the service does not accept digital credentials.
    func verifyIdentityWithDigitalCredential(input: VerifyIdentityWithDigitalCredentialInput) async throws -> DigitalCredentialVerificationOutcome

    /// Completes a digital credential verification that requires the user's residential address by
    /// submitting the presentation again with the address. The user does not present a credential
    /// again.
    ///
    /// The service verifies the address against the identity verification provider's records, using
    /// the name and date of birth from the credential.
    ///
    /// - Parameters:
    ///   - pending: The pending verification from a `.residentialAddressRequired` outcome of
    ///     `verifyIdentityWithDigitalCredential(input:)`.
    ///   - address: The user's residential address.
    ///
    /// - Returns: Verification result, which is unverified if the address was not verified.
    ///
    /// - Throws: `SudoIdentityVerificationClientError`, including:
    ///   - `digitalCredentialRequestExpired` if the pending verification has expired; start a new
    ///     verification.
    ///   - `unsupportedCountry` if the address is not in a supported country; it may be corrected and
    ///     submitted again.
    ///   - `invalidInput` if the address omits a required field, or the presentation can no longer be
    ///     completed.
    ///   - `requiredIdentityInformationNotProvided` if the presentation was submitted without an
    ///     address too many times; start a new verification.
    func completeDigitalCredentialVerification(
        pending: PendingDigitalCredentialVerification,
        address: ResidentialAddressInput
    ) async throws -> VerifiedIdentity

    /// Checks the identity verification status of the currently signed in user.
    /// - Returns: Verification result.
    func checkIdentityVerification() async throws -> VerifiedIdentity

    /// Attempts to initiate ID document capture using underlying provider's web
    /// based method.
    ///
    /// - Returns: identity document capture info
    func initiateIdentityDocumentCapture() async throws -> IdentityDocumentCaptureInitiationInfo

    /// Resets any cached data.
    ///
    /// - Throws: `SudoIdentityVerificationClientError`
    func reset() throws

    /// Retrieves the content for identity data processing consent.
    /// - Parameter input: Preferred content type and language (in RFC 5646 format).
    /// - Returns: Consent content.
    func getIdentityDataProcessingConsentContent(input: IdentityDataProcessingConsentContentInput) async throws -> IdentityDataProcessingConsentContent

    /// Retrieves the current consent status for identity data processing.
    /// - Returns: Consent status.
    func getIdentityDataProcessingConsentStatus() async throws -> IdentityDataProcessingConsentStatus

    /// Provides consent for identity data processing.
    /// - Parameter input: Consent content, type, and language.
    /// - Returns: Consent response.
    func provideIdentityDataProcessingConsent(input: IdentityDataProcessingConsentInput) async throws -> IdentityDataProcessingConsentResponse

    /// Withdraws consent for identity data processing.
    /// - Returns: Consent response.
    func withdrawIdentityDataProcessingConsent() async throws -> IdentityDataProcessingConsentResponse

    // MARK: - Sign-In Delegate

    /// Sets an optional delegate to handle sign-in when operations are attempted while not signed in.
    ///
    /// When set, all operations (except subscriptions and initialization) will check sign-in status
    /// and invoke the delegate's `signIn()` method if the user is not signed in. The delegate should
    /// handle the sign-in process and throw an error if sign-in fails or is cancelled. If the delegate
    /// throws an error, that error will be propagated to the caller and the original operation will not be executed.
    ///
    /// - Parameter delegate: A delegate conforming to `SudoPlatformSignInDelegate`. Pass nil to disable sign-in checking.
    ///
    func setSignInDelegate(_ delegate: SudoPlatformSignInDelegate?) async
    
}
