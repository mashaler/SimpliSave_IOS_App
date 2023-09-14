//
//  DashboardViewModel.swift
//  SimpliSave
//

import Foundation

struct DashboardsViewModel{
    var dashBudgets: [DashElement]
    
    func numberOfRowsInSection(_ section:Int) -> Int{
        return dashBudgets.count
    }
    
    func dashboardAtIndex(_ index: Int) -> DashboardViewModel {
        var dashBudgets = self.dashBudgets[index]
        return DashboardViewModel(dashBudget: dashBudgets)
    }

}

struct DashboardViewModel {
    private var dashBudget: DashElement
    
    init(dashBudget: DashElement) {
        self.dashBudget = dashBudget
    }
}

extension DashboardViewModel{
    var transactionType: String{
        return self.dashBudget.transactionsType
    }
    
    var amountBudgeted: Int{
        return self.dashBudget.amountSet
    }
    
    var progress: Int{
        return self.dashBudget.progressAmount
    }
    
    var status: String{
        return self.dashBudget.budgetStatus
    }
    
//    var percentage: Double{
//        return self.dashBudget.percentage
//    }
}


struct DisplaysViewModel{
    var dashBudgets: [Display]
    
    func numberOfRowsInSection(_ section:Int) -> Int{
        return dashBudgets.count
    }
    
    func dashboardAtIndex(_ index: Int) -> DisplayViewModel {
        var dashBudgets = self.dashBudgets[index]
        return DisplayViewModel(dashBudget: dashBudgets)
    }

}

struct DisplayViewModel {
    private var dashBudget: Display
    
    init(dashBudget: Display) {
        self.dashBudget = dashBudget
    }
}

extension DisplayViewModel{
    var transactionType: String{
        return self.dashBudget.transactionsType
    }
    
    var amountBudgeted: Int{
        return self.dashBudget.amountSet
    }
    
    var progress: Int{
        return self.dashBudget.progressAmount
    }
    
    var status: String{
        return self.dashBudget.budgetStatus
    }
    
    var percentage: Double{
        return self.dashBudget.percentage
    }
}
