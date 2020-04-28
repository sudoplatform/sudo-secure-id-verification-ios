//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSAppSync
import SudoLogging

/// Operation to verify an identity.
class VerifyIdentity: SudoOperation {

    /// Verified identity.
    public var verifiedIdentity: VerifiedIdentity?

    private unowned let graphQLClient: AWSAppSyncClient

    private let firstName: String
    private let lastName: String
    private let address: String
    private let city: String?
    private let addressState: String?
    private let postalCode: String
    private let country: String
    private let dateOfBirth: String

    private struct Constants {
        static let verificationMethod = "KNOWLEDGE_OF_PII"
    }

    /// Initializes an operation to verify an identity.
    ///
    /// - Parameters:
    ///   - graphQLClient: GraphQL client to use to interact with identity verification service.
    ///   - logger: Logger to use for logging.
    ///   - firstName: First name
    ///   - lastName: Last name.
    ///   - address: Address.
    ///   - city: City.
    ///   - state: State.
    ///   - postalCode: Postal code.
    ///   - country: Country.
    ///   - dateOfBirth: Date of birth.
    init(graphQLClient: AWSAppSyncClient,
         logger: Logger = Logger.sudoIdentityVerificationClientLogger,
         firstName: String,
         lastName: String,
         address: String,
         city: String?,
         state: String?,
         postalCode: String,
         country: String,
         dateOfBirth: String) {
        self.graphQLClient = graphQLClient
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.city = city
        self.addressState = state
        self.postalCode = postalCode
        self.country = country
        self.dateOfBirth = dateOfBirth
        super.init(logger: logger)
    }

    override func execute() {
        let input = VerifyIdentityInput(verificationMethod: Constants.verificationMethod, firstName: self.firstName, lastName: self.lastName, address: self.address, city: self.city, state: self.addressState, postalCode: self.postalCode, country: self.country, dateOfBirth: self.dateOfBirth)
        self.graphQLClient.perform(mutation: VerifyIdentityMutation(input: input)) { (result, error) in
            if let error = error {
                self.error = error
                return self.done()
            }

            guard let result = result else {
                self.error = SudoOperationError.fatalError(description: "Mutation completed successfully but result is missing.")
                return self.done()
            }

            if let error = result.errors?.first {
                let message = "Failed to verify identity: \(error)"
                self.logger.error(message)

                if let errorType = error[SudoOperation.SudoServiceError.type] as? String {
                    switch errorType {
                    case SudoOperation.SudoServiceError.serviceError:
                        self.error = SudoOperationError.serverError
                    case SudoOperation.SudoServiceError.decodingError:
                        self.error = SudoOperationError.invalidInput
                    default:
                        self.error = SudoOperationError.graphQLError(description: message)
                    }
                } else {
                    self.error = SudoOperationError.graphQLError(description: message)
                }

                return self.done()
            }

            guard let verifiedIdentity = result.data?.verifyIdentity else {
                self.error = SudoOperationError.fatalError(description: "Mutation result did not contain required object.")
                return self.done()
            }

            var verifiedAt: Date?
            if let verifiedAtEpochMs = verifiedIdentity.verifiedAtEpochMs {
                verifiedAt = Date(millisecondsSinceEpoch: verifiedAtEpochMs)
            }

            self.verifiedIdentity = VerifiedIdentity(owner: verifiedIdentity.owner,
                                                     verified: verifiedIdentity.verified,
                                                     verifiedAt: verifiedAt,
                                                     verificationMethod: verifiedIdentity.verificationMethod,
                                                     canAttemptVerificationAgain: verifiedIdentity.canAttemptVerificationAgain,
                                                     idScanUrl: verifiedIdentity.idScanUrl)
            self.done()
        }
    }

}
