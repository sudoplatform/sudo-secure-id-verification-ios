// swiftlint:disable all
//  This file was automatically generated and should not be edited.

import AWSAppSync

internal struct GraphQL {
internal struct VerifyIdentityInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(verificationMethod: String, firstName: String, lastName: String, address: String, city: Optional<String?> = nil, state: Optional<String?> = nil, postalCode: String, country: String, dateOfBirth: String) {
    graphQLMap = ["verificationMethod": verificationMethod, "firstName": firstName, "lastName": lastName, "address": address, "city": city, "state": state, "postalCode": postalCode, "country": country, "dateOfBirth": dateOfBirth]
  }

  internal var verificationMethod: String {
    get {
      return graphQLMap["verificationMethod"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "verificationMethod")
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

  internal var state: Optional<String?> {
    get {
      return graphQLMap["state"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "state")
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
}

internal struct VerifyIdentityDocumentInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(verificationMethod: String, imageBase64: String, backImageBase64: String, country: String, documentType: String) {
    graphQLMap = ["verificationMethod": verificationMethod, "imageBase64": imageBase64, "backImageBase64": backImageBase64, "country": country, "documentType": documentType]
  }

  internal var verificationMethod: String {
    get {
      return graphQLMap["verificationMethod"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "verificationMethod")
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
}

internal final class VerifyIdentityMutation: GraphQLMutation {
  internal static let operationString =
    "mutation VerifyIdentity($input: VerifyIdentityInput!) {\n  verifyIdentity(input: $input) {\n    __typename\n    ...VerifiedIdentity\n  }\n}"

  internal static var requestString: String { return operationString.appending(VerifiedIdentity.fragmentString) }

  internal var input: VerifyIdentityInput

  internal init(input: VerifyIdentityInput) {
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
        GraphQLField("verifiedAtEpochMs", type: .scalar(Double.self)),
        GraphQLField("verificationMethod", type: .nonNull(.scalar(String.self))),
        GraphQLField("canAttemptVerificationAgain", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("idScanUrl", type: .scalar(String.self)),
        GraphQLField("requiredVerificationMethod", type: .scalar(String.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(owner: String, verified: Bool, verifiedAtEpochMs: Double? = nil, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil, requiredVerificationMethod: String? = nil) {
        self.init(snapshot: ["__typename": "VerifiedIdentity", "owner": owner, "verified": verified, "verifiedAtEpochMs": verifiedAtEpochMs, "verificationMethod": verificationMethod, "canAttemptVerificationAgain": canAttemptVerificationAgain, "idScanUrl": idScanUrl, "requiredVerificationMethod": requiredVerificationMethod])
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

      internal var verifiedAtEpochMs: Double? {
        get {
          return snapshot["verifiedAtEpochMs"] as? Double
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
    "mutation VerifyIdentityDocument($input: VerifyIdentityDocumentInput!) {\n  verifyIdentityDocument(input: $input) {\n    __typename\n    ...VerifiedIdentity\n  }\n}"

  internal static var requestString: String { return operationString.appending(VerifiedIdentity.fragmentString) }

  internal var input: VerifyIdentityDocumentInput

  internal init(input: VerifyIdentityDocumentInput) {
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
        GraphQLField("verifiedAtEpochMs", type: .scalar(Double.self)),
        GraphQLField("verificationMethod", type: .nonNull(.scalar(String.self))),
        GraphQLField("canAttemptVerificationAgain", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("idScanUrl", type: .scalar(String.self)),
        GraphQLField("requiredVerificationMethod", type: .scalar(String.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(owner: String, verified: Bool, verifiedAtEpochMs: Double? = nil, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil, requiredVerificationMethod: String? = nil) {
        self.init(snapshot: ["__typename": "VerifiedIdentity", "owner": owner, "verified": verified, "verifiedAtEpochMs": verifiedAtEpochMs, "verificationMethod": verificationMethod, "canAttemptVerificationAgain": canAttemptVerificationAgain, "idScanUrl": idScanUrl, "requiredVerificationMethod": requiredVerificationMethod])
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

      internal var verifiedAtEpochMs: Double? {
        get {
          return snapshot["verifiedAtEpochMs"] as? Double
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
        GraphQLField("verifiedAtEpochMs", type: .scalar(Double.self)),
        GraphQLField("verificationMethod", type: .nonNull(.scalar(String.self))),
        GraphQLField("canAttemptVerificationAgain", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("idScanUrl", type: .scalar(String.self)),
        GraphQLField("requiredVerificationMethod", type: .scalar(String.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(owner: String, verified: Bool, verifiedAtEpochMs: Double? = nil, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil, requiredVerificationMethod: String? = nil) {
        self.init(snapshot: ["__typename": "VerifiedIdentity", "owner": owner, "verified": verified, "verifiedAtEpochMs": verifiedAtEpochMs, "verificationMethod": verificationMethod, "canAttemptVerificationAgain": canAttemptVerificationAgain, "idScanUrl": idScanUrl, "requiredVerificationMethod": requiredVerificationMethod])
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

      internal var verifiedAtEpochMs: Double? {
        get {
          return snapshot["verifiedAtEpochMs"] as? Double
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

internal final class GetSupportedCountriesQuery: GraphQLQuery {
  internal static let operationString =
    "query GetSupportedCountries {\n  getSupportedCountries {\n    __typename\n    ...SupportedCountries\n  }\n}"

  internal static var requestString: String { return operationString.appending(SupportedCountries.fragmentString) }

  internal init() {
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getSupportedCountries", type: .object(GetSupportedCountry.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getSupportedCountries: GetSupportedCountry? = nil) {
      self.init(snapshot: ["__typename": "Query", "getSupportedCountries": getSupportedCountries.flatMap { $0.snapshot }])
    }

    internal var getSupportedCountries: GetSupportedCountry? {
      get {
        return (snapshot["getSupportedCountries"] as? Snapshot).flatMap { GetSupportedCountry(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getSupportedCountries")
      }
    }

    internal struct GetSupportedCountry: GraphQLSelectionSet {
      internal static let possibleTypes = ["SupportedCountries"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("countryList", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(countryList: [String]) {
        self.init(snapshot: ["__typename": "SupportedCountries", "countryList": countryList])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var countryList: [String] {
        get {
          return snapshot["countryList"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "countryList")
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

        internal var supportedCountries: SupportedCountries {
          get {
            return SupportedCountries(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

internal final class GetSupportedCountriesForIdentityVerificationQuery: GraphQLQuery {
  internal static let operationString =
    "query GetSupportedCountriesForIdentityVerification {\n  getSupportedCountriesForIdentityVerification {\n    __typename\n    ...SupportedCountries\n  }\n}"

  internal static var requestString: String { return operationString.appending(SupportedCountries.fragmentString) }

  internal init() {
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getSupportedCountriesForIdentityVerification", type: .object(GetSupportedCountriesForIdentityVerification.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getSupportedCountriesForIdentityVerification: GetSupportedCountriesForIdentityVerification? = nil) {
      self.init(snapshot: ["__typename": "Query", "getSupportedCountriesForIdentityVerification": getSupportedCountriesForIdentityVerification.flatMap { $0.snapshot }])
    }

    internal var getSupportedCountriesForIdentityVerification: GetSupportedCountriesForIdentityVerification? {
      get {
        return (snapshot["getSupportedCountriesForIdentityVerification"] as? Snapshot).flatMap { GetSupportedCountriesForIdentityVerification(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getSupportedCountriesForIdentityVerification")
      }
    }

    internal struct GetSupportedCountriesForIdentityVerification: GraphQLSelectionSet {
      internal static let possibleTypes = ["SupportedCountries"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("countryList", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(countryList: [String]) {
        self.init(snapshot: ["__typename": "SupportedCountries", "countryList": countryList])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var countryList: [String] {
        get {
          return snapshot["countryList"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "countryList")
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

        internal var supportedCountries: SupportedCountries {
          get {
            return SupportedCountries(snapshot: snapshot)
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
    "fragment VerifiedIdentity on VerifiedIdentity {\n  __typename\n  owner\n  verified\n  verifiedAtEpochMs\n  verificationMethod\n  canAttemptVerificationAgain\n  idScanUrl\n  requiredVerificationMethod\n}"

  internal static let possibleTypes = ["VerifiedIdentity"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("owner", type: .nonNull(.scalar(String.self))),
    GraphQLField("verified", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("verifiedAtEpochMs", type: .scalar(Double.self)),
    GraphQLField("verificationMethod", type: .nonNull(.scalar(String.self))),
    GraphQLField("canAttemptVerificationAgain", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("idScanUrl", type: .scalar(String.self)),
    GraphQLField("requiredVerificationMethod", type: .scalar(String.self)),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(owner: String, verified: Bool, verifiedAtEpochMs: Double? = nil, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil, requiredVerificationMethod: String? = nil) {
    self.init(snapshot: ["__typename": "VerifiedIdentity", "owner": owner, "verified": verified, "verifiedAtEpochMs": verifiedAtEpochMs, "verificationMethod": verificationMethod, "canAttemptVerificationAgain": canAttemptVerificationAgain, "idScanUrl": idScanUrl, "requiredVerificationMethod": requiredVerificationMethod])
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

  internal var verifiedAtEpochMs: Double? {
    get {
      return snapshot["verifiedAtEpochMs"] as? Double
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
}

internal struct SupportedCountries: GraphQLFragment {
  internal static let fragmentString =
    "fragment SupportedCountries on SupportedCountries {\n  __typename\n  countryList\n}"

  internal static let possibleTypes = ["SupportedCountries"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("countryList", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(countryList: [String]) {
    self.init(snapshot: ["__typename": "SupportedCountries", "countryList": countryList])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var countryList: [String] {
    get {
      return snapshot["countryList"]! as! [String]
    }
    set {
      snapshot.updateValue(newValue, forKey: "countryList")
    }
  }
}
} // Closing Brace for GraphQL