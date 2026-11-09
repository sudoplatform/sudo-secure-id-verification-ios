//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import PassKit

/// Requests identity documents from the user's Wallet.
protocol IdentityDocumentRequester: AnyObject {

    /// Whether a document matching `descriptor` can be requested, given the device, the calling
    /// application's entitlements and the documents in the user's Wallet.
    func canRequestDocument(_ descriptor: any PKIdentityDocumentDescriptor) async -> Bool

    /// Prompts the user to present the document and elements described by `request`.
    ///
    /// - Returns: The encrypted document response, decryptable only by the verifier the request's
    ///   merchant identifier belongs to.
    /// - Throws: `PKIdentityError` if the request fails or the user declines it.
    func requestDocument(_ request: PKIdentityRequest) async throws -> Data
}

/// `IdentityDocumentRequester` backed by `PKIdentityAuthorizationController`.
final class PassKitIdentityDocumentRequester: IdentityDocumentRequester {

    private let controller = PKIdentityAuthorizationController()

    func canRequestDocument(_ descriptor: any PKIdentityDocumentDescriptor) async -> Bool {
        await controller.canRequestDocument(descriptor)
    }

    func requestDocument(_ request: PKIdentityRequest) async throws -> Data {
        try await controller.requestDocument(request).encryptedData
    }
}
