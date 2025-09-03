//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

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
    /// - Parameter input: Preferred content type and locale.
    /// - Returns: Consent content.
    func getIdentityDataProcessingConsentContent(input: IdentityDataProcessingConsentContentInput) async throws -> IdentityDataProcessingConsentContent

    /// Retrieves the current consent status for identity data processing.
    /// - Returns: Consent status.
    func getIdentityDataProcessingConsentStatus() async throws -> IdentityDataProcessingConsentStatus

    /// Provides consent for identity data processing.
    /// - Parameter input: Consent content, type, and locale.
    /// - Returns: Consent response.
    func provideIdentityDataProcessingConsent(input: IdentityDataProcessingConsentInput) async throws -> IdentityDataProcessingConsentResponse

    /// Withdraws consent for identity data processing.
    /// - Returns: Consent response.
    func withdrawIdentityDataProcessingConsent() async throws -> IdentityDataProcessingConsentResponse
}
