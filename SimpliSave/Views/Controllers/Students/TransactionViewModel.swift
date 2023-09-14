//
//  TransactionViewModel.swift
//  SimpliSave
//

import Foundation

struct TransactionsViewModel {
    
    let transactions: [TransactionElement]
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section:Int) -> Int {
        return transactions.count
    }
    
    func transactionAtIndex(_ index: Int) -> TransactionViewModel {
        let transactions = self.transactions[index]
        return TransactionViewModel(transactions)
    }
    
}

struct TransactionViewModel {
    private let transactions: TransactionElement
    
    
    init(_ transaction: TransactionElement){
        self.transactions = transaction
    }
}

extension TransactionViewModel {
    var transactionType: String{
        return self.transactions.transactionType
    }
    
    var moneyOut: Int{
        return self.transactions.moneyOut
    }
    
    var moneyIn: Int{
        return self.transactions.moneyIn
    }
    
    var description: String{
        return self.transactions.description
    }
    
    var transactionDate: String{
        return self.transactions.transactionDate
    }
    
    var balance: Int{
        return self.transactions.availableBalance
    }
}
