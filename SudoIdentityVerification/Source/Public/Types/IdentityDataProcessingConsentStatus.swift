//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Output type for getIdentityDataProcessingConsentStatus()
public struct IdentityDataProcessingConsentStatus: Hashable {
    /// Whether the user has consented.
    public let consented: Bool
    /// Epoch ms when consent was given, if any.
    public let consentedAtEpochMs: Double?
    /// Epoch ms when consent was withdrawn, if any.
    public let consentWithdrawnAtEpochMs: Double?
    /// The consent content (optional, may be present if consented).
    public let content: String?
    /// Content type (optional).
    public let contentType: String?
    /// Locale (optional).
    public let locale: String?

    public init(
        consented: Bool,
        consentedAtEpochMs: Double?,
        consentWithdrawnAtEpochMs: Double?,
        content: String?,
        contentType: String?,
        locale: String?
    ) {
        self.consented = consented
        self.consentedAtEpochMs = consentedAtEpochMs
        self.consentWithdrawnAtEpochMs = consentWithdrawnAtEpochMs
        self.content = content
        self.contentType = contentType
        self.locale = locale
    }
}
