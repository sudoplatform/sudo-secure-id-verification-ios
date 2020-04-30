//  This file was automatically generated and should not be edited.

import AWSAppSync

public struct VerifyIdentityInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(verificationMethod: String, firstName: String, lastName: String, address: String, city: Optional<String?> = nil, state: Optional<String?> = nil, postalCode: String, country: String, dateOfBirth: String) {
    graphQLMap = ["verificationMethod": verificationMethod, "firstName": firstName, "lastName": lastName, "address": address, "city": city, "state": state, "postalCode": postalCode, "country": country, "dateOfBirth": dateOfBirth]
  }

  public var verificationMethod: String {
    get {
      return graphQLMap["verificationMethod"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "verificationMethod")
    }
  }

  public var firstName: String {
    get {
      return graphQLMap["firstName"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "firstName")
    }
  }

  public var lastName: String {
    get {
      return graphQLMap["lastName"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lastName")
    }
  }

  public var address: String {
    get {
      return graphQLMap["address"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address")
    }
  }

  public var city: Optional<String?> {
    get {
      return graphQLMap["city"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "city")
    }
  }

  public var state: Optional<String?> {
    get {
      return graphQLMap["state"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "state")
    }
  }

  public var postalCode: String {
    get {
      return graphQLMap["postalCode"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "postalCode")
    }
  }

  public var country: String {
    get {
      return graphQLMap["country"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "country")
    }
  }

  public var dateOfBirth: String {
    get {
      return graphQLMap["dateOfBirth"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "dateOfBirth")
    }
  }
}

public struct VerifyIdentityDocumentInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(verificationMethod: String, imageBase64: String, backImageBase64: String, country: String, documentType: String) {
    graphQLMap = ["verificationMethod": verificationMethod, "imageBase64": imageBase64, "backImageBase64": backImageBase64, "country": country, "documentType": documentType]
  }

  public var verificationMethod: String {
    get {
      return graphQLMap["verificationMethod"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "verificationMethod")
    }
  }

  public var imageBase64: String {
    get {
      return graphQLMap["imageBase64"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "imageBase64")
    }
  }

  public var backImageBase64: String {
    get {
      return graphQLMap["backImageBase64"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "backImageBase64")
    }
  }

  public var country: String {
    get {
      return graphQLMap["country"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "country")
    }
  }

  public var documentType: String {
    get {
      return graphQLMap["documentType"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "documentType")
    }
  }
}

public final class PingQuery: GraphQLQuery {
  public static let operationString =
    "query Ping {\n  ping\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("ping", type: .scalar(String.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(ping: String? = nil) {
      self.init(snapshot: ["__typename": "Query", "ping": ping])
    }

    public var ping: String? {
      get {
        return snapshot["ping"] as? String
      }
      set {
        snapshot.updateValue(newValue, forKey: "ping")
      }
    }
  }
}

public final class CheckIdentityVerificationQuery: GraphQLQuery {
  public static let operationString =
    "query CheckIdentityVerification {\n  checkIdentityVerification {\n    __typename\n    owner\n    verified\n    verifiedAtEpochMs\n    verificationMethod\n    canAttemptVerificationAgain\n    idScanUrl\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("checkIdentityVerification", type: .object(CheckIdentityVerification.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(checkIdentityVerification: CheckIdentityVerification? = nil) {
      self.init(snapshot: ["__typename": "Query", "checkIdentityVerification": checkIdentityVerification.flatMap { $0.snapshot }])
    }

    public var checkIdentityVerification: CheckIdentityVerification? {
      get {
        return (snapshot["checkIdentityVerification"] as? Snapshot).flatMap { CheckIdentityVerification(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "checkIdentityVerification")
      }
    }

    public struct CheckIdentityVerification: GraphQLSelectionSet {
      public static let possibleTypes = ["VerifiedIdentity"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.scalar(String.self))),
        GraphQLField("verified", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("verifiedAtEpochMs", type: .scalar(Double.self)),
        GraphQLField("verificationMethod", type: .nonNull(.scalar(String.self))),
        GraphQLField("canAttemptVerificationAgain", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("idScanUrl", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(owner: String, verified: Bool, verifiedAtEpochMs: Double? = nil, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil) {
        self.init(snapshot: ["__typename": "VerifiedIdentity", "owner": owner, "verified": verified, "verifiedAtEpochMs": verifiedAtEpochMs, "verificationMethod": verificationMethod, "canAttemptVerificationAgain": canAttemptVerificationAgain, "idScanUrl": idScanUrl])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var owner: String {
        get {
          return snapshot["owner"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      public var verified: Bool {
        get {
          return snapshot["verified"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "verified")
        }
      }

      public var verifiedAtEpochMs: Double? {
        get {
          return snapshot["verifiedAtEpochMs"] as? Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "verifiedAtEpochMs")
        }
      }

      public var verificationMethod: String {
        get {
          return snapshot["verificationMethod"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "verificationMethod")
        }
      }

      public var canAttemptVerificationAgain: Bool {
        get {
          return snapshot["canAttemptVerificationAgain"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "canAttemptVerificationAgain")
        }
      }

      public var idScanUrl: String? {
        get {
          return snapshot["idScanUrl"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "idScanUrl")
        }
      }
    }
  }
}

public final class GetSupportedCountriesQuery: GraphQLQuery {
  public static let operationString =
    "query GetSupportedCountries {\n  getSupportedCountries {\n    __typename\n    countryList\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getSupportedCountries", type: .object(GetSupportedCountry.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(getSupportedCountries: GetSupportedCountry? = nil) {
      self.init(snapshot: ["__typename": "Query", "getSupportedCountries": getSupportedCountries.flatMap { $0.snapshot }])
    }

    public var getSupportedCountries: GetSupportedCountry? {
      get {
        return (snapshot["getSupportedCountries"] as? Snapshot).flatMap { GetSupportedCountry(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getSupportedCountries")
      }
    }

    public struct GetSupportedCountry: GraphQLSelectionSet {
      public static let possibleTypes = ["SupportedCountries"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("countryList", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(countryList: [String]) {
        self.init(snapshot: ["__typename": "SupportedCountries", "countryList": countryList])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var countryList: [String] {
        get {
          return snapshot["countryList"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "countryList")
        }
      }
    }
  }
}

public final class GetSupportedCountriesForIdentityVerificationQuery: GraphQLQuery {
  public static let operationString =
    "query GetSupportedCountriesForIdentityVerification {\n  getSupportedCountriesForIdentityVerification {\n    __typename\n    countryList\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getSupportedCountriesForIdentityVerification", type: .object(GetSupportedCountriesForIdentityVerification.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(getSupportedCountriesForIdentityVerification: GetSupportedCountriesForIdentityVerification? = nil) {
      self.init(snapshot: ["__typename": "Query", "getSupportedCountriesForIdentityVerification": getSupportedCountriesForIdentityVerification.flatMap { $0.snapshot }])
    }

    public var getSupportedCountriesForIdentityVerification: GetSupportedCountriesForIdentityVerification? {
      get {
        return (snapshot["getSupportedCountriesForIdentityVerification"] as? Snapshot).flatMap { GetSupportedCountriesForIdentityVerification(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getSupportedCountriesForIdentityVerification")
      }
    }

    public struct GetSupportedCountriesForIdentityVerification: GraphQLSelectionSet {
      public static let possibleTypes = ["SupportedCountries"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("countryList", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(countryList: [String]) {
        self.init(snapshot: ["__typename": "SupportedCountries", "countryList": countryList])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var countryList: [String] {
        get {
          return snapshot["countryList"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "countryList")
        }
      }
    }
  }
}

public final class VerifyIdentityMutation: GraphQLMutation {
  public static let operationString =
    "mutation VerifyIdentity($input: VerifyIdentityInput) {\n  verifyIdentity(input: $input) {\n    __typename\n    owner\n    verified\n    verifiedAtEpochMs\n    verificationMethod\n    canAttemptVerificationAgain\n    idScanUrl\n  }\n}"

  public var input: VerifyIdentityInput?

  public init(input: VerifyIdentityInput? = nil) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("verifyIdentity", arguments: ["input": GraphQLVariable("input")], type: .object(VerifyIdentity.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(verifyIdentity: VerifyIdentity? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "verifyIdentity": verifyIdentity.flatMap { $0.snapshot }])
    }

    public var verifyIdentity: VerifyIdentity? {
      get {
        return (snapshot["verifyIdentity"] as? Snapshot).flatMap { VerifyIdentity(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "verifyIdentity")
      }
    }

    public struct VerifyIdentity: GraphQLSelectionSet {
      public static let possibleTypes = ["VerifiedIdentity"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.scalar(String.self))),
        GraphQLField("verified", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("verifiedAtEpochMs", type: .scalar(Double.self)),
        GraphQLField("verificationMethod", type: .nonNull(.scalar(String.self))),
        GraphQLField("canAttemptVerificationAgain", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("idScanUrl", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(owner: String, verified: Bool, verifiedAtEpochMs: Double? = nil, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil) {
        self.init(snapshot: ["__typename": "VerifiedIdentity", "owner": owner, "verified": verified, "verifiedAtEpochMs": verifiedAtEpochMs, "verificationMethod": verificationMethod, "canAttemptVerificationAgain": canAttemptVerificationAgain, "idScanUrl": idScanUrl])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var owner: String {
        get {
          return snapshot["owner"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      public var verified: Bool {
        get {
          return snapshot["verified"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "verified")
        }
      }

      public var verifiedAtEpochMs: Double? {
        get {
          return snapshot["verifiedAtEpochMs"] as? Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "verifiedAtEpochMs")
        }
      }

      public var verificationMethod: String {
        get {
          return snapshot["verificationMethod"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "verificationMethod")
        }
      }

      public var canAttemptVerificationAgain: Bool {
        get {
          return snapshot["canAttemptVerificationAgain"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "canAttemptVerificationAgain")
        }
      }

      public var idScanUrl: String? {
        get {
          return snapshot["idScanUrl"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "idScanUrl")
        }
      }
    }
  }
}

public final class VerifyIdentityDocumentMutation: GraphQLMutation {
  public static let operationString =
    "mutation VerifyIdentityDocument($input: VerifyIdentityDocumentInput) {\n  verifyIdentityDocument(input: $input) {\n    __typename\n    owner\n    verified\n    verifiedAtEpochMs\n    verificationMethod\n    canAttemptVerificationAgain\n    idScanUrl\n  }\n}"

  public var input: VerifyIdentityDocumentInput?

  public init(input: VerifyIdentityDocumentInput? = nil) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("verifyIdentityDocument", arguments: ["input": GraphQLVariable("input")], type: .object(VerifyIdentityDocument.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(verifyIdentityDocument: VerifyIdentityDocument? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "verifyIdentityDocument": verifyIdentityDocument.flatMap { $0.snapshot }])
    }

    public var verifyIdentityDocument: VerifyIdentityDocument? {
      get {
        return (snapshot["verifyIdentityDocument"] as? Snapshot).flatMap { VerifyIdentityDocument(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "verifyIdentityDocument")
      }
    }

    public struct VerifyIdentityDocument: GraphQLSelectionSet {
      public static let possibleTypes = ["VerifiedIdentity"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.scalar(String.self))),
        GraphQLField("verified", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("verifiedAtEpochMs", type: .scalar(Double.self)),
        GraphQLField("verificationMethod", type: .nonNull(.scalar(String.self))),
        GraphQLField("canAttemptVerificationAgain", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("idScanUrl", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(owner: String, verified: Bool, verifiedAtEpochMs: Double? = nil, verificationMethod: String, canAttemptVerificationAgain: Bool, idScanUrl: String? = nil) {
        self.init(snapshot: ["__typename": "VerifiedIdentity", "owner": owner, "verified": verified, "verifiedAtEpochMs": verifiedAtEpochMs, "verificationMethod": verificationMethod, "canAttemptVerificationAgain": canAttemptVerificationAgain, "idScanUrl": idScanUrl])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var owner: String {
        get {
          return snapshot["owner"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      public var verified: Bool {
        get {
          return snapshot["verified"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "verified")
        }
      }

      public var verifiedAtEpochMs: Double? {
        get {
          return snapshot["verifiedAtEpochMs"] as? Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "verifiedAtEpochMs")
        }
      }

      public var verificationMethod: String {
        get {
          return snapshot["verificationMethod"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "verificationMethod")
        }
      }

      public var canAttemptVerificationAgain: Bool {
        get {
          return snapshot["canAttemptVerificationAgain"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "canAttemptVerificationAgain")
        }
      }

      public var idScanUrl: String? {
        get {
          return snapshot["idScanUrl"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "idScanUrl")
        }
      }
    }
  }
}