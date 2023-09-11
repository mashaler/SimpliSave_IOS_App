//
//  TransactionModel.swift
//  SimpliSave
//
//  Created by DA MAC M1 126 on 2023/08/04.
//

import Foundation

//Model for the trasactions data 11/08/2023, Shahiel
//Updated Model for the trasactions data for API 14/08/2023, Shahiel
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

