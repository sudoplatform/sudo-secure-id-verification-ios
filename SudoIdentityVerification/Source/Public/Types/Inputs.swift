//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input for verifyIdentity(input:)
public struct VerifyIdentityInput: Hashable {

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
public struct VerifyIdentityDocumentInput: Hashable {

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

/// Input for getIdentityDataProcessingConsentContent(input:)
public struct IdentityDataProcessingConsentContentInput: Hashable {
    /// Preferred content type (e.g., "text/plain", "text/html").
    public let preferredContentType: String
    /// Preferred locale (e.g., "en-US").
    public let preferredLocale: String

    public init(preferredContentType: String, preferredLocale: String) {
        self.preferredContentType = preferredContentType
        self.preferredLocale = preferredLocale
    }
}

/// Input for provideIdentityDataProcessingConsent(input:)
public struct IdentityDataProcessingConsentInput: Hashable {
    /// Consent content (e.g., the text the user is consenting to).
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
