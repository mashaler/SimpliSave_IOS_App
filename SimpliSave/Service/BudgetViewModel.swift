//
//  BudgetViewModel.swift
//  SimpliSave
//

import Foundation

struct BudgetsViewModel{
    var budgets: [BudgetElement]
    
    func numberOfRowsInSection(_ section:Int) -> Int{
        return budgets.count
    }
    
    func budgetsAtIndex(_ index: Int) -> BudgetViewModel {
        var budgets = self.budgets[index]
        return BudgetViewModel(budget: budgets)
    }

}

struct BudgetViewModel {
    private var budget: BudgetElement
    
    init(budget: BudgetElement) {
        self.budget = budget
    }
}

extension BudgetViewModel{
    var transactionType: String{
        return self.budget.transactionsType
    }
    
    var amountBudgeted: Int{
        return self.budget.amountSet
    }
    
    var progress: Int{
        return self.budget.progressAmount
    }
    
    var status: String{
        return self.budget.budgetStatus
    }
}


