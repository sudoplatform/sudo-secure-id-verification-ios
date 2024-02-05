//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public enum VerificationMethod: Hashable {
    case none
    case knowledgeOfPii
    case governmentId
    case unknown(String)

    // MARK: - Lifecycle

    init(_ verificationMethod: String) {
        switch verificationMethod {
        case "NONE":
            self = .none
        case "KNOWLEDGE_OF_PII":
            self = .knowledgeOfPii
        case "GOVERNMENT_ID":
            self = .governmentId
        default:
            self = .unknown(verificationMethod)
        }
    }

    internal func toGraphQL() -> String {
        switch self {
        case .none: return "NONE"
        case .knowledgeOfPii: return "KNOWLEDGE_OF_PII"
        case .governmentId: return "GOVERNMENT_ID"
        case .unknown(let verificationMethod): return verificationMethod
        }
    }
}
