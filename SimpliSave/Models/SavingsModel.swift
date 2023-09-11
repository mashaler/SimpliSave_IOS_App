//
//  SavingsModel.swift
//  SimpliSave
//
//  Created by DA MAC M1 126 on 2023/08/10.
//

import Foundation

//Model for the savings data 10/08/2023, Shahiel
//struct Savings: Codable {
//    var amountSet, currentSavings, totalSavings: Double
//    var date: Date
//}

struct Savings: Codable {
    let message: String
    let data: [Saving]
    let httpStatusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case data = "Data"
        case httpStatusCode = "HTTP Status Code"
    }
}

struct Saving: Codable {
    let goalID, amountSet, currentSaved: Int
        let description, dateCreated: String
        let savingsAccount: SavingsAccount2
        let deleteGoalSavings, deleted: Bool
    
    enum CodingKeys: String, CodingKey {
        case goalID = "goalId"
        case amountSet, currentSaved, description, dateCreated, savingsAccount, deleteGoalSavings, deleted
        }
}

struct SavingsAccount2: Codable{
    let savingsAccountID: Int
    let totalSavings: Int
//    let dateUpdated: JSONNull2?
    let dateUpdated: String
    let savingsAccountNumber: String
    
    enum CodingKeys: String, CodingKey {
            case savingsAccountID = "savingsAccountId"
            case totalSavings, dateUpdated, savingsAccountNumber
        }
}

class JSONNull2: Codable, Hashable{
    public static func == (lhs: JSONNull2, rhs: JSONNull2) -> Bool {
            return true
        }

        public var hashValue: Int {
            return 0
        }

        public init() {}

        public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                throw DecodingError.typeMismatch(JSONNull2.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
}




