//
//  TransactionsVC.swift
//  SimpliSave
//
//  Created by DA MAC  M1 154 on 2023/07/18.
//

import UIKit

class TransactionsVC: UIViewController {

// MARK: - Outlets
    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var transactions: UICollectionView!
    @IBOutlet weak var subview: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var balance: UILabel!
    
// MARK: - Data
    
    var transactionsData: TransactionsViewModel!
    private var viewModel = userGetDetails()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchData { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.updateUI()
            }
        }

        // Customise card view with rounded corners and shadow
        
        card.layer.cornerRadius = 15.0
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOffset = CGSize(width: 0, height: 2)
        card.layer.shadowOpacity = 0.3
        card.layer.shadowRadius = 4
        card.clipsToBounds = false
        
        // Customise subview and transactions collection view with rounded corners
        
        subview.layer.cornerRadius = 15.0
        transactions.layer.cornerRadius = 15
        subview.layer.shadowColor = UIColor.black.cgColor
        subview.layer.shadowOffset = CGSize(width: 0, height: 2)
        subview.layer.shadowOpacity = 0.1
        subview.layer.shadowRadius = 4
        
        // Register custom collection view cell class
        setup()
        transactions.register(TransactionsCollectionViewCell.self, forCellWithReuseIdentifier: "theCell")
      
        
        // gets registered userName to display
        
        if let user_Name = UserDefaults.standard.data(forKey: "reg1"), let name = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(user_Name) as? [String] {

        }
        
        let token = TokenManager()
        if token.isExpire {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let dashboard = storyboard.instantiateViewController(withIdentifier: "Login") as? LoginVC {
                self.navigationController?.pushViewController(dashboard, animated: true)
            }        } else {
            print("Still Valid")
        }
    }
    
    
    //Calls the fetchDataFromJSON function in the services file
    //Updated: added DispatchQueue
    func setup() {
        TransactionService().fetchDataFromJSON(completion: { data in
            self.transactionsData = (TransactionsViewModel(transactions: data ?? []))
            //print(self.transactionsData)
            DispatchQueue.main.async {
                self.transactions.reloadData()
            }
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setup()
    }
}        
      
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

    extension TransactionsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        //Calls numberOfRowsInSection function from TransactionViewModel
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if let numberOfRows = transactionsData?.numberOfRowsInSection(section) {
                    return numberOfRows
                } else {
                    return 0
                }
        }
        
        //Populates the table from the data fetche through the setup function
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TransactionsCollectionViewCell else {
                return UICollectionViewCell()
            }
            
                   let date = Date()
                    
                    //getting current date in this format "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" 
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                    dateFormatter.timeZone = TimeZone(identifier: "UTC+2")
                    let currentDate = dateFormatter.string(from: date)

            let transaction = self.transactionsData.transactionAtIndex(indexPath.row)
            
            var highest = 0
            
            for item in self.transactionsData.transactions{
                if highest == 0 || item.transactionID > highest{
                    highest = item.transactionID
                }
            }
            let lastBalance = self.transactionsData.transactions.first { TransactionElement in
                TransactionElement.transactionID == highest
            }?.availableBalance
            
            if let lastAvailableBalance = lastBalance {
                 balance.text = "R" + String(lastAvailableBalance)
                //balance.text="R " + String(transaction.balance)
            } else {
                balance.text = "N/A"
            }
            
            cell.nameOfTransaction.text = transaction.description
            if transaction.moneyOut == 0 {
                cell.price.text = "+R" + String(transaction.moneyIn)
            }else{
                cell.price.text = "-R" + String(transaction.moneyOut)
            }
            
            let dateSubString = (transaction.transactionDate).prefix(10)
            
            cell.date.text = String(dateSubString)
            
            cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.00)
            cell.layer.cornerRadius = 15.0
            cell.clipsToBounds = false
//            if((transaction.transactionDate).prefix(10)==currentDate.prefix(10)){
//            }
            
          
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 360, height: 90)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        
        //updating UI 25/08/2023
        private func updateUI() {
            userName.text = viewModel.userProfile!.firstName + " " + viewModel.userProfile!.lastName
        }
    }
    

