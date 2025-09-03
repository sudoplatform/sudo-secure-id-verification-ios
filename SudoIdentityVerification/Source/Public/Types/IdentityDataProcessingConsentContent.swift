//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Output type for getIdentityDataProcessingConsentContent(input:)
public struct IdentityDataProcessingConsentContent: Hashable {
    /// The consent content (e.g., the text the user is consenting to).
    public let content: String
    /// Content type (e.g., "text/plain", "text/html").
    public let contentType: String
    /// Locale (e.g., "en-US").
    public let locale: String

    public init(content: String, contentType: String, locale: String) {
        self.content = content
        self.contentType = contentType
        self.locale = locale
    }
}
