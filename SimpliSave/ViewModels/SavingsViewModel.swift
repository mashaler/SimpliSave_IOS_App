//
//  SavingsViewModel.swift
//  SimpliSave
//

import Foundation

struct SavingsViewModel{
    
    var savings: [Saving]
    

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
