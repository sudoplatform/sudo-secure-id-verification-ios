//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
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
    public let verificationMethod: VerificationMethod

    /// Indicates whether or not identity verification can be attempted again for this user. Set to false in
    /// cases where the maximum number of attempts has been reached or a finding from the identity
    /// verification attempt means that it should not proceed.
    public let canAttemptVerificationAgain: Bool

    /// URL to upload the scanned documents for identity verification.
    public let idScanUrl: String?

    /// If identity is not verified, indicates required method of verification that the user
    /// must go through
    public let requiredVerificationMethod: VerificationMethod?

    /// Where required verification method is `GOVERNMENT_ID`, lists the set
    /// of acceptable ID document types that can be presented to verify the
    /// identity
    public let acceptableDocumentTypes: [IdDocumentType]

    /// Indicates the status of verification of submitted ID documents
    public let documentVerificationStatus: DocumentVerificationStatus

    /// Date and time when verification was last attempted for this identity.
    public let verificationLastAttemptedAt: Date?

    /// Number of verification attempts remaining.
    public let attemptsRemaining: Int

    /// Whether consent has been provided for identity data processing.
    public let consented: Bool?

    /// Initializes a `VerifiedIdentity` instance.
    /// 
    /// - Parameters:
    ///   - owner: User ID of the user who provided identity details for verification.
    ///   - verified: Indicates whether or not the identity has been verified.
    ///   - verifiedAt: Date and time at which the identity was verified.
    ///   - verificationMethod: Verification method used.
    ///   - canAttemptVerificationAgain: Indicates whether or not the user can attempt to verify their identity again.
    ///   - idScanUrl: URL to upload the scanned documents for identity verification.
    ///   - requiredVerificationMethod: Required verification method to use if not verified
    ///   - acceptableDocumentTypes: Array of acceptable ID document types if required verification method is GOVERNMENT_ID
    ///   - documentVerificationStatus: Status of ongoing ID document verification
    ///   - verificationLastAttemptedAt: Date and time when verification was last attempted for this identity.
    ///   - attemptsRemaining: Number of verification attempts remaining.
    ///   - consented: Whether consent has been provided for identity data processing
    public init(
        owner: String,
        verified: Bool,
        verifiedAt: Date? = nil,
        verificationMethod: VerificationMethod,
        canAttemptVerificationAgain: Bool,
        idScanUrl: String? = nil,
        requiredVerificationMethod: VerificationMethod? = nil,
        acceptableDocumentTypes: [IdDocumentType] = [],
        documentVerificationStatus: DocumentVerificationStatus = .notRequired,
        verificationLastAttemptedAt: Date? = nil,
        attemptsRemaining: Int,
        consented: Bool? = nil
    ) {
        self.owner = owner
        self.verified = verified
        self.verifiedAt = verifiedAt
        self.verificationMethod = verificationMethod
        self.canAttemptVerificationAgain = canAttemptVerificationAgain
        self.idScanUrl = idScanUrl
        self.requiredVerificationMethod = requiredVerificationMethod
        self.acceptableDocumentTypes = acceptableDocumentTypes
        self.documentVerificationStatus = documentVerificationStatus
        self.verificationLastAttemptedAt = verificationLastAttemptedAt
        self.attemptsRemaining = attemptsRemaining
        self.consented = consented
    }

    internal init(
        owner: String,
        verified: Bool,
        verifiedAtEpochMs: Double,
        verificationMethod: String,
        canAttemptVerificationAgain: Bool,
        idScanUrl: String?,
        requiredVerificationMethod: String?,
        acceptableDocumentTypes: [String],
        documentVerificationStatus: String,
        verificationLastAttemptedAtEpochMs: Double,
        attemptsRemaining: Int,
        consented: Bool?
    ) {
        var verifiedAt: Date?
        if verifiedAtEpochMs != 0 {
            verifiedAt = Date(millisecondsSinceEpoch: verifiedAtEpochMs)
        }

        var verificationLastAttemptedAt: Date?
        if verificationLastAttemptedAtEpochMs != 0 {
            verificationLastAttemptedAt = Date(millisecondsSinceEpoch: verificationLastAttemptedAtEpochMs)
        }

        self.owner = owner
        self.verified = verified
        self.verifiedAt = verifiedAt
        self.verificationMethod = VerificationMethod(verificationMethod)
        self.canAttemptVerificationAgain = canAttemptVerificationAgain
        self.idScanUrl = idScanUrl
        self.requiredVerificationMethod = requiredVerificationMethod != nil ? VerificationMethod(requiredVerificationMethod!) : nil
        self.acceptableDocumentTypes = acceptableDocumentTypes.map { IdDocumentType($0) }
        self.documentVerificationStatus = DocumentVerificationStatus(documentVerificationStatus)
        self.verificationLastAttemptedAt = verificationLastAttemptedAt
        self.attemptsRemaining = attemptsRemaining
        self.consented = consented
    }

}
