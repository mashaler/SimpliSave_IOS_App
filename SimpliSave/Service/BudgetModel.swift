//
//  BudgetModel.swift
//  SimpliSave
//
//  Created by DA MAC M1 126 on 2023/08/07.
//

import Foundation

//Model for the budget data for API 14/08/2023, Shahiel
struct Budget: Codable {
//    var amountSet, progressAmount: Int
//    var transactionsType: String
    
//    var amountSet, progressAmount: Int
//    var transactionsType, status: String
    let budgets: [BudgetElement]
    let message: String
    let status: Int
}

struct BudgetElement: Codable, Equatable {
    let budgetID, amountSet, progressAmount: Int
    let budgetCreated, budgetStatus, transactionsType: String
    
    enum CodingKeys: String, CodingKey {
            case budgetID = "budgetId"
            case amountSet, progressAmount, budgetCreated, budgetStatus, transactionsType
        }
}

func ==(lhs: BudgetElement, rhs: BudgetElement) -> Bool {
    
    return lhs.transactionsType == rhs.transactionsType &&
           lhs.amountSet == rhs.amountSet &&
           lhs.progressAmount == rhs.progressAmount &&
           lhs.budgetStatus == rhs.budgetStatus
}

