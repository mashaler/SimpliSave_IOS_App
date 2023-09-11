// AccountModel.swift
import Foundation

//struct Account: Codable {
//    //let userId: Int
//    let firstName: String
//    let lastName: String
//    let email: String
//    let cellphoneNumber: String
//    let idNo: String
//    let imageUrl: String?
//    let accounts: [UserAccount]
//}
//
//struct UserAccount: Codable {
//    let accountId: Int
//    let accountNo: String
//    let accountBalance: Double
//    let accountType: String
//    // let savingsAccount: SavingsAccount
//}
//
//struct SavingsAccount: Codable {
//    let savingsAccountId: Int
//    let currentSavingsBalance: Double
//    let savingsAccountNumber: String
//}
//
//// ... other properties as needed

// 29/08/2023 | Rolva
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

// 29/08/2023 | Rolva
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

// 29/08/2023 | Rolva
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

// 29/08/2023 | Rolva
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

// 29/08/2023 | Rolva
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

// MARK: - TransactionElement
//struct TransactionElement: Codable {
//    let transactionID: Int
//    let transactionType: TransactionType
//    let transactionDate, description: String
//    let moneyIn, moneyOut, availableBalance: Int
//
//    enum CodingKeys: String, CodingKey {
//        case transactionID = "transactionId"
//        case transactionType, transactionDate, description, moneyIn, moneyOut, availableBalance
//    }
//}

// 29/08/2023 | Rolva
enum TransactionType: String, Codable {
    case books = "BOOKS"
    case deposit = "DEPOSIT"
    case food = "FOOD"
    case other = "OTHER"
}

// 29/08/2023 | Rolva
// MARK: - Role
struct Role: Codable {
    let id: Int
    let name: Name
}

enum Name: String, Codable {
    case roleStudent = "ROLE_STUDENT"
}

// 29/08/2023 | Rolva
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
