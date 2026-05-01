//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Status of ID document verification
public enum DocumentVerificationStatus: Hashable, Sendable {

    /// ID document is not required
    case notRequired

    /// ID document is required but has not yet uploaded
    case notAttempted

    /// capture URL has been generated but not opened
    case captureInitiated

    /// capture URL has been opened but documents not yet submitted
    case captureLinkOpened

    /// capture URL has been opened too many times as per provider
    case captureRetryLimitExceeded

    /// capture URL was not opened within the allowed time window
    case captureLinkTimeout

    /// capture URL was never opened and has expired
    case captureLinkExpired

    /// ID document images have been uploaded and is being processed
    case pending

    /// ID document images are unable to be read. For example the may be too small,
    /// too large, too dim, too bright, have reflections, incomplete
    case documentUnreadable

    /// ID document images could not be verified
    case failed

    /// ID document images were successfully verified
    case succeeded

    /// Unknown document verification status returned from service. Upgrade required.
    case unknown(String)

    // MARK: - Lifecycle

    /// Initialise an instance of `DocumentVerificationStatus`.
    init(_ documentVerificationStatus: String) {
        switch documentVerificationStatus {
        case "notRequired":
            self = .notRequired
        case "notAttempted":
            self = .notAttempted
        case "captureInitiated":
            self = .captureInitiated
        case "captureLinkOpened":
            self = .captureLinkOpened
        case "captureRetryLimitExceeded":
            self = .captureRetryLimitExceeded
        case "captureLinkTimeout":
            self = .captureLinkTimeout
        case "captureLinkExpired":
            self = .captureLinkExpired
        case "pending":
            self = .pending
        case "documentUnreadable":
            self = .documentUnreadable
        case "failed":
            self = .failed
        case "succeeded":
            self = .succeeded
        default:
            self = .unknown(documentVerificationStatus)
        }
    }
}
