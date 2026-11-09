//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input for verifyIdentity(input:)
public struct VerifyIdentityInput: Hashable, Sendable {

    /// First name. Case insensitive.
    public let firstName: String

    /// Last name. Case insensitive.
    public let lastName: String

    /// Address. Case insensitive.
    public let address: String

    /// City. Case insensitive.
    public let city: String?

    /// State. This is abbreviated name for the state, e.g. ‘NY’ not ‘New York’.
    public let state: String?

    /// Postal code.
    public let postalCode: String

    /// ISO 3166-1 alpha-2 country code. Must be one of countries retrieved via `getSupportedCountries` API.
    public let country: String

    /// Date of birth formatted in "yyyy-MM-dd"
    public let dateOfBirth: String

    public init(
        firstName: String,
        lastName: String,
        address: String,
        city: String?,
        state: String?,
        postalCode: String,
        country: String,
        dateOfBirth: String
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.city = city
        self.state = state
        self.postalCode = postalCode
        self.country = country
        self.dateOfBirth = dateOfBirth
    }

}

/// Input for verifyIdentityDocument(input:)
public struct VerifyIdentityDocumentInput: Hashable, Sendable {

    /// Image of front of government ID document.
    public let image: Data

    /// Image of back of government ID document.
    public let backImage: Data

    /// Image of person's face, for comparison with ID.
    public let faceImage: Data?

    /// ISO 3166-1 alpha-2 country code, e.g US.
    public let country: String

    /// Type of ID document being presented.
   public let documentType: IdDocumentType

    public init(image: Data, backImage: Data, faceImage: Data?, country: String, documentType: IdDocumentType) {
        self.image = image
        self.backImage = backImage
        self.faceImage = faceImage
        self.country = country
        self.documentType = documentType
    }

}

/// Input for verifyIdentityWithDigitalCredential(input:)
public struct VerifyIdentityWithDigitalCredentialInput: Hashable, Sendable {

    /// Merchant identifier agreed with Apple for identity document requests. Must match one of the
    /// merchant identifiers in the calling application's identity document request entitlement, as
    /// well as the merchant identifier the identity verification service is configured with.
    public let merchantIdentifier: String

    /// Apple Developer team identifier of the calling application. The Wallet binds the team
    /// identifier of the requesting application into its response, so the service needs it to verify
    /// that response. Must be one of the team identifiers the service permits.
    public let teamId: String

    public init(merchantIdentifier: String, teamId: String) {
        self.merchantIdentifier = merchantIdentifier
        self.teamId = teamId
    }

}

/// The user's residential address, supplied for a digital credential that carries none.
public struct ResidentialAddressInput: Hashable, Sendable {

    /// Street address. Case insensitive. Must not be blank.
    public let address: String

    /// City. Case insensitive.
    public let city: String?

    /// State. This is abbreviated name for the state, e.g. ‘NY’ not ‘New York’.
    public let state: String?

    /// Postal code. Must not be blank.
    public let postalCode: String

    /// ISO 3166-1 alpha-2 country code. Must be one of countries retrieved via `listSupportedCountries` API.
    public let country: String

    public init(address: String, city: String? = nil, state: String? = nil, postalCode: String, country: String) {
        self.address = address
        self.city = city
        self.state = state
        self.postalCode = postalCode
        self.country = country
    }

}

/// Input for getIdentityDataProcessingConsentContent(input:)
public struct IdentityDataProcessingConsentContentInput: Hashable, Sendable {
    /// Preferred content type (e.g., "text/plain", "text/html").
    public let preferredContentType: String
    /// Preferred language (e.g., "en-US").
    public let preferredLanguage: String

    public init(preferredContentType: String, preferredLanguage: String) {
        self.preferredContentType = preferredContentType
        self.preferredLanguage = preferredLanguage
    }
}

/// Input for provideIdentityDataProcessingConsent(input:)
public struct IdentityDataProcessingConsentInput: Hashable, Sendable {
    /// Consent content (e.g., the text the user is consenting to).
    public let content: String
    /// Content type (e.g., "text/plain", "text/html").
    public let contentType: String
    /// language (e.g., "en-US").
    public let language: String

    public init(content: String, contentType: String, language: String) {
        self.content = content
        self.contentType = contentType
        self.language = language
    }
}
