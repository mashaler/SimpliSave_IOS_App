// AccountModel.swift
import Foundation


struct Transaction: Codable {
    let httpStatusCode: Int
    let message: String
    let data: [DataElement]

    enum CodingKeys: String, CodingKey {
        case httpStatusCode = "HTTP Status Code:"
        case message = "Message:"
        case data = "Data:"
    }
}

// 29/08/2023
// MARK: - DataElement
struct DataElement: Codable {
    let userID: Int
    let firstName, lastName: String
    let username: JSONNull?
    let email, cellphoneNumber, password, createdAt: String
    let updatedAt: String
    let deleted: Bool
    let roles: [Role]
    let accounts: [Account]
    let idNo: String
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case firstName, lastName, username, email, cellphoneNumber, password, createdAt, updatedAt, deleted, roles, accounts, idNo
        case imageURL = "imageUrl"
    }
}

// 29/08/2023
// MARK: - Account
struct Account: Codable {
    let accountId: Int
    let accountNo: String
    let transaction: [TransactionElement]
    let accountBalance: Int
    let accountType: AccountType
    let savingsAccount: SavingsAccount
    let deleted: Bool

    enum CodingKeys: String, CodingKey {
        case accountId 
        case accountNo, transaction, accountBalance, accountType, savingsAccount, deleted
    }
}

enum AccountType: String, Codable {
    case mainAccount = "main account"
}

// 29/08/2023
// MARK: - GoalSaving
struct GoalSaving: Codable {
    let goalID, amountSet: Int
    let description, dateCreated: String
    let savingsAccount: SavingsAccount
    let deleteGoalSavings, deleted: Bool

    enum CodingKeys: String, CodingKey {
        case goalID = "goalId"
        case amountSet, description, dateCreated, savingsAccount, deleteGoalSavings, deleted
    }
}

// 29/08/2023
// MARK: - SavingsAccount
struct SavingsAccount: Codable {
    let savingsAccountID, currentSavingsBalance: Int
    let goalSavings: [GoalSaving]?
    let savingsAccountNumber: String

    enum CodingKeys: String, CodingKey {
        case savingsAccountID = "savingsAccountId"
        case currentSavingsBalance, goalSavings, savingsAccountNumber
    }
}


// 29/08/2023
enum TransactionType: String, Codable {
    case books = "BOOKS"
    case deposit = "DEPOSIT"
    case food = "FOOD"
    case other = "OTHER"
}

// 29/08/2023
// MARK: - Role
struct Role: Codable {
    let id: Int
    let name: Name
}

enum Name: String, Codable {
    case roleStudent = "ROLE_STUDENT"
}

// 29/08/2023 
// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
