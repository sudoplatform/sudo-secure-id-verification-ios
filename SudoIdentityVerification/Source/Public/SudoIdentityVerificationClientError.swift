//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoApiClient

public enum SudoIdentityVerificationClientError: Error, Equatable {

    /// The Verified Identity attempted to be accessed does not exist or cannot be found.
    case identityVerificationRecordNotFound

    /// An attempt to update the Verified Identity has failed.
    case identityVerificationUpdateFailed

    /// The method used for verification is unsupported.
    case unsupportedVerificationMethod

    /// An implausible age was input for verification.
    case implausibleAge

    /// An invalid age was input for verification.
    case invalidAge

    /// An unsupported country was associated with an identity to be verified.
    case unsupportedCountry

    /// An identity verification attempt originated from an unsupported network location.
    case unsupportedNetworkLocation

    /// Indicates that bad data was found in cache or in backend response.
    case badData

    ///  Indicates the identity could not be verified based on the input provided.
    case identityNotVerified

    ///  Indicates the identity verification result cannot be found for the user.
    case verificationResultNotFound

    /// Indicates that an attempt to register was made but there's already one in progress.
    case registerOperationAlreadyInProgress

    /// Indicates the client has not been registered to the Sudo platform backend.
    case notRegistered

    /// Indicates that the configuration dictionary passed to initialize the client was not valid.
    case invalidConfig

    /// Indicates that the input to the API was invalid.
    case invalidInput

    /// Indicates the requested operation failed because the user account is locked.
    case accountLocked

    /// Indicates the API being called requires the client to sign in.
    case notSignedIn

    /// Indicates that the request operation failed due to authorization error. This maybe due to the authentication
    /// token being invalid or other security controls that prevent the user from accessing the API.
    case notAuthorized

    /// Indicates API call failed due to it requiring tokens to be refreshed but something else is already in
    /// middle of refreshing the tokens.
    case refreshTokensOperationAlreadyInProgress

    /// Indicates API call  failed due to it exceeding some limits imposed for the API.
    case limitExceeded

    /// Indicates that the user does not have sufficient entitlements to perform the requested operation.
    case insufficientEntitlements

    /// Indicates the version of the record that is getting updated does not match the current version of the record stored
    /// in the backend. The caller should retrieve the current version of the record and reconcile the difference.
    case versionMismatch

    /// Indicates that an internal server error caused the operation to fail. The error is possibly transient and
    /// retrying at a later time may cause the operation to complete successfully
    case serviceError

    /// Indicates that the request failed due to connectivity, availability or access error.
    case requestFailed(response: HTTPURLResponse?, cause: Error?)

    /// Indicates that there were too many attempts at sending API requests within a short period of time.
    case rateLimitExceeded

    /// Indicates that a GraphQL error was returned by the backend.
    case graphQLError(description: String)

    /// Indicates that a fatal error occurred. This could be due to coding error, out-of-memory condition or other
    /// conditions that is beyond control of `SudoIdentityVerificationClient` implementation.
    case fatalError(description: String)

    // MARK: - Conformance: Equatable

    public static func == (lhs: SudoIdentityVerificationClientError, rhs: SudoIdentityVerificationClientError) -> Bool {
        switch (lhs, rhs) {
        case (.requestFailed(let lhsResponse, let lhsCause), requestFailed(let rhsResponse, let rhsCause)):
            if let lhsResponse = lhsResponse, let rhsResponse = rhsResponse {
                return lhsResponse.statusCode == rhsResponse.statusCode
            }
            return type(of: lhsCause) == type(of: rhsCause)
        case (.accountLocked, .accountLocked),
             (.badData, .badData),
             (.fatalError, .fatalError),
             (.graphQLError, .graphQLError),
             (.identityNotVerified, .identityNotVerified),
             (.identityVerificationRecordNotFound, .identityVerificationRecordNotFound),
             (.identityVerificationUpdateFailed, .identityVerificationUpdateFailed),
             (.implausibleAge, .implausibleAge),
             (.insufficientEntitlements, .insufficientEntitlements),
             (.invalidAge, .invalidAge),
             (.invalidConfig, .invalidConfig),
             (.invalidInput, .invalidInput),
             (.limitExceeded, .limitExceeded),
             (.notAuthorized, .notAuthorized),
             (.notRegistered, .notRegistered),
             (.notSignedIn, .notSignedIn),
             (.rateLimitExceeded, .rateLimitExceeded),
             (.refreshTokensOperationAlreadyInProgress, .refreshTokensOperationAlreadyInProgress),
             (.registerOperationAlreadyInProgress, .registerOperationAlreadyInProgress),
             (.serviceError, .serviceError),
             (.unsupportedCountry, .unsupportedCountry),
             (.unsupportedNetworkLocation, .unsupportedNetworkLocation),
             (.unsupportedVerificationMethod, .unsupportedVerificationMethod),
             (.verificationResultNotFound, .verificationResultNotFound),
             (.versionMismatch, .versionMismatch):
            return true
        default:
            return false
        }
    }
}

extension SudoIdentityVerificationClientError {

    struct Constants {
        static let errorType = "errorType"
        static let recordNotFoundError = "sudoplatform.identity-verification.IdentityVerificationRecordNotFoundError"
        static let updateFailedError = "sudoplatform.identity-verification.IdentityVerificationUpdateFailedError"
        static let unsupportedVerificationMethodError = "sudoplatform.identity-verification.UnsupportedVerificationMethodError"
        static let implausibleAgeError = "sudoplatform.identity-verification.ImplausibleAgeError"
        static let invalidAgeError = "sudoplatform.identity-verification.InvalidAgeError"
        static let unsupportedCountryError = "sudoplatform.identity-verification.UnsupportedCountryError"
        static let unsupportedNetworkLocationError = "sudoplatform.identity-verification.UnsupportedNetworkLocationError"
    }

    static func fromApiOperationError(error: Error) -> SudoIdentityVerificationClientError { // swiftlint:disable:this cyclomatic_complexity
        switch error {
        case ApiOperationError.accountLocked:
            return .accountLocked
        case ApiOperationError.notSignedIn:
            return .notSignedIn
        case ApiOperationError.notAuthorized:
            return .notAuthorized
        case ApiOperationError.refreshTokensOperationAlreadyInProgress:
            return .refreshTokensOperationAlreadyInProgress
        case ApiOperationError.limitExceeded:
            return .limitExceeded
        case ApiOperationError.insufficientEntitlements:
            return .insufficientEntitlements
        case ApiOperationError.serviceError:
            return .serviceError
        case ApiOperationError.versionMismatch:
            return .versionMismatch
        case ApiOperationError.invalidRequest:
            return .invalidInput
        case ApiOperationError.rateLimitExceeded:
            return .rateLimitExceeded
        case ApiOperationError.graphQLError(let cause):
            guard let errorType = cause[Constants.errorType] as? String else {
              return .fatalError(description: "GraphQL operation failed but error type was not found in the response. \(error)")
            }
            switch errorType {
            case Constants.recordNotFoundError:
                return .identityVerificationRecordNotFound
            case Constants.updateFailedError:
                return .identityVerificationUpdateFailed
            case Constants.unsupportedVerificationMethodError:
                return .unsupportedVerificationMethod
            case Constants.implausibleAgeError:
                return .implausibleAge
            case Constants.invalidAgeError:
                return .invalidAge
            case Constants.unsupportedCountryError:
                return .unsupportedCountry
            case Constants.unsupportedNetworkLocationError:
                return .unsupportedNetworkLocation
            default:
                return graphQLError(description: "Unexpected GraphQL error: \(cause)")
            }
        case ApiOperationError.requestFailed(let response, let cause):
            return .requestFailed(response: response, cause: cause)
        default:
            return .fatalError(description: "Unexpected API operation error: \(error)")
        }
    }

}
