//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import PassKit

/// Presentation request issued by the service for the Apple Verify with Wallet flow.
typealias AppleVerifyWithWalletFlowRequest = GraphQL.InitiateDigitalCredentialVerificationMutation
    .Data.InitiateDigitalCredentialVerification.Flow.AsAppleVerifyWithWalletFlowRequest

/// Builds the Wallet identity request for an Apple Verify with Wallet presentation request.
///
/// The service states which document types, elements and storage intent to request; the SDK expresses
/// them as PassKit types. A document type the SDK cannot request is skipped, since any one requested
/// document is acceptable. An element or storage intent the SDK cannot express is rejected rather than
/// dropped, so the Wallet never discloses less than the service asked for.
enum WalletIdentityRequestBuilder {

    /// - Throws: `SudoIdentityVerificationClientError.badData` if the nonce is not base64 encoded.
    /// - Throws: `SudoIdentityVerificationClientError.unsupportedDigitalCredentialRequest` if the
    ///   request contains a value the SDK cannot express.
    static func request(for flowRequest: AppleVerifyWithWalletFlowRequest, merchantIdentifier: String) throws -> PKIdentityRequest {
        guard let nonce = Data(base64Encoded: flowRequest.nonce) else {
            throw SudoIdentityVerificationClientError.badData
        }
        let request = PKIdentityRequest()
        request.descriptor = try descriptor(for: flowRequest.documentRequests)
        request.nonce = nonce
        request.merchantIdentifier = merchantIdentifier
        return request
    }

    /// Builds the descriptor for the requested documents. More than one document request means any one
    /// of those documents is acceptable, so a document type this SDK version or OS cannot request is
    /// skipped, and the request fails only if none remain.
    static func descriptor(
        for documentRequests: [AppleVerifyWithWalletFlowRequest.DocumentRequest]
    ) throws -> any PKIdentityDocumentDescriptor {
        var descriptors: [any PKIdentityDocumentDescriptor] = []
        var unrequestableDocumentTypes: [String] = []
        for documentRequest in documentRequests {
            guard let descriptor = try descriptor(for: documentRequest) else {
                unrequestableDocumentTypes.append(documentRequest.getAppleVerifyWithWalletDocumentType().rawValue)
                continue
            }
            descriptors.append(descriptor)
        }
        guard let firstDescriptor = descriptors.first else {
            let description = unrequestableDocumentTypes.isEmpty
                ? "Digital credential request did not contain any document requests."
                : "None of the requested document types (\(unrequestableDocumentTypes.joined(separator: ", "))) "
                    + "can be requested by this version of the SDK on this version of iOS."
            throw SudoIdentityVerificationClientError.unsupportedDigitalCredentialRequest(description: description)
        }
        guard descriptors.count > 1 else {
            return firstDescriptor
        }
        // PKIdentityAnyOfDescriptor is only declared by the iOS 26 SDK, which ships with Swift 6.2.
        #if compiler(>=6.2)
        if #available(iOS 26.0, *) {
            return PKIdentityAnyOfDescriptor(descriptors: descriptors)
        }
        #endif
        // Any one of the requested documents is acceptable, so where several cannot be offered together
        // the first is requested alone.
        return firstDescriptor
    }

    /// - Returns: The descriptor for the document request, or nil if its document type cannot be
    ///   requested by this version of the SDK on this version of iOS.
    /// - Throws: `SudoIdentityVerificationClientError.unsupportedDigitalCredentialRequest` if a
    ///   requested element or storage intent cannot be expressed. Requesting the document without them
    ///   would disclose less than the service needs.
    private static func descriptor(
        for documentRequest: AppleVerifyWithWalletFlowRequest.DocumentRequest
    ) throws -> (any PKIdentityDocumentDescriptor)? {
        guard let descriptor = emptyDescriptor(for: documentRequest.getAppleVerifyWithWalletDocumentType()) else {
            return nil
        }
        let elements = try documentRequest.getAppleVerifyWithWalletElements().map { try element(for: $0) }
        guard !elements.isEmpty else {
            throw SudoIdentityVerificationClientError.unsupportedDigitalCredentialRequest(
                description: "Digital credential request did not contain any document elements."
            )
        }
        let intentToStore = try intentToStore(for: documentRequest.getAppleVerifyWithWalletIntentToStore())
        descriptor.addElements(elements, intentToStore: intentToStore)
        return descriptor
    }

    private static func emptyDescriptor(
        for documentType: GraphQL.AppleVerifyWithWalletDocumentType
    ) -> (any PKIdentityDocumentDescriptor)? {
        switch documentType {
        case .driversLicense:
            return PKIdentityDriversLicenseDescriptor()
        case .photoId:
            // PKIdentityPhotoIDDescriptor is only declared by the iOS 26 SDK, which ships with Swift 6.2.
            #if compiler(>=6.2)
            if #available(iOS 26.0, *) {
                return PKIdentityPhotoIDDescriptor()
            }
            #endif
            return nil
        case .unknown:
            return nil
        }
    }

    /// Wallet elements are coarser than the underlying ISO 18013-5 data elements, so one element can
    /// disclose several claims.
    private static func element(for element: GraphQL.AppleVerifyWithWalletElement) throws -> PKIdentityElement {
        switch element {
        case .givenName:
            return .givenName
        case .familyName:
            return .familyName
        case .dateOfBirth:
            return .dateOfBirth
        case .address:
            return .address
        case .issuingAuthority:
            return .issuingAuthority
        case .unknown(let element):
            throw SudoIdentityVerificationClientError.unsupportedDigitalCredentialRequest(
                description: "Document element \"\(element)\" is not supported by this version of the SDK."
            )
        }
    }

    /// The Wallet shows the storage intent to the user before they consent to disclosure.
    private static func intentToStore(for intentToStore: GraphQL.AppleVerifyWithWalletIntentToStore) throws -> PKIdentityIntentToStore {
        switch intentToStore {
        case .willNotStore:
            return .willNotStore
        case .mayStore:
            return .mayStore
        case .unknown(let intentToStore):
            throw SudoIdentityVerificationClientError.unsupportedDigitalCredentialRequest(
                description: "Storage intent \"\(intentToStore)\" is not supported by this version of the SDK."
            )
        }
    }
}
