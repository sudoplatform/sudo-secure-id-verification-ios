// swiftlint:disable all
//  This file was automatically generated and should not be edited.

import Amplify
import SudoApiClient

struct GraphQL {

internal struct VerifyIdentityDocumentInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(backImageBase64: String, country: String, documentType: String, faceImageBase64: Optional<String?> = nil, imageBase64: String, verificationMethod: String) {
    graphQLMap = ["backImageBase64": backImageBase64, "country": country, "documentType": documentType, "faceImageBase64": faceImageBase64, "imageBase64": imageBase64, "verificationMethod": verificationMethod]
  }

  internal var backImageBase64: String {
    get {
      return graphQLMap["backImageBase64"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "backImageBase64")
    }
  }

  internal var country: String {
    get {
      return graphQLMap["country"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "country")
    }
  }

  internal var documentType: String {
    get {
      return graphQLMap["documentType"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "documentType")
    }
  }

  internal var faceImageBase64: Optional<String?> {
    get {
      return graphQLMap["faceImageBase64"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "faceImageBase64")
    }
  }

  internal var imageBase64: String {
    get {
      return graphQLMap["imageBase64"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "imageBase64")
    }
  }

  internal var verificationMethod: String {
    get {
      return graphQLMap["verificationMethod"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "verificationMethod")
    }
  }
}

internal struct FinalizeDigitalCredentialVerificationInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(residentialAddress: Optional<DigitalCredentialResidentialAddressInput?> = nil, response: String) {
    graphQLMap = ["residentialAddress": residentialAddress, "response": response]
  }

  internal var residentialAddress: Optional<DigitalCredentialResidentialAddressInput?> {
    get {
      return graphQLMap["residentialAddress"] as! Optional<DigitalCredentialResidentialAddressInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "residentialAddress")
    }
  }

  internal var response: String {
    get {
      return graphQLMap["response"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "response")
    }
  }
}

/// A residential address supplied by the holder, for a presented credential that does not carry one.
internal struct DigitalCredentialResidentialAddressInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(address: String, city: Optional<String?> = nil, country: String, postalCode: String, state: Optional<String?> = nil) {
    graphQLMap = ["address": address, "city": city, "country": country, "postalCode": postalCode, "state": state]
  }

  /// Required, and must not be blank.
  internal var address: String {
    get {
      return graphQLMap["address"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address")
    }
  }

  internal var city: Optional<String?> {
    get {
      return graphQLMap["city"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "city")
    }
  }

  /// ISO 3166-1 alpha-2 or alpha-3 country code, of a supported country.
  internal var country: String {
    get {
      return graphQLMap["country"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "country")
    }
  }

  /// Required, and must not be blank.
  internal var postalCode: String {
    get {
      return graphQLMap["postalCode"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "postalCode")
    }
  }

  internal var state: Optional<String?> {
    get {
      return graphQLMap["state"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "state")
    }
  }
}

internal struct IdentityDataProcessingConsentContentInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(preferredContentType: String, preferredLanguage: String) {
    graphQLMap = ["preferredContentType": preferredContentType, "preferredLanguage": preferredLanguage]
  }

  internal var preferredContentType: String {
    get {
      return graphQLMap["preferredContentType"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "preferredContentType")
    }
  }

  internal var preferredLanguage: String {
    get {
      return graphQLMap["preferredLanguage"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "preferredLanguage")
    }
  }
}

internal struct InitiateDigitalCredentialVerificationInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(flow: DigitalCredentialFlow, origin: Optional<String?> = nil, teamId: Optional<String?> = nil) {
    graphQLMap = ["flow": flow, "origin": origin, "teamId": teamId]
  }

  internal var flow: DigitalCredentialFlow {
    get {
      return graphQLMap["flow"] as! DigitalCredentialFlow
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "flow")
    }
  }

  /// Required for the DC_API flow: the origin the credential will be presented to.
  internal var origin: Optional<String?> {
    get {
      return graphQLMap["origin"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "origin")
    }
  }

  /// Required for the APPLE_VERIFY_WITH_WALLET flow: the Apple Developer team identifier of the requesting app.
  internal var teamId: Optional<String?> {
    get {
      return graphQLMap["teamId"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "teamId")
    }
  }
}

internal enum DigitalCredentialFlow: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  internal typealias RawValue = String
  case appleVerifyWithWallet
  case dcApi
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  internal init?(rawValue: RawValue) {
    switch rawValue {
      case "APPLE_VERIFY_WITH_WALLET": self = .appleVerifyWithWallet
      case "DC_API": self = .dcApi
      default: self = .unknown(rawValue)
    }
  }

  internal var rawValue: RawValue {
    switch self {
      case .appleVerifyWithWallet: return "APPLE_VERIFY_WITH_WALLET"
      case .dcApi: return "DC_API"
      case .unknown(let value): return value
    }
  }

  internal static func == (lhs: DigitalCredentialFlow, rhs: DigitalCredentialFlow) -> Bool {
    switch (lhs, rhs) {
      case (.appleVerifyWithWallet, .appleVerifyWithWallet): return true
      case (.dcApi, .dcApi): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

/// Document type to request from the wallet, mapping to a PKIdentityDocumentDescriptor.
internal enum AppleVerifyWithWalletDocumentType: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  internal typealias RawValue = String
  case driversLicense
  case photoId
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  internal init?(rawValue: RawValue) {
    switch rawValue {
      case "DRIVERS_LICENSE": self = .driversLicense
      case "PHOTO_ID": self = .photoId
      default: self = .unknown(rawValue)
    }
  }

  internal var rawValue: RawValue {
    switch self {
      case .driversLicense: return "DRIVERS_LICENSE"
      case .photoId: return "PHOTO_ID"
      case .unknown(let value): return value
    }
  }

  internal static func == (lhs: AppleVerifyWithWalletDocumentType, rhs: AppleVerifyWithWalletDocumentType) -> Bool {
    switch (lhs, rhs) {
      case (.driversLicense, .driversLicense): return true
      case (.photoId, .photoId): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

/// Attribute to request from the wallet, mapping to a PKIdentityElement. One element may yield several ISO 18013-5 claims.
internal enum AppleVerifyWithWalletElement: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  internal typealias RawValue = String
  case address
  case dateOfBirth
  case familyName
  case givenName
  case issuingAuthority
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  internal init?(rawValue: RawValue) {
    switch rawValue {
      case "ADDRESS": self = .address
      case "DATE_OF_BIRTH": self = .dateOfBirth
      case "FAMILY_NAME": self = .familyName
      case "GIVEN_NAME": self = .givenName
      case "ISSUING_AUTHORITY": self = .issuingAuthority
      default: self = .unknown(rawValue)
    }
  }

  internal var rawValue: RawValue {
    switch self {
      case .address: return "ADDRESS"
      case .dateOfBirth: return "DATE_OF_BIRTH"
      case .familyName: return "FAMILY_NAME"
      case .givenName: return "GIVEN_NAME"
      case .issuingAuthority: return "ISSUING_AUTHORITY"
      case .unknown(let value): return value
    }
  }

  internal static func == (lhs: AppleVerifyWithWalletElement, rhs: AppleVerifyWithWalletElement) -> Bool {
    switch (lhs, rhs) {
      case (.address, .address): return true
      case (.dateOfBirth, .dateOfBirth): return true
      case (.familyName, .familyName): return true
      case (.givenName, .givenName): return true
      case (.issuingAuthority, .issuingAuthority): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

/// How long the verifier may retain the disclosed data, mapping to PKIdentityIntentToStore. Shown to the holder before they consent.
internal enum AppleVerifyWithWalletIntentToStore: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  internal typealias RawValue = String
  case mayStore
  case willNotStore
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  internal init?(rawValue: RawValue) {
    switch rawValue {
      case "MAY_STORE": self = .mayStore
      case "WILL_NOT_STORE": self = .willNotStore
      default: self = .unknown(rawValue)
    }
  }

  internal var rawValue: RawValue {
    switch self {
      case .mayStore: return "MAY_STORE"
      case .willNotStore: return "WILL_NOT_STORE"
      case .unknown(let value): return value
    }
  }

  internal static func == (lhs: AppleVerifyWithWalletIntentToStore, rhs: AppleVerifyWithWalletIntentToStore) -> Bool {
    switch (lhs, rhs) {
      case (.mayStore, .mayStore): return true
      case (.willNotStore, .willNotStore): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

internal struct IdentityDataProcessingConsentInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(content: String, contentType: String, language: String) {
    graphQLMap = ["content": content, "contentType": contentType, "language": language]
  }

  internal var content: String {
    get {
      return graphQLMap["content"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "content")
    }
  }

  internal var contentType: String {
    get {
      return graphQLMap["contentType"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "contentType")
    }
  }

  internal var language: String {
    get {
      return graphQLMap["language"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "language")
    }
  }
}

internal struct VerifyIdentityInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(address: String, city: Optional<String?> = nil, country: String, dateOfBirth: String, firstName: String, lastName: String, postalCode: String, state: Optional<String?> = nil, verificationMethod: String) {
    graphQLMap = ["address": address, "city": city, "country": country, "dateOfBirth": dateOfBirth, "firstName": firstName, "lastName": lastName, "postalCode": postalCode, "state": state, "verificationMethod": verificationMethod]
  }

  internal var address: String {
    get {
      return graphQLMap["address"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address")
    }
  }

  internal var city: Optional<String?> {
    get {
      return graphQLMap["city"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "city")
    }
  }

  internal var country: String {
    get {
      return graphQLMap["country"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "country")
    }
  }

  internal var dateOfBirth: String {
    get {
      return graphQLMap["dateOfBirth"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "dateOfBirth")
    }
  }

  internal var firstName: String {
    get {
      return graphQLMap["firstName"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "firstName")
    }
  }

  internal var lastName: String {
    get {
      return graphQLMap["lastName"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lastName")
    }
  }

  internal var postalCode: String {
    get {
      return graphQLMap["postalCode"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "postalCode")
    }
  }

  internal var state: Optional<String?> {
    get {
      return graphQLMap["state"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "state")
    }
  }

  internal var verificationMethod: String {
    get {
      return graphQLMap["verificationMethod"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "verificationMethod")
    }
  }
}

internal final class CaptureAndVerifyIdentityDocumentMutation: GraphQLMutation {
  internal static let operationString =
    "mutation CaptureAndVerifyIdentityDocument($input: VerifyIdentityDocumentInput) {\n  captureAndVerifyIdentityDocument(input: $input) {\n    __typename\n    ...VerifiedIdentity\n  }\n}"

  internal static var requestString: String { return operationString.appending(VerifiedIdentity.fragmentString) }

  internal var input: VerifyIdentityDocumentInput?

  internal init(input: VerifyIdentityDocumentInput? = nil) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("captureAndVerifyIdentityDocument", arguments: ["input": GraphQLVariable("input")], type: .object(CaptureAndVerifyIdentityDocument.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(captureAndVerifyIdentityDocument: CaptureAndVerifyIdentityDocument? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "captureAndVerifyIdentityDocument": captureAndVerifyIdentityDocument.flatMap { $0.snapshot }])
    }

    internal var captureAndVerifyIdentityDocument: CaptureAndVerifyIdentityDocument? {
      get {
        return (snapshot["captureAndVerifyIdentityDocument"] as? Snapshot).flatMap { CaptureAndVerifyIdentityDocument(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "captureAndVerifyIdentityDocument")
      }
    }

    internal struct CaptureAndVerifyIdentityDocument: GraphQLSelectionSet {
      internal static let possibleTypes = ["VerifiedIdentity"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.scalar(String.self))),
        GraphQLField("verified", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("verifiedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("verificationMethod", type: .nonNull(.scalar(String.self))),
        GraphQLField("canAttemptVerificationAgain", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("idScanUrl", type: .scalar(String.self)),
        GraphQLField("requiredVerificationMethod", type: .scalar(String.self)),
        GraphQLField("acceptableDocumentTypes", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("documentVerificationStatus", type: .nonNull(.scalar(String.self))),
        GraphQLField("verificationLastAttemptedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("attemptsRemaining", type: .nonNull(.scalar(Int.self))),
        GraphQLField("consented", type: .scalar(Bool.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(owner: String, verified: Bool, verifiedAtEpochMs: Double, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil, requiredVerificationMethod: String? = nil, acceptableDocumentTypes: [String], documentVerificationStatus: String, verificationLastAttemptedAtEpochMs: Double, attemptsRemaining: Int, consented: Bool? = nil) {
        self.init(snapshot: ["__typename": "VerifiedIdentity", "owner": owner, "verified": verified, "verifiedAtEpochMs": verifiedAtEpochMs, "verificationMethod": verificationMethod, "canAttemptVerificationAgain": canAttemptVerificationAgain, "idScanUrl": idScanUrl, "requiredVerificationMethod": requiredVerificationMethod, "acceptableDocumentTypes": acceptableDocumentTypes, "documentVerificationStatus": documentVerificationStatus, "verificationLastAttemptedAtEpochMs": verificationLastAttemptedAtEpochMs, "attemptsRemaining": attemptsRemaining, "consented": consented])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var owner: String {
        get {
          return snapshot["owner"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var verified: Bool {
        get {
          return snapshot["verified"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "verified")
        }
      }

      internal var verifiedAtEpochMs: Double {
        get {
          return snapshot["verifiedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "verifiedAtEpochMs")
        }
      }

      internal var verificationMethod: String {
        get {
          return snapshot["verificationMethod"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "verificationMethod")
        }
      }

      internal var canAttemptVerificationAgain: Bool {
        get {
          return snapshot["canAttemptVerificationAgain"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "canAttemptVerificationAgain")
        }
      }

      internal var idScanUrl: String? {
        get {
          return snapshot["idScanUrl"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "idScanUrl")
        }
      }

      internal var requiredVerificationMethod: String? {
        get {
          return snapshot["requiredVerificationMethod"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "requiredVerificationMethod")
        }
      }

      internal var acceptableDocumentTypes: [String] {
        get {
          return snapshot["acceptableDocumentTypes"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "acceptableDocumentTypes")
        }
      }

      internal var documentVerificationStatus: String {
        get {
          return snapshot["documentVerificationStatus"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "documentVerificationStatus")
        }
      }

      internal var verificationLastAttemptedAtEpochMs: Double {
        get {
          return snapshot["verificationLastAttemptedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "verificationLastAttemptedAtEpochMs")
        }
      }

      internal var attemptsRemaining: Int {
        get {
          return snapshot["attemptsRemaining"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "attemptsRemaining")
        }
      }

      internal var consented: Bool? {
        get {
          return snapshot["consented"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "consented")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var verifiedIdentity: VerifiedIdentity {
          get {
            return VerifiedIdentity(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

internal final class CheckIdentityVerificationQuery: GraphQLQuery {
  internal static let operationString =
    "query CheckIdentityVerification {\n  checkIdentityVerification {\n    __typename\n    ...VerifiedIdentity\n  }\n}"

  internal static var requestString: String { return operationString.appending(VerifiedIdentity.fragmentString) }

  internal init() {
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("checkIdentityVerification", type: .object(CheckIdentityVerification.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(checkIdentityVerification: CheckIdentityVerification? = nil) {
      self.init(snapshot: ["__typename": "Query", "checkIdentityVerification": checkIdentityVerification.flatMap { $0.snapshot }])
    }

    internal var checkIdentityVerification: CheckIdentityVerification? {
      get {
        return (snapshot["checkIdentityVerification"] as? Snapshot).flatMap { CheckIdentityVerification(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "checkIdentityVerification")
      }
    }

    internal struct CheckIdentityVerification: GraphQLSelectionSet {
      internal static let possibleTypes = ["VerifiedIdentity"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.scalar(String.self))),
        GraphQLField("verified", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("verifiedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("verificationMethod", type: .nonNull(.scalar(String.self))),
        GraphQLField("canAttemptVerificationAgain", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("idScanUrl", type: .scalar(String.self)),
        GraphQLField("requiredVerificationMethod", type: .scalar(String.self)),
        GraphQLField("acceptableDocumentTypes", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("documentVerificationStatus", type: .nonNull(.scalar(String.self))),
        GraphQLField("verificationLastAttemptedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("attemptsRemaining", type: .nonNull(.scalar(Int.self))),
        GraphQLField("consented", type: .scalar(Bool.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(owner: String, verified: Bool, verifiedAtEpochMs: Double, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil, requiredVerificationMethod: String? = nil, acceptableDocumentTypes: [String], documentVerificationStatus: String, verificationLastAttemptedAtEpochMs: Double, attemptsRemaining: Int, consented: Bool? = nil) {
        self.init(snapshot: ["__typename": "VerifiedIdentity", "owner": owner, "verified": verified, "verifiedAtEpochMs": verifiedAtEpochMs, "verificationMethod": verificationMethod, "canAttemptVerificationAgain": canAttemptVerificationAgain, "idScanUrl": idScanUrl, "requiredVerificationMethod": requiredVerificationMethod, "acceptableDocumentTypes": acceptableDocumentTypes, "documentVerificationStatus": documentVerificationStatus, "verificationLastAttemptedAtEpochMs": verificationLastAttemptedAtEpochMs, "attemptsRemaining": attemptsRemaining, "consented": consented])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var owner: String {
        get {
          return snapshot["owner"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var verified: Bool {
        get {
          return snapshot["verified"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "verified")
        }
      }

      internal var verifiedAtEpochMs: Double {
        get {
          return snapshot["verifiedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "verifiedAtEpochMs")
        }
      }

      internal var verificationMethod: String {
        get {
          return snapshot["verificationMethod"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "verificationMethod")
        }
      }

      internal var canAttemptVerificationAgain: Bool {
        get {
          return snapshot["canAttemptVerificationAgain"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "canAttemptVerificationAgain")
        }
      }

      internal var idScanUrl: String? {
        get {
          return snapshot["idScanUrl"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "idScanUrl")
        }
      }

      internal var requiredVerificationMethod: String? {
        get {
          return snapshot["requiredVerificationMethod"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "requiredVerificationMethod")
        }
      }

      internal var acceptableDocumentTypes: [String] {
        get {
          return snapshot["acceptableDocumentTypes"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "acceptableDocumentTypes")
        }
      }

      internal var documentVerificationStatus: String {
        get {
          return snapshot["documentVerificationStatus"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "documentVerificationStatus")
        }
      }

      internal var verificationLastAttemptedAtEpochMs: Double {
        get {
          return snapshot["verificationLastAttemptedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "verificationLastAttemptedAtEpochMs")
        }
      }

      internal var attemptsRemaining: Int {
        get {
          return snapshot["attemptsRemaining"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "attemptsRemaining")
        }
      }

      internal var consented: Bool? {
        get {
          return snapshot["consented"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "consented")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var verifiedIdentity: VerifiedIdentity {
          get {
            return VerifiedIdentity(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

internal final class FinalizeDigitalCredentialVerificationMutation: GraphQLMutation {
  internal static let operationString =
    "mutation FinalizeDigitalCredentialVerification($input: FinalizeDigitalCredentialVerificationInput) {\n  finalizeDigitalCredentialVerification(input: $input) {\n    __typename\n    ...VerifiedIdentity\n  }\n}"

  internal static var requestString: String { return operationString.appending(VerifiedIdentity.fragmentString) }

  internal var input: FinalizeDigitalCredentialVerificationInput?

  internal init(input: FinalizeDigitalCredentialVerificationInput? = nil) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("finalizeDigitalCredentialVerification", arguments: ["input": GraphQLVariable("input")], type: .object(FinalizeDigitalCredentialVerification.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(finalizeDigitalCredentialVerification: FinalizeDigitalCredentialVerification? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "finalizeDigitalCredentialVerification": finalizeDigitalCredentialVerification.flatMap { $0.snapshot }])
    }

    internal var finalizeDigitalCredentialVerification: FinalizeDigitalCredentialVerification? {
      get {
        return (snapshot["finalizeDigitalCredentialVerification"] as? Snapshot).flatMap { FinalizeDigitalCredentialVerification(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "finalizeDigitalCredentialVerification")
      }
    }

    internal struct FinalizeDigitalCredentialVerification: GraphQLSelectionSet {
      internal static let possibleTypes = ["VerifiedIdentity"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.scalar(String.self))),
        GraphQLField("verified", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("verifiedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("verificationMethod", type: .nonNull(.scalar(String.self))),
        GraphQLField("canAttemptVerificationAgain", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("idScanUrl", type: .scalar(String.self)),
        GraphQLField("requiredVerificationMethod", type: .scalar(String.self)),
        GraphQLField("acceptableDocumentTypes", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("documentVerificationStatus", type: .nonNull(.scalar(String.self))),
        GraphQLField("verificationLastAttemptedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("attemptsRemaining", type: .nonNull(.scalar(Int.self))),
        GraphQLField("consented", type: .scalar(Bool.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(owner: String, verified: Bool, verifiedAtEpochMs: Double, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil, requiredVerificationMethod: String? = nil, acceptableDocumentTypes: [String], documentVerificationStatus: String, verificationLastAttemptedAtEpochMs: Double, attemptsRemaining: Int, consented: Bool? = nil) {
        self.init(snapshot: ["__typename": "VerifiedIdentity", "owner": owner, "verified": verified, "verifiedAtEpochMs": verifiedAtEpochMs, "verificationMethod": verificationMethod, "canAttemptVerificationAgain": canAttemptVerificationAgain, "idScanUrl": idScanUrl, "requiredVerificationMethod": requiredVerificationMethod, "acceptableDocumentTypes": acceptableDocumentTypes, "documentVerificationStatus": documentVerificationStatus, "verificationLastAttemptedAtEpochMs": verificationLastAttemptedAtEpochMs, "attemptsRemaining": attemptsRemaining, "consented": consented])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var owner: String {
        get {
          return snapshot["owner"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var verified: Bool {
        get {
          return snapshot["verified"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "verified")
        }
      }

      internal var verifiedAtEpochMs: Double {
        get {
          return snapshot["verifiedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "verifiedAtEpochMs")
        }
      }

      internal var verificationMethod: String {
        get {
          return snapshot["verificationMethod"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "verificationMethod")
        }
      }

      internal var canAttemptVerificationAgain: Bool {
        get {
          return snapshot["canAttemptVerificationAgain"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "canAttemptVerificationAgain")
        }
      }

      internal var idScanUrl: String? {
        get {
          return snapshot["idScanUrl"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "idScanUrl")
        }
      }

      internal var requiredVerificationMethod: String? {
        get {
          return snapshot["requiredVerificationMethod"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "requiredVerificationMethod")
        }
      }

      internal var acceptableDocumentTypes: [String] {
        get {
          return snapshot["acceptableDocumentTypes"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "acceptableDocumentTypes")
        }
      }

      internal var documentVerificationStatus: String {
        get {
          return snapshot["documentVerificationStatus"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "documentVerificationStatus")
        }
      }

      internal var verificationLastAttemptedAtEpochMs: Double {
        get {
          return snapshot["verificationLastAttemptedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "verificationLastAttemptedAtEpochMs")
        }
      }

      internal var attemptsRemaining: Int {
        get {
          return snapshot["attemptsRemaining"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "attemptsRemaining")
        }
      }

      internal var consented: Bool? {
        get {
          return snapshot["consented"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "consented")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var verifiedIdentity: VerifiedIdentity {
          get {
            return VerifiedIdentity(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

internal final class GetIdentityDataProcessingConsentContentQuery: GraphQLQuery {
  internal static let operationString =
    "query GetIdentityDataProcessingConsentContent($input: IdentityDataProcessingConsentContentInput!) {\n  getIdentityDataProcessingConsentContent(input: $input) {\n    __typename\n    content\n    contentType\n    language\n  }\n}"

  internal var input: IdentityDataProcessingConsentContentInput

  internal init(input: IdentityDataProcessingConsentContentInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getIdentityDataProcessingConsentContent", arguments: ["input": GraphQLVariable("input")], type: .object(GetIdentityDataProcessingConsentContent.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getIdentityDataProcessingConsentContent: GetIdentityDataProcessingConsentContent? = nil) {
      self.init(snapshot: ["__typename": "Query", "getIdentityDataProcessingConsentContent": getIdentityDataProcessingConsentContent.flatMap { $0.snapshot }])
    }

    internal var getIdentityDataProcessingConsentContent: GetIdentityDataProcessingConsentContent? {
      get {
        return (snapshot["getIdentityDataProcessingConsentContent"] as? Snapshot).flatMap { GetIdentityDataProcessingConsentContent(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getIdentityDataProcessingConsentContent")
      }
    }

    internal struct GetIdentityDataProcessingConsentContent: GraphQLSelectionSet {
      internal static let possibleTypes = ["IdentityDataProcessingConsentContent"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("content", type: .nonNull(.scalar(String.self))),
        GraphQLField("contentType", type: .nonNull(.scalar(String.self))),
        GraphQLField("language", type: .nonNull(.scalar(String.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(content: String, contentType: String, language: String) {
        self.init(snapshot: ["__typename": "IdentityDataProcessingConsentContent", "content": content, "contentType": contentType, "language": language])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var content: String {
        get {
          return snapshot["content"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "content")
        }
      }

      internal var contentType: String {
        get {
          return snapshot["contentType"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "contentType")
        }
      }

      internal var language: String {
        get {
          return snapshot["language"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "language")
        }
      }
    }
  }
}

internal final class GetIdentityDataProcessingConsentStatusQuery: GraphQLQuery {
  internal static let operationString =
    "query GetIdentityDataProcessingConsentStatus {\n  getIdentityDataProcessingConsentStatus {\n    __typename\n    consented\n    consentedAtEpochMs\n    consentWithdrawnAtEpochMs\n    content\n    contentType\n    language\n  }\n}"

  internal init() {
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getIdentityDataProcessingConsentStatus", type: .object(GetIdentityDataProcessingConsentStatus.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getIdentityDataProcessingConsentStatus: GetIdentityDataProcessingConsentStatus? = nil) {
      self.init(snapshot: ["__typename": "Query", "getIdentityDataProcessingConsentStatus": getIdentityDataProcessingConsentStatus.flatMap { $0.snapshot }])
    }

    internal var getIdentityDataProcessingConsentStatus: GetIdentityDataProcessingConsentStatus? {
      get {
        return (snapshot["getIdentityDataProcessingConsentStatus"] as? Snapshot).flatMap { GetIdentityDataProcessingConsentStatus(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getIdentityDataProcessingConsentStatus")
      }
    }

    internal struct GetIdentityDataProcessingConsentStatus: GraphQLSelectionSet {
      internal static let possibleTypes = ["IdentityDataProcessingConsentStatus"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("consented", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("consentedAtEpochMs", type: .scalar(Double.self)),
        GraphQLField("consentWithdrawnAtEpochMs", type: .scalar(Double.self)),
        GraphQLField("content", type: .scalar(String.self)),
        GraphQLField("contentType", type: .scalar(String.self)),
        GraphQLField("language", type: .scalar(String.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(consented: Bool, consentedAtEpochMs: Double? = nil, consentWithdrawnAtEpochMs: Double? = nil, content: String? = nil, contentType: String? = nil, language: String? = nil) {
        self.init(snapshot: ["__typename": "IdentityDataProcessingConsentStatus", "consented": consented, "consentedAtEpochMs": consentedAtEpochMs, "consentWithdrawnAtEpochMs": consentWithdrawnAtEpochMs, "content": content, "contentType": contentType, "language": language])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var consented: Bool {
        get {
          return snapshot["consented"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "consented")
        }
      }

      internal var consentedAtEpochMs: Double? {
        get {
          return snapshot["consentedAtEpochMs"] as? Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "consentedAtEpochMs")
        }
      }

      internal var consentWithdrawnAtEpochMs: Double? {
        get {
          return snapshot["consentWithdrawnAtEpochMs"] as? Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "consentWithdrawnAtEpochMs")
        }
      }

      internal var content: String? {
        get {
          return snapshot["content"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "content")
        }
      }

      internal var contentType: String? {
        get {
          return snapshot["contentType"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "contentType")
        }
      }

      internal var language: String? {
        get {
          return snapshot["language"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "language")
        }
      }
    }
  }
}

internal final class GetIdentityVerificationCapabilitiesQuery: GraphQLQuery {
  internal static let operationString =
    "query GetIdentityVerificationCapabilities {\n  getIdentityVerificationCapabilities {\n    __typename\n    supportedCountries\n    faceImageRequiredWithDocumentCapture\n    faceImageRequiredWithDocumentVerification\n    canInitiateDocumentCapture\n    consentRequired\n    canVerifyWithDigitalCredential\n  }\n}"

  internal init() {
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getIdentityVerificationCapabilities", type: .object(GetIdentityVerificationCapability.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getIdentityVerificationCapabilities: GetIdentityVerificationCapability? = nil) {
      self.init(snapshot: ["__typename": "Query", "getIdentityVerificationCapabilities": getIdentityVerificationCapabilities.flatMap { $0.snapshot }])
    }

    internal var getIdentityVerificationCapabilities: GetIdentityVerificationCapability? {
      get {
        return (snapshot["getIdentityVerificationCapabilities"] as? Snapshot).flatMap { GetIdentityVerificationCapability(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getIdentityVerificationCapabilities")
      }
    }

    internal struct GetIdentityVerificationCapability: GraphQLSelectionSet {
      internal static let possibleTypes = ["IdentityVerificationCapabilities"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("supportedCountries", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("faceImageRequiredWithDocumentCapture", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("faceImageRequiredWithDocumentVerification", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("canInitiateDocumentCapture", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("consentRequired", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("canVerifyWithDigitalCredential", type: .nonNull(.scalar(Bool.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(supportedCountries: [String], faceImageRequiredWithDocumentCapture: Bool, faceImageRequiredWithDocumentVerification: Bool, canInitiateDocumentCapture: Bool, consentRequired: Bool, canVerifyWithDigitalCredential: Bool) {
        self.init(snapshot: ["__typename": "IdentityVerificationCapabilities", "supportedCountries": supportedCountries, "faceImageRequiredWithDocumentCapture": faceImageRequiredWithDocumentCapture, "faceImageRequiredWithDocumentVerification": faceImageRequiredWithDocumentVerification, "canInitiateDocumentCapture": canInitiateDocumentCapture, "consentRequired": consentRequired, "canVerifyWithDigitalCredential": canVerifyWithDigitalCredential])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var supportedCountries: [String] {
        get {
          return snapshot["supportedCountries"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "supportedCountries")
        }
      }

      internal var faceImageRequiredWithDocumentCapture: Bool {
        get {
          return snapshot["faceImageRequiredWithDocumentCapture"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "faceImageRequiredWithDocumentCapture")
        }
      }

      internal var faceImageRequiredWithDocumentVerification: Bool {
        get {
          return snapshot["faceImageRequiredWithDocumentVerification"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "faceImageRequiredWithDocumentVerification")
        }
      }

      internal var canInitiateDocumentCapture: Bool {
        get {
          return snapshot["canInitiateDocumentCapture"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "canInitiateDocumentCapture")
        }
      }

      internal var consentRequired: Bool {
        get {
          return snapshot["consentRequired"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "consentRequired")
        }
      }

      internal var canVerifyWithDigitalCredential: Bool {
        get {
          return snapshot["canVerifyWithDigitalCredential"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "canVerifyWithDigitalCredential")
        }
      }
    }
  }
}

internal final class InitiateDigitalCredentialVerificationMutation: GraphQLMutation {
  internal static let operationString =
    "mutation InitiateDigitalCredentialVerification($input: InitiateDigitalCredentialVerificationInput) {\n  initiateDigitalCredentialVerification(input: $input) {\n    __typename\n    flow {\n      __typename\n      ... on DcApiFlowRequest {\n        requestJson\n      }\n      ... on AppleVerifyWithWalletFlowRequest {\n        nonce\n        documentRequests {\n          __typename\n          documentType\n          elements\n          intentToStore\n        }\n      }\n    }\n    expiryAtEpochSeconds\n  }\n}"

  internal var input: InitiateDigitalCredentialVerificationInput?

  internal init(input: InitiateDigitalCredentialVerificationInput? = nil) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("initiateDigitalCredentialVerification", arguments: ["input": GraphQLVariable("input")], type: .object(InitiateDigitalCredentialVerification.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(initiateDigitalCredentialVerification: InitiateDigitalCredentialVerification? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "initiateDigitalCredentialVerification": initiateDigitalCredentialVerification.flatMap { $0.snapshot }])
    }

    internal var initiateDigitalCredentialVerification: InitiateDigitalCredentialVerification? {
      get {
        return (snapshot["initiateDigitalCredentialVerification"] as? Snapshot).flatMap { InitiateDigitalCredentialVerification(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "initiateDigitalCredentialVerification")
      }
    }

    internal struct InitiateDigitalCredentialVerification: GraphQLSelectionSet {
      internal static let possibleTypes = ["DigitalCredentialRequest"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("flow", type: .nonNull(.object(Flow.selections))),
        GraphQLField("expiryAtEpochSeconds", type: .nonNull(.scalar(Double.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(flow: Flow, expiryAtEpochSeconds: Double) {
        self.init(snapshot: ["__typename": "DigitalCredentialRequest", "flow": flow.snapshot, "expiryAtEpochSeconds": expiryAtEpochSeconds])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var flow: Flow {
        get {
          return Flow(snapshot: snapshot["flow"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "flow")
        }
      }

      internal var expiryAtEpochSeconds: Double {
        get {
          return snapshot["expiryAtEpochSeconds"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "expiryAtEpochSeconds")
        }
      }

      internal struct Flow: GraphQLSelectionSet {
        internal static let possibleTypes = ["AppleVerifyWithWalletFlowRequest", "DcApiFlowRequest"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLTypeCase(
            variants: ["DcApiFlowRequest": AsDcApiFlowRequest.selections, "AppleVerifyWithWalletFlowRequest": AsAppleVerifyWithWalletFlowRequest.selections],
            default: [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            ]
          )
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal static func makeDcApiFlowRequest(requestJson: String) -> Flow {
          return Flow(snapshot: ["__typename": "DcApiFlowRequest", "requestJson": requestJson])
        }

        internal static func makeAppleVerifyWithWalletFlowRequest(nonce: String, documentRequests: [AsAppleVerifyWithWalletFlowRequest.DocumentRequest]) -> Flow {
          return Flow(snapshot: ["__typename": "AppleVerifyWithWalletFlowRequest", "nonce": nonce, "documentRequests": documentRequests.map { $0.snapshot }])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var asDcApiFlowRequest: AsDcApiFlowRequest? {
          get {
            if !AsDcApiFlowRequest.possibleTypes.contains(__typename) { return nil }
            return AsDcApiFlowRequest(snapshot: snapshot)
          }
          set {
            guard let newValue = newValue else { return }
            snapshot = newValue.snapshot
          }
        }

        internal struct AsDcApiFlowRequest: GraphQLSelectionSet {
          internal static let possibleTypes = ["DcApiFlowRequest"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("requestJson", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(requestJson: String) {
            self.init(snapshot: ["__typename": "DcApiFlowRequest", "requestJson": requestJson])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var requestJson: String {
            get {
              return snapshot["requestJson"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "requestJson")
            }
          }
        }

        internal var asAppleVerifyWithWalletFlowRequest: AsAppleVerifyWithWalletFlowRequest? {
          get {
            if !AsAppleVerifyWithWalletFlowRequest.possibleTypes.contains(__typename) { return nil }
            return AsAppleVerifyWithWalletFlowRequest(snapshot: snapshot)
          }
          set {
            guard let newValue = newValue else { return }
            snapshot = newValue.snapshot
          }
        }

        internal struct AsAppleVerifyWithWalletFlowRequest: GraphQLSelectionSet {
          internal static let possibleTypes = ["AppleVerifyWithWalletFlowRequest"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nonce", type: .nonNull(.scalar(String.self))),
            GraphQLField("documentRequests", type: .nonNull(.list(.nonNull(.object(DocumentRequest.selections))))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(nonce: String, documentRequests: [DocumentRequest]) {
            self.init(snapshot: ["__typename": "AppleVerifyWithWalletFlowRequest", "nonce": nonce, "documentRequests": documentRequests.map { $0.snapshot }])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var nonce: String {
            get {
              return snapshot["nonce"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "nonce")
            }
          }

          /// The document types and attributes to build the PKIdentityRequest from. Unlike DC_API, whose DCQL query the wallet reads directly, an Apple request is assembled by the client, so the service states here what to assemble. More than one entry means any of them is acceptable.
          internal var documentRequests: [DocumentRequest] {
            get {
              return (snapshot["documentRequests"] as! [Snapshot]).map { DocumentRequest(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "documentRequests")
            }
          }

          internal struct DocumentRequest: GraphQLSelectionSet {
            internal static let possibleTypes = ["AppleVerifyWithWalletDocumentRequest"]

            internal static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("documentType", type: .nonNull(.scalar(AppleVerifyWithWalletDocumentType.self))),
              GraphQLField("elements", type: .nonNull(.list(.nonNull(.scalar(AppleVerifyWithWalletElement.self))))),
              GraphQLField("intentToStore", type: .nonNull(.scalar(AppleVerifyWithWalletIntentToStore.self))),
            ]

            internal var snapshot: Snapshot

            internal init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            internal init(documentType: AppleVerifyWithWalletDocumentType, elements: [AppleVerifyWithWalletElement], intentToStore: AppleVerifyWithWalletIntentToStore) {
              self.init(snapshot: ["__typename": "AppleVerifyWithWalletDocumentRequest", "documentType": documentType, "elements": elements, "intentToStore": intentToStore])
            }

            internal var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            internal var documentType: AppleVerifyWithWalletDocumentType {
              get {
                return snapshot["documentType"]! as! AppleVerifyWithWalletDocumentType
              }
              set {
                snapshot.updateValue(newValue, forKey: "documentType")
              }
            }

            internal var elements: [AppleVerifyWithWalletElement] {
              get {
                return snapshot["elements"]! as! [AppleVerifyWithWalletElement]
              }
              set {
                snapshot.updateValue(newValue, forKey: "elements")
              }
            }

            internal var intentToStore: AppleVerifyWithWalletIntentToStore {
              get {
                return snapshot["intentToStore"]! as! AppleVerifyWithWalletIntentToStore
              }
              set {
                snapshot.updateValue(newValue, forKey: "intentToStore")
              }
            }
          }
        }
      }
    }
  }
}

internal final class InitiateIdentityDocumentCaptureMutation: GraphQLMutation {
  internal static let operationString =
    "mutation InitiateIdentityDocumentCapture {\n  initiateIdentityDocumentCapture {\n    __typename\n    documentCaptureUrl\n    expiryAtEpochSeconds\n  }\n}"

  internal init() {
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("initiateIdentityDocumentCapture", type: .object(InitiateIdentityDocumentCapture.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(initiateIdentityDocumentCapture: InitiateIdentityDocumentCapture? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "initiateIdentityDocumentCapture": initiateIdentityDocumentCapture.flatMap { $0.snapshot }])
    }

    internal var initiateIdentityDocumentCapture: InitiateIdentityDocumentCapture? {
      get {
        return (snapshot["initiateIdentityDocumentCapture"] as? Snapshot).flatMap { InitiateIdentityDocumentCapture(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "initiateIdentityDocumentCapture")
      }
    }

    internal struct InitiateIdentityDocumentCapture: GraphQLSelectionSet {
      internal static let possibleTypes = ["IdentityDocumentCaptureInitiationResponse"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("documentCaptureUrl", type: .nonNull(.scalar(String.self))),
        GraphQLField("expiryAtEpochSeconds", type: .nonNull(.scalar(Double.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(documentCaptureUrl: String, expiryAtEpochSeconds: Double) {
        self.init(snapshot: ["__typename": "IdentityDocumentCaptureInitiationResponse", "documentCaptureUrl": documentCaptureUrl, "expiryAtEpochSeconds": expiryAtEpochSeconds])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var documentCaptureUrl: String {
        get {
          return snapshot["documentCaptureUrl"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "documentCaptureUrl")
        }
      }

      internal var expiryAtEpochSeconds: Double {
        get {
          return snapshot["expiryAtEpochSeconds"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "expiryAtEpochSeconds")
        }
      }
    }
  }
}

internal final class ProvideIdentityDataProcessingConsentMutation: GraphQLMutation {
  internal static let operationString =
    "mutation ProvideIdentityDataProcessingConsent($input: IdentityDataProcessingConsentInput!) {\n  provideIdentityDataProcessingConsent(input: $input) {\n    __typename\n    processed\n  }\n}"

  internal var input: IdentityDataProcessingConsentInput

  internal init(input: IdentityDataProcessingConsentInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("provideIdentityDataProcessingConsent", arguments: ["input": GraphQLVariable("input")], type: .object(ProvideIdentityDataProcessingConsent.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(provideIdentityDataProcessingConsent: ProvideIdentityDataProcessingConsent? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "provideIdentityDataProcessingConsent": provideIdentityDataProcessingConsent.flatMap { $0.snapshot }])
    }

    internal var provideIdentityDataProcessingConsent: ProvideIdentityDataProcessingConsent? {
      get {
        return (snapshot["provideIdentityDataProcessingConsent"] as? Snapshot).flatMap { ProvideIdentityDataProcessingConsent(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "provideIdentityDataProcessingConsent")
      }
    }

    internal struct ProvideIdentityDataProcessingConsent: GraphQLSelectionSet {
      internal static let possibleTypes = ["IdentityDataProcessingConsentResponse"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("processed", type: .nonNull(.scalar(Bool.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(processed: Bool) {
        self.init(snapshot: ["__typename": "IdentityDataProcessingConsentResponse", "processed": processed])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var processed: Bool {
        get {
          return snapshot["processed"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "processed")
        }
      }
    }
  }
}

internal final class VerifyIdentityMutation: GraphQLMutation {
  internal static let operationString =
    "mutation VerifyIdentity($input: VerifyIdentityInput) {\n  verifyIdentity(input: $input) {\n    __typename\n    ...VerifiedIdentity\n  }\n}"

  internal static var requestString: String { return operationString.appending(VerifiedIdentity.fragmentString) }

  internal var input: VerifyIdentityInput?

  internal init(input: VerifyIdentityInput? = nil) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("verifyIdentity", arguments: ["input": GraphQLVariable("input")], type: .object(VerifyIdentity.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(verifyIdentity: VerifyIdentity? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "verifyIdentity": verifyIdentity.flatMap { $0.snapshot }])
    }

    internal var verifyIdentity: VerifyIdentity? {
      get {
        return (snapshot["verifyIdentity"] as? Snapshot).flatMap { VerifyIdentity(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "verifyIdentity")
      }
    }

    internal struct VerifyIdentity: GraphQLSelectionSet {
      internal static let possibleTypes = ["VerifiedIdentity"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.scalar(String.self))),
        GraphQLField("verified", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("verifiedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("verificationMethod", type: .nonNull(.scalar(String.self))),
        GraphQLField("canAttemptVerificationAgain", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("idScanUrl", type: .scalar(String.self)),
        GraphQLField("requiredVerificationMethod", type: .scalar(String.self)),
        GraphQLField("acceptableDocumentTypes", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("documentVerificationStatus", type: .nonNull(.scalar(String.self))),
        GraphQLField("verificationLastAttemptedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("attemptsRemaining", type: .nonNull(.scalar(Int.self))),
        GraphQLField("consented", type: .scalar(Bool.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(owner: String, verified: Bool, verifiedAtEpochMs: Double, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil, requiredVerificationMethod: String? = nil, acceptableDocumentTypes: [String], documentVerificationStatus: String, verificationLastAttemptedAtEpochMs: Double, attemptsRemaining: Int, consented: Bool? = nil) {
        self.init(snapshot: ["__typename": "VerifiedIdentity", "owner": owner, "verified": verified, "verifiedAtEpochMs": verifiedAtEpochMs, "verificationMethod": verificationMethod, "canAttemptVerificationAgain": canAttemptVerificationAgain, "idScanUrl": idScanUrl, "requiredVerificationMethod": requiredVerificationMethod, "acceptableDocumentTypes": acceptableDocumentTypes, "documentVerificationStatus": documentVerificationStatus, "verificationLastAttemptedAtEpochMs": verificationLastAttemptedAtEpochMs, "attemptsRemaining": attemptsRemaining, "consented": consented])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var owner: String {
        get {
          return snapshot["owner"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var verified: Bool {
        get {
          return snapshot["verified"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "verified")
        }
      }

      internal var verifiedAtEpochMs: Double {
        get {
          return snapshot["verifiedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "verifiedAtEpochMs")
        }
      }

      internal var verificationMethod: String {
        get {
          return snapshot["verificationMethod"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "verificationMethod")
        }
      }

      internal var canAttemptVerificationAgain: Bool {
        get {
          return snapshot["canAttemptVerificationAgain"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "canAttemptVerificationAgain")
        }
      }

      internal var idScanUrl: String? {
        get {
          return snapshot["idScanUrl"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "idScanUrl")
        }
      }

      internal var requiredVerificationMethod: String? {
        get {
          return snapshot["requiredVerificationMethod"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "requiredVerificationMethod")
        }
      }

      internal var acceptableDocumentTypes: [String] {
        get {
          return snapshot["acceptableDocumentTypes"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "acceptableDocumentTypes")
        }
      }

      internal var documentVerificationStatus: String {
        get {
          return snapshot["documentVerificationStatus"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "documentVerificationStatus")
        }
      }

      internal var verificationLastAttemptedAtEpochMs: Double {
        get {
          return snapshot["verificationLastAttemptedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "verificationLastAttemptedAtEpochMs")
        }
      }

      internal var attemptsRemaining: Int {
        get {
          return snapshot["attemptsRemaining"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "attemptsRemaining")
        }
      }

      internal var consented: Bool? {
        get {
          return snapshot["consented"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "consented")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var verifiedIdentity: VerifiedIdentity {
          get {
            return VerifiedIdentity(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

internal final class VerifyIdentityDocumentMutation: GraphQLMutation {
  internal static let operationString =
    "mutation VerifyIdentityDocument($input: VerifyIdentityDocumentInput) {\n  verifyIdentityDocument(input: $input) {\n    __typename\n    ...VerifiedIdentity\n  }\n}"

  internal static var requestString: String { return operationString.appending(VerifiedIdentity.fragmentString) }

  internal var input: VerifyIdentityDocumentInput?

  internal init(input: VerifyIdentityDocumentInput? = nil) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("verifyIdentityDocument", arguments: ["input": GraphQLVariable("input")], type: .object(VerifyIdentityDocument.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(verifyIdentityDocument: VerifyIdentityDocument? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "verifyIdentityDocument": verifyIdentityDocument.flatMap { $0.snapshot }])
    }

    internal var verifyIdentityDocument: VerifyIdentityDocument? {
      get {
        return (snapshot["verifyIdentityDocument"] as? Snapshot).flatMap { VerifyIdentityDocument(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "verifyIdentityDocument")
      }
    }

    internal struct VerifyIdentityDocument: GraphQLSelectionSet {
      internal static let possibleTypes = ["VerifiedIdentity"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.scalar(String.self))),
        GraphQLField("verified", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("verifiedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("verificationMethod", type: .nonNull(.scalar(String.self))),
        GraphQLField("canAttemptVerificationAgain", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("idScanUrl", type: .scalar(String.self)),
        GraphQLField("requiredVerificationMethod", type: .scalar(String.self)),
        GraphQLField("acceptableDocumentTypes", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("documentVerificationStatus", type: .nonNull(.scalar(String.self))),
        GraphQLField("verificationLastAttemptedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("attemptsRemaining", type: .nonNull(.scalar(Int.self))),
        GraphQLField("consented", type: .scalar(Bool.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(owner: String, verified: Bool, verifiedAtEpochMs: Double, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil, requiredVerificationMethod: String? = nil, acceptableDocumentTypes: [String], documentVerificationStatus: String, verificationLastAttemptedAtEpochMs: Double, attemptsRemaining: Int, consented: Bool? = nil) {
        self.init(snapshot: ["__typename": "VerifiedIdentity", "owner": owner, "verified": verified, "verifiedAtEpochMs": verifiedAtEpochMs, "verificationMethod": verificationMethod, "canAttemptVerificationAgain": canAttemptVerificationAgain, "idScanUrl": idScanUrl, "requiredVerificationMethod": requiredVerificationMethod, "acceptableDocumentTypes": acceptableDocumentTypes, "documentVerificationStatus": documentVerificationStatus, "verificationLastAttemptedAtEpochMs": verificationLastAttemptedAtEpochMs, "attemptsRemaining": attemptsRemaining, "consented": consented])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var owner: String {
        get {
          return snapshot["owner"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var verified: Bool {
        get {
          return snapshot["verified"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "verified")
        }
      }

      internal var verifiedAtEpochMs: Double {
        get {
          return snapshot["verifiedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "verifiedAtEpochMs")
        }
      }

      internal var verificationMethod: String {
        get {
          return snapshot["verificationMethod"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "verificationMethod")
        }
      }

      internal var canAttemptVerificationAgain: Bool {
        get {
          return snapshot["canAttemptVerificationAgain"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "canAttemptVerificationAgain")
        }
      }

      internal var idScanUrl: String? {
        get {
          return snapshot["idScanUrl"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "idScanUrl")
        }
      }

      internal var requiredVerificationMethod: String? {
        get {
          return snapshot["requiredVerificationMethod"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "requiredVerificationMethod")
        }
      }

      internal var acceptableDocumentTypes: [String] {
        get {
          return snapshot["acceptableDocumentTypes"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "acceptableDocumentTypes")
        }
      }

      internal var documentVerificationStatus: String {
        get {
          return snapshot["documentVerificationStatus"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "documentVerificationStatus")
        }
      }

      internal var verificationLastAttemptedAtEpochMs: Double {
        get {
          return snapshot["verificationLastAttemptedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "verificationLastAttemptedAtEpochMs")
        }
      }

      internal var attemptsRemaining: Int {
        get {
          return snapshot["attemptsRemaining"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "attemptsRemaining")
        }
      }

      internal var consented: Bool? {
        get {
          return snapshot["consented"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "consented")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var verifiedIdentity: VerifiedIdentity {
          get {
            return VerifiedIdentity(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

internal final class WithdrawIdentityDataProcessingConsentMutation: GraphQLMutation {
  internal static let operationString =
    "mutation WithdrawIdentityDataProcessingConsent {\n  withdrawIdentityDataProcessingConsent {\n    __typename\n    processed\n  }\n}"

  internal init() {
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("withdrawIdentityDataProcessingConsent", type: .object(WithdrawIdentityDataProcessingConsent.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(withdrawIdentityDataProcessingConsent: WithdrawIdentityDataProcessingConsent? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "withdrawIdentityDataProcessingConsent": withdrawIdentityDataProcessingConsent.flatMap { $0.snapshot }])
    }

    internal var withdrawIdentityDataProcessingConsent: WithdrawIdentityDataProcessingConsent? {
      get {
        return (snapshot["withdrawIdentityDataProcessingConsent"] as? Snapshot).flatMap { WithdrawIdentityDataProcessingConsent(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "withdrawIdentityDataProcessingConsent")
      }
    }

    internal struct WithdrawIdentityDataProcessingConsent: GraphQLSelectionSet {
      internal static let possibleTypes = ["IdentityDataProcessingConsentResponse"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("processed", type: .nonNull(.scalar(Bool.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(processed: Bool) {
        self.init(snapshot: ["__typename": "IdentityDataProcessingConsentResponse", "processed": processed])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var processed: Bool {
        get {
          return snapshot["processed"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "processed")
        }
      }
    }
  }
}

internal struct VerifiedIdentity: GraphQLFragment {
  internal static let fragmentString =
    "fragment VerifiedIdentity on VerifiedIdentity {\n  __typename\n  owner\n  verified\n  verifiedAtEpochMs\n  verificationMethod\n  canAttemptVerificationAgain\n  idScanUrl\n  requiredVerificationMethod\n  acceptableDocumentTypes\n  documentVerificationStatus\n  verificationLastAttemptedAtEpochMs\n  attemptsRemaining\n  consented\n}"

  internal static let possibleTypes = ["VerifiedIdentity"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("owner", type: .nonNull(.scalar(String.self))),
    GraphQLField("verified", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("verifiedAtEpochMs", type: .nonNull(.scalar(Double.self))),
    GraphQLField("verificationMethod", type: .nonNull(.scalar(String.self))),
    GraphQLField("canAttemptVerificationAgain", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("idScanUrl", type: .scalar(String.self)),
    GraphQLField("requiredVerificationMethod", type: .scalar(String.self)),
    GraphQLField("acceptableDocumentTypes", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
    GraphQLField("documentVerificationStatus", type: .nonNull(.scalar(String.self))),
    GraphQLField("verificationLastAttemptedAtEpochMs", type: .nonNull(.scalar(Double.self))),
    GraphQLField("attemptsRemaining", type: .nonNull(.scalar(Int.self))),
    GraphQLField("consented", type: .scalar(Bool.self)),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(owner: String, verified: Bool, verifiedAtEpochMs: Double, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil, requiredVerificationMethod: String? = nil, acceptableDocumentTypes: [String], documentVerificationStatus: String, verificationLastAttemptedAtEpochMs: Double, attemptsRemaining: Int, consented: Bool? = nil) {
    self.init(snapshot: ["__typename": "VerifiedIdentity", "owner": owner, "verified": verified, "verifiedAtEpochMs": verifiedAtEpochMs, "verificationMethod": verificationMethod, "canAttemptVerificationAgain": canAttemptVerificationAgain, "idScanUrl": idScanUrl, "requiredVerificationMethod": requiredVerificationMethod, "acceptableDocumentTypes": acceptableDocumentTypes, "documentVerificationStatus": documentVerificationStatus, "verificationLastAttemptedAtEpochMs": verificationLastAttemptedAtEpochMs, "attemptsRemaining": attemptsRemaining, "consented": consented])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var owner: String {
    get {
      return snapshot["owner"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "owner")
    }
  }

  internal var verified: Bool {
    get {
      return snapshot["verified"]! as! Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "verified")
    }
  }

  internal var verifiedAtEpochMs: Double {
    get {
      return snapshot["verifiedAtEpochMs"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "verifiedAtEpochMs")
    }
  }

  internal var verificationMethod: String {
    get {
      return snapshot["verificationMethod"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "verificationMethod")
    }
  }

  internal var canAttemptVerificationAgain: Bool {
    get {
      return snapshot["canAttemptVerificationAgain"]! as! Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "canAttemptVerificationAgain")
    }
  }

  internal var idScanUrl: String? {
    get {
      return snapshot["idScanUrl"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "idScanUrl")
    }
  }

  internal var requiredVerificationMethod: String? {
    get {
      return snapshot["requiredVerificationMethod"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "requiredVerificationMethod")
    }
  }

  internal var acceptableDocumentTypes: [String] {
    get {
      return snapshot["acceptableDocumentTypes"]! as! [String]
    }
    set {
      snapshot.updateValue(newValue, forKey: "acceptableDocumentTypes")
    }
  }

  internal var documentVerificationStatus: String {
    get {
      return snapshot["documentVerificationStatus"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "documentVerificationStatus")
    }
  }

  internal var verificationLastAttemptedAtEpochMs: Double {
    get {
      return snapshot["verificationLastAttemptedAtEpochMs"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "verificationLastAttemptedAtEpochMs")
    }
  }

  internal var attemptsRemaining: Int {
    get {
      return snapshot["attemptsRemaining"]! as! Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "attemptsRemaining")
    }
  }

  internal var consented: Bool? {
    get {
      return snapshot["consented"] as? Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "consented")
    }
  }
}
// swiftlint:enable all

}