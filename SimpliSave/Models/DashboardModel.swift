//
//  DashboardModel.swift
//  SimpliSave
//
//  Created by DA MAC M1 126 on 2023/08/08.
//

import Foundation

//Model for the dashboard data for API 10/08/2023, Shahiel
struct DashBudget: Codable {
//    var amountSet, progressAmount: Int
//    var transactionsType: String
    
//    var amountSet, progressAmount: Int
//    var transactionsType, status: String
    let budgets: [DashElement]
    let message: String
    let status: Int
}

struct DashElement: Codable, Equatable {
    let budgetID, amountSet, progressAmount: Int
    let budgetCreated, budgetStatus, transactionsType: String
    
    enum CodingKeys: String, CodingKey {
            case budgetID = "budgetId"
            case amountSet, progressAmount, budgetCreated, budgetStatus, transactionsType
        }
}

struct Display: Codable, Equatable {
    let budgetID, amountSet, progressAmount: Int
    let percentage: Double
    let budgetCreated, budgetStatus, transactionsType: String
    
    enum CodingKeys: String, CodingKey {
            case budgetID = "budgetId"
            case amountSet, progressAmount, budgetCreated, budgetStatus, transactionsType, percentage
        }

}

func ==(lhs: Display, rhs: Display) -> Bool {
    
    return lhs.transactionsType == rhs.transactionsType &&
           lhs.amountSet == rhs.amountSet &&
           lhs.progressAmount == rhs.progressAmount &&
           lhs.budgetStatus == rhs.budgetStatus &&
           lhs.percentage == rhs.percentage
}

func ==(lhs: DashElement, rhs: DashElement) -> Bool {
    
    return lhs.transactionsType == rhs.transactionsType &&
           lhs.amountSet == rhs.amountSet &&
           lhs.progressAmount == rhs.progressAmount &&
           lhs.budgetStatus == rhs.budgetStatus
}
