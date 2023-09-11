//
//  SavingsViewModel.swift
//  SimpliSave
//
//  Created by DA MAC M1 126 on 2023/08/10.
//

import Foundation

struct SavingsViewModel{
    
    var savings: [Saving]
    
//    func numberOfRowsInSection(_ section:Int) -> Int{
//        return savings.count
//    }
//
//    func budgetsAtIndex(_ index: Int) -> SavingViewModel {
//        var budgets = self.savings[index]
//        return SavingViewModel(saving: budgets)
//    }

}

struct SavingViewModel {
    var saving: Saving
    
    init(saving: Saving) {
        self.saving = saving
    }
}

extension SavingViewModel{
    var amountSet: Int{
        return self.saving.amountSet
    }
    
    var currentSavings: Int{
        return self.saving.currentSaved
    }
    
    var goalID: Int{
        return self.saving.goalID
    }
    
    var deletedGoal: Bool{
        return self.saving.deleteGoalSavings
    }
    
    var deleted: Bool{
        return self.saving.deleted
    }
    
    var description: String{
        return self.saving.description
    }
    
    var date: String{
        return self.saving.dateCreated
    }
}
