//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Represents verified identity details obtained via `verifyIdentity` API.
public struct VerifiedIdentity {

    /// User ID of the user who provided identity details for verification.
    public let owner: String

    /// `true` if the identity was verified successfully.
    public let verified: Bool

    /// Date and time at which the identity was verified.
    public let verifiedAt: Date?

    /// Verification method used.
    public let verificationMethod: String

    /// Indicates whether or not the user can attempt to verify their identity again.
    public let canAttemptVerificationAgain: Bool

    /// URL to upload the scanned documents for identity verification.
    public let idScanUrl: String?

    /// Initializes a `VerifiedIdentity` instance.
    /// 
    /// - Parameters:
    ///   - owner: User ID of the user who provided identity details for verification.
    ///   - verified: Indicates whether or not the identity has been verified.
    ///   - verifiedAt: Date and time at which the identity was verified.
    ///   - verificationMethod: Verification method used.
    ///   - canAttemptVerificationAgain: Indicates whether or not the user can attempt to verify their identity again.
    ///   - idScanUrl: URL to upload the scanned documents for identity verification.
    public init(owner: String, verified: Bool, verifiedAt: Date? = nil, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil) {
        self.owner = owner
        self.verified = verified
        self.verifiedAt = verifiedAt
        self.verificationMethod = verificationMethod
        self.canAttemptVerificationAgain = canAttemptVerificationAgain
        self.idScanUrl = idScanUrl
    }

}
