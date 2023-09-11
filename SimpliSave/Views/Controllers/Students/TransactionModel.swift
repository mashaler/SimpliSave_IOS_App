//
//  TransactionModel.swift
//  SimpliSave
//


import Foundation

//Model for the trasactions data
//Updated Model for the trasactions data for API 
struct TransactionElement: Codable {
    let transactionID: Int
    let transactionType, description: String
    let transactionDate: String
    let moneyIn, moneyOut, availableBalance: Int

    enum CodingKeys: String, CodingKey {
        case transactionID = "transactionId"
        case transactionType, transactionDate, description, moneyIn, moneyOut, availableBalance
    }
}

