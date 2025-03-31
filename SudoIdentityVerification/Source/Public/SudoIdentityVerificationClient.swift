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

    /// Retrieves the flag for whether face image is required with ID document.
    ///
    /// - Returns: Boolean flag.
    func isFaceImageRequired() async throws -> Bool

    /// Retrieves the flag for whether document capture can be initiated using 
    /// initiateIdentityDocumentCapture().
    ///
    /// - Returns: Boolean flag.
    func isDocumentCaptureInitiationEnabled() async throws -> Bool

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
    func initiateIdentityDocumentCapture() async throws-> IdentityDocumentCaptureInitiationInfo

    /// Resets any cached data.
    ///
    /// - Throws: `SudoIdentityVerificationClientError`
    func reset() throws

}
