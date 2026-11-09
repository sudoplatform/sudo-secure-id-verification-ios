//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
import SudoApiClient

public enum SudoIdentityVerificationClientError: Error, Equatable, @unchecked Sendable {

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

    /// An identity verification attempt was initiated with insufficient information.
    case requiredIdentityInformationNotProvided

    /// Indicates that bad data was found in cache or in backend response.
    case badData

    ///  Indicates the identity could not be verified based on the input provided.
    case identityNotVerified

    ///  Indicates the identity verification result cannot be found for the user.
    case verificationResultNotFound

    /// Identity verification has already been completed.
    case identityAlreadyVerified

    /// Identity document capture attempts has been exceeded.
    case identityCaptureRetriesExceeded

    /// Identity document capture additional attempts has been prevented.
    case identityCaptureRetryBlocked

    /// Identity data retrieval attempted for a user whose data has been redacted due to policy or is no longer available.
    case identityDataRedacted

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
    case requestFailed(response: HTTPURLResponse?, cause: (any Error & Sendable)?)

    /// Indicates that there were too many attempts at sending API requests within a short period of time.
    case rateLimitExceeded

    /// Indicates that an operation requiring consent was attempted, and consent was not granted
    case consentRequired

    /// Indicates a digital credential cannot be requested from the Wallet. The device may not support
    /// identity document requests, the calling application may lack the identity document request
    /// entitlement, or the Wallet may hold no document that satisfies the request.
    case digitalCredentialUnavailable

    /// Indicates the user dismissed the Wallet prompt without presenting a digital credential.
    case digitalCredentialCancelled

    /// Indicates the Wallet request for a digital credential failed before a credential was presented.
    case digitalCredentialRequestFailed(cause: Error?)

    /// Indicates the digital credential request issued by the service expired before a credential was
    /// presented, or before a pending verification was completed. A new verification attempt can be
    /// started.
    case digitalCredentialRequestExpired

    /// Indicates the service asked for a digital credential this version of the SDK cannot request from
    /// the Wallet, because a requested document type, element or storage intent is not one it can
    /// express, or the request needs a later version of iOS.
    case unsupportedDigitalCredentialRequest(description: String)

    /// Indicates the presented digital credential was rejected because the Wallet response is
    /// malformed, not bound to the request it was presented for, or not authentic. A new verification
    /// attempt can be started.
    case digitalCredentialVerificationFailed

    /// Indicates the presented digital credential was issued by an authority the service does not
    /// trust. The credential may be genuine; a credential from a different issuer may be accepted.
    case digitalCredentialIssuerNotTrusted

    /// Indicates the presented digital credential is not of a type the service accepts.
    case digitalCredentialNotAccepted

    /// Indicates the presented digital credential is no longer valid: it has expired, or the
    /// certificate its issuer signed it with has expired or been revoked. The user may be able to
    /// refresh the credential in their Wallet.
    case digitalCredentialNoLongerValid

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
        case (.digitalCredentialRequestFailed(let lhsCause), .digitalCredentialRequestFailed(let rhsCause)):
            return type(of: lhsCause) == type(of: rhsCause)
        case (.accountLocked, .accountLocked),
             (.badData, .badData),
             (.fatalError, .fatalError),
             (.consentRequired, .consentRequired),
             (.digitalCredentialCancelled, .digitalCredentialCancelled),
             (.digitalCredentialIssuerNotTrusted, .digitalCredentialIssuerNotTrusted),
             (.digitalCredentialNoLongerValid, .digitalCredentialNoLongerValid),
             (.digitalCredentialNotAccepted, .digitalCredentialNotAccepted),
             (.digitalCredentialRequestExpired, .digitalCredentialRequestExpired),
             (.digitalCredentialUnavailable, .digitalCredentialUnavailable),
             (.digitalCredentialVerificationFailed, .digitalCredentialVerificationFailed),
             (.graphQLError, .graphQLError),
             (.identityAlreadyVerified, .identityAlreadyVerified),
             (.identityCaptureRetryBlocked, .identityCaptureRetryBlocked),
             (.identityCaptureRetriesExceeded, .identityCaptureRetriesExceeded),
             (.identityDataRedacted, .identityDataRedacted),
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
             (.requiredIdentityInformationNotProvided, .requiredIdentityInformationNotProvided),
             (.serviceError, .serviceError),
             (.unsupportedCountry, .unsupportedCountry),
             (.unsupportedDigitalCredentialRequest, .unsupportedDigitalCredentialRequest),
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
        static let requiredIdentityInformationNotProvided = "sudoplatform.identity-verification.RequiredIdentityInformationNotProvidedError"
        static let identityAlreadyVerifiedError = "sudoplatform.identity-verification.IdentityAlreadyVerifiedError"
        static let identityCaptureRetriesExceededError = "sudoplatform.identity-verification.IdentityCaptureRetriesExceededError"
        static let identityCaptureRetryBlockedError = "sudoplatform.identity-verification.IdentityCaptureRetryBlockedError"
        static let identityDataRedactedError = "sudoplatform.identity-verification.IdentityDataRedactedError"
        static let consentRequiredError = "sudoplatform.identity-verification.ConsentRequiredError"
        static let digitalCredentialVerificationFailedError = "sudoplatform.IV.DigitalCredentialVerificationFailedError"
        static let digitalCredentialIssuerNotTrustedError = "sudoplatform.IV.DigitalCredentialIssuerNotTrustedError"
        static let digitalCredentialNotAcceptedError = "sudoplatform.IV.DigitalCredentialNotAcceptedError"
        static let digitalCredentialNoLongerValidError = "sudoplatform.IV.DigitalCredentialNoLongerValidError"
        static let digitalCredentialResidentialAddressRequiredError = "sudoplatform.IV.DigitalCredentialResidentialAddressRequiredError"
    }

    /// The service error type carried by a GraphQL error, if `error` is one.
    static func graphQLErrorType(of error: Error) -> String? {
        guard
            case ApiOperationError.graphQLError(let underlyingError) = error,
            let graphQLError = underlyingError as? GraphQLError
        else {
            return nil
        }
        return graphQLError.extensions?[Constants.errorType]?.stringValue
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
        case ApiOperationError.graphQLError(let underlyingError):
            guard
                let graphQLError = underlyingError as? GraphQLError,
                let errorType = graphQLError.extensions?[Constants.errorType]?.stringValue
            else {
                return .fatalError(
                    description: "GraphQL operation failed but error type was not found in the response. \(error.localizedDescription)"
                )
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
            case Constants.requiredIdentityInformationNotProvided:
                return .requiredIdentityInformationNotProvided
            case Constants.identityAlreadyVerifiedError:
                return .identityAlreadyVerified
            case Constants.identityCaptureRetriesExceededError:
                return .identityCaptureRetriesExceeded
            case Constants.identityCaptureRetryBlockedError:
                return .identityCaptureRetryBlocked
            case Constants.identityDataRedactedError:
                return .identityDataRedacted
            case Constants.unsupportedNetworkLocationError:
                return .unsupportedNetworkLocation
            case Constants.consentRequiredError:
                return .consentRequired
            case Constants.digitalCredentialVerificationFailedError:
                return .digitalCredentialVerificationFailed
            case Constants.digitalCredentialIssuerNotTrustedError:
                return .digitalCredentialIssuerNotTrusted
            case Constants.digitalCredentialNotAcceptedError:
                return .digitalCredentialNotAccepted
            case Constants.digitalCredentialNoLongerValidError:
                return .digitalCredentialNoLongerValid
            default:
                return .graphQLError(description: "Unexpected GraphQL error: \(underlyingError.localizedDescription)")
            }
        case ApiOperationError.requestFailed(let response, let cause):
            return .requestFailed(response: response, cause: cause)
        default:
            return .fatalError(description: "Unexpected API operation error: \(error.localizedDescription)")
        }
    }
}
