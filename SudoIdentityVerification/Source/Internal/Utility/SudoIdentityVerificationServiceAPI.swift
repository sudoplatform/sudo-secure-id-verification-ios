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
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(owner: String, verified: Bool, verifiedAtEpochMs: Double, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil, requiredVerificationMethod: String? = nil, acceptableDocumentTypes: [String], documentVerificationStatus: String, verificationLastAttemptedAtEpochMs: Double) {
        self.init(snapshot: ["__typename": "VerifiedIdentity", "owner": owner, "verified": verified, "verifiedAtEpochMs": verifiedAtEpochMs, "verificationMethod": verificationMethod, "canAttemptVerificationAgain": canAttemptVerificationAgain, "idScanUrl": idScanUrl, "requiredVerificationMethod": requiredVerificationMethod, "acceptableDocumentTypes": acceptableDocumentTypes, "documentVerificationStatus": documentVerificationStatus, "verificationLastAttemptedAtEpochMs": verificationLastAttemptedAtEpochMs])
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
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(owner: String, verified: Bool, verifiedAtEpochMs: Double, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil, requiredVerificationMethod: String? = nil, acceptableDocumentTypes: [String], documentVerificationStatus: String, verificationLastAttemptedAtEpochMs: Double) {
        self.init(snapshot: ["__typename": "VerifiedIdentity", "owner": owner, "verified": verified, "verifiedAtEpochMs": verifiedAtEpochMs, "verificationMethod": verificationMethod, "canAttemptVerificationAgain": canAttemptVerificationAgain, "idScanUrl": idScanUrl, "requiredVerificationMethod": requiredVerificationMethod, "acceptableDocumentTypes": acceptableDocumentTypes, "documentVerificationStatus": documentVerificationStatus, "verificationLastAttemptedAtEpochMs": verificationLastAttemptedAtEpochMs])
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

internal final class GetIdentityVerificationCapabilitiesQuery: GraphQLQuery {
  internal static let operationString =
    "query GetIdentityVerificationCapabilities {\n  getIdentityVerificationCapabilities {\n    __typename\n    supportedCountries\n    faceImageRequiredWithDocumentCapture\n    faceImageRequiredWithDocumentVerification\n    canInitiateDocumentCapture\n  }\n}"

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
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(supportedCountries: [String], faceImageRequiredWithDocumentCapture: Bool, faceImageRequiredWithDocumentVerification: Bool, canInitiateDocumentCapture: Bool) {
        self.init(snapshot: ["__typename": "IdentityVerificationCapabilities", "supportedCountries": supportedCountries, "faceImageRequiredWithDocumentCapture": faceImageRequiredWithDocumentCapture, "faceImageRequiredWithDocumentVerification": faceImageRequiredWithDocumentVerification, "canInitiateDocumentCapture": canInitiateDocumentCapture])
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
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(owner: String, verified: Bool, verifiedAtEpochMs: Double, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil, requiredVerificationMethod: String? = nil, acceptableDocumentTypes: [String], documentVerificationStatus: String, verificationLastAttemptedAtEpochMs: Double) {
        self.init(snapshot: ["__typename": "VerifiedIdentity", "owner": owner, "verified": verified, "verifiedAtEpochMs": verifiedAtEpochMs, "verificationMethod": verificationMethod, "canAttemptVerificationAgain": canAttemptVerificationAgain, "idScanUrl": idScanUrl, "requiredVerificationMethod": requiredVerificationMethod, "acceptableDocumentTypes": acceptableDocumentTypes, "documentVerificationStatus": documentVerificationStatus, "verificationLastAttemptedAtEpochMs": verificationLastAttemptedAtEpochMs])
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
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(owner: String, verified: Bool, verifiedAtEpochMs: Double, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil, requiredVerificationMethod: String? = nil, acceptableDocumentTypes: [String], documentVerificationStatus: String, verificationLastAttemptedAtEpochMs: Double) {
        self.init(snapshot: ["__typename": "VerifiedIdentity", "owner": owner, "verified": verified, "verifiedAtEpochMs": verifiedAtEpochMs, "verificationMethod": verificationMethod, "canAttemptVerificationAgain": canAttemptVerificationAgain, "idScanUrl": idScanUrl, "requiredVerificationMethod": requiredVerificationMethod, "acceptableDocumentTypes": acceptableDocumentTypes, "documentVerificationStatus": documentVerificationStatus, "verificationLastAttemptedAtEpochMs": verificationLastAttemptedAtEpochMs])
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

internal struct VerifiedIdentity: GraphQLFragment {
  internal static let fragmentString =
    "fragment VerifiedIdentity on VerifiedIdentity {\n  __typename\n  owner\n  verified\n  verifiedAtEpochMs\n  verificationMethod\n  canAttemptVerificationAgain\n  idScanUrl\n  requiredVerificationMethod\n  acceptableDocumentTypes\n  documentVerificationStatus\n  verificationLastAttemptedAtEpochMs\n}"

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
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(owner: String, verified: Bool, verifiedAtEpochMs: Double, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil, requiredVerificationMethod: String? = nil, acceptableDocumentTypes: [String], documentVerificationStatus: String, verificationLastAttemptedAtEpochMs: Double) {
    self.init(snapshot: ["__typename": "VerifiedIdentity", "owner": owner, "verified": verified, "verifiedAtEpochMs": verifiedAtEpochMs, "verificationMethod": verificationMethod, "canAttemptVerificationAgain": canAttemptVerificationAgain, "idScanUrl": idScanUrl, "requiredVerificationMethod": requiredVerificationMethod, "acceptableDocumentTypes": acceptableDocumentTypes, "documentVerificationStatus": documentVerificationStatus, "verificationLastAttemptedAtEpochMs": verificationLastAttemptedAtEpochMs])
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
}
// swiftlint:enable all

}