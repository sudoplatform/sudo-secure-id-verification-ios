//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import UIKit

/// Status of ID document verification
public enum DocumentVerificationStatus: Hashable {

    /// ID document is not required
    case notRequired

    /// ID document is required but has not yet uploaded
    case notAttempted

    /// ID document images have been uploaded and is being processed
    case pending

    /// ID document images are unable to be read. For example the may be too small,
    /// too large, too dim, too bright, have reflections, incomplete
    case documentUnreadable

    /// ID document images could not be verified
    case failed

    /// ID document images were successfully verified
    case succeeded

    /// Unkown document verification status returned from service. Upgrade required.
    case unknown(String)

    // MARK: - Lifecycle

    /// Initialise an instance of `DocumentVerificationStatus`.
    init(_ documentVerificationStatus: String) {
        switch documentVerificationStatus {
        case "notRequired":
            self = .notRequired
        case "notAttempted":
            self = .notAttempted
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
