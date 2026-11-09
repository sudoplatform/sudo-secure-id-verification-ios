//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// The outcome of presenting a digital credential for identity verification via
/// `verifyIdentityWithDigitalCredential(input:)`.
public enum DigitalCredentialVerificationOutcome: Sendable {

    /// The presentation was processed. The verification result may be unverified.
    case completed(VerifiedIdentity)

    /// The presented credential carries no residential address and the service requires one. Collect
    /// the user's address and pass the pending verification to
    /// `completeDigitalCredentialVerification(pending:address:)` before it expires.
    case residentialAddressRequired(PendingDigitalCredentialVerification)
}

/// A digital credential presentation that the service accepted but cannot complete without the user's
/// residential address.
public struct PendingDigitalCredentialVerification: Sendable {

    /// Base64 encoded encrypted Wallet response, submitted again with the user's address.
    let response: String

    /// When the presentation can no longer be completed. After that, the user must present a credential
    /// again.
    public let expiresAt: Date
}
