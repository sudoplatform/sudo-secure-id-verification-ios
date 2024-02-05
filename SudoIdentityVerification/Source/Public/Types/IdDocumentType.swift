//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import UIKit

/// Type of document used for identity verification.
public enum IdDocumentType: Hashable {
    case driverLicense
    case passport
    case idCard
    case unknown(String)

    // MARK: - Lifecycle

    init(_ idDocumentType: String) {
        switch idDocumentType {
        case "driverLicense":
            self = .driverLicense
        case "passport":
            self = .passport
        case "idCard":
            self = .idCard
        default:
            self = .unknown(idDocumentType)
        }
    }

    internal func toGraphQL() -> String {
        switch self {
        case .driverLicense: return "driverLicense"
        case .passport: return "passport"
        case .idCard: return "idCard"
        case .unknown(let idDocumentType): return idDocumentType
        }
    }
}
