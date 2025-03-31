//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Represents identity document capture initiation details obtained via `initiateIdentityDocumentCapture` API.
public struct IdentityDocumentCaptureInitiationInfo {

    /// URL for uploading identity document information.
    public let documentCaptureUrl: String

    /// When the document capture URL is no longer usable.
    public let expiryAt: Date

    init(
        documentCaptureUrl: String,
        expiryAtEpochSeconds: Double
    ) {
        self.documentCaptureUrl = documentCaptureUrl
        self.expiryAt = Date(timeIntervalSince1970: expiryAtEpochSeconds)
    }

}
