//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
import SudoApiClient

/// The generated selection set accessors force cast enum fields to their enum type, but a selection set
/// decoded from a service response holds the raw string, so reading an enum field directly crashes.
/// These accessors read the raw value and convert it instead.
/// https://github.com/aws-amplify/amplify-swift/issues/3953
extension GraphQLSelectionSet {

    // MARK: - Helpers

    func getEnumValue<T: GraphQLEnum>(_ type: T.Type) -> T {
        if let typedValue = snapshot[type.key] as? T {
            return typedValue
        } else if let rawValue = snapshot[type.key] as? T.RawValue {
            return T(rawValue: rawValue) ?? type.getDefaultValue(from: rawValue)
        } else {
            return type.getDefaultValue(from: nil)
        }
    }

    func getEnumArrayValue<T: GraphQLEnum>(_ type: T.Type) -> [T] {
        if let typedValues = snapshot[type.key] as? [T] {
            return typedValues
        }
        guard let rawValues = snapshot[type.key] as? [T.RawValue] else {
            return []
        }
        return rawValues.map { T(rawValue: $0) ?? type.getDefaultValue(from: $0) }
    }

    // MARK: - Getters

    func getAppleVerifyWithWalletDocumentType() -> GraphQL.AppleVerifyWithWalletDocumentType {
        getEnumValue(GraphQL.AppleVerifyWithWalletDocumentType.self)
    }

    func getAppleVerifyWithWalletElements() -> [GraphQL.AppleVerifyWithWalletElement] {
        getEnumArrayValue(GraphQL.AppleVerifyWithWalletElement.self)
    }

    func getAppleVerifyWithWalletIntentToStore() -> GraphQL.AppleVerifyWithWalletIntentToStore {
        getEnumValue(GraphQL.AppleVerifyWithWalletIntentToStore.self)
    }
}

protocol GraphQLEnum: RawRepresentable {
    static var key: String { get }
    static func getDefaultValue(from rawValue: Self.RawValue?) -> Self
}

extension GraphQL.AppleVerifyWithWalletDocumentType: GraphQLEnum {
    static var key: String { "documentType" }
    static func getDefaultValue(from rawValue: Self.RawValue?) -> Self {
        .unknown(rawValue ?? "")
    }
}

extension GraphQL.AppleVerifyWithWalletElement: GraphQLEnum {
    static var key: String { "elements" }
    static func getDefaultValue(from rawValue: Self.RawValue?) -> Self {
        .unknown(rawValue ?? "")
    }
}

extension GraphQL.AppleVerifyWithWalletIntentToStore: GraphQLEnum {
    static var key: String { "intentToStore" }
    static func getDefaultValue(from rawValue: Self.RawValue?) -> Self {
        .unknown(rawValue ?? "")
    }
}
