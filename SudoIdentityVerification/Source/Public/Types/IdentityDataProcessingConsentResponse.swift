//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Output type for provideIdentityDataProcessingConsent and withdrawIdentityDataProcessingConsent
public struct IdentityDataProcessingConsentResponse: Hashable {
    /// Whether the consent action was processed successfully.
    public let processed: Bool

    public init(processed: Bool) {
        self.processed = processed
    }
}
