//
//  BudgetModel.swift
//  SimpliSave

//

import Foundation

//Model for the budget data for API 
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

