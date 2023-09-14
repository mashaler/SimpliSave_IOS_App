import UIKit

class ManageBudgetVC: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblRecieved: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var collectionSubView: UIView!

    //var amountDeposited: Double = 5000
    var budgetData: BudgetsViewModel!
    var transactionsData: TransactionsViewModel!
    var lastBalance: Double = 0.0
    var Balance: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        //viewDidLoad()
        navigationItem.title = "Budget"
        //lblRecieved.text = String(amountDeposited)
        summaryView.layer.cornerRadius = 15.0
        collectionSubView.layer.cornerRadius = 15.0
        tableView.layer.cornerRadius = 15.0
        summaryView.clipsToBounds = false
        
        summaryView.layer.shadowColor = UIColor.black.cgColor
        summaryView.layer.shadowOffset = CGSize(width: 0, height: 2)
        summaryView.layer.shadowOpacity = 0.1
        summaryView.layer.shadowRadius = 4
        
        collectionSubView.layer.shadowColor = UIColor.black.cgColor
        collectionSubView.layer.shadowOffset = CGSize(width: 0, height: 2)
        collectionSubView.layer.shadowOpacity = 0.1
        collectionSubView.layer.shadowRadius = 4
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        //getBalance()
        setup()
        
        let token = TokenManager()
        if token.isExpire {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let dashboard = storyboard.instantiateViewController(withIdentifier: "Login") as? LoginVC {
                self.navigationController?.pushViewController(dashboard, animated: true)
            }        } else {
            print("Still Valid")
        }
    }
    
    func setup() {

        getBalance{ lastBalance in self.lastBalance = Double(lastBalance ?? 0)}
        
        BudgetService().fetchBudgetData(completion: { data in
            //print(self.budgetData)
            self.budgetData = BudgetsViewModel(budgets: data?.budgets ?? [])

            //self.tableView.reloadData()
            DispatchQueue.main.async {
                //self.viewDidLoad()
                self.tableView.reloadData()
                super.viewDidLoad()
            }
        })
        
        TransactionService().fetchDataFromJSON(completion: { data in
            self.transactionsData = TransactionsViewModel(transactions: data ?? [])
            //print(self.transactionsData)
            DispatchQueue.main.async {
                self.lblRecieved.text = "R" + String(self.getRecieved()) + "0"
                self.lblBalance.text = "R" + String(self.lastBalance) + "0"
            }
        })

    }
    
    func getCount(completion: @escaping (Int?) -> Void) {

        BudgetService().fetchBudgetData(completion: { data in
            
            let budgetData = data?.budgets ?? []
            self.budgetData = BudgetsViewModel(budgets: budgetData)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            let count = budgetData.count
            completion(count)

        })
    }
    
    func displayBalance(){
        getBalance{ lastBalance in self.lastBalance = Double(lastBalance ?? 0)}
        
        self.Balance = self.lastBalance - (Double(checkBudget()) ?? 0.0)
    }
    
    func getBalance(completion: @escaping (Double?) -> Void) {
        TransactionService().fetchDataFromJSON(completion: { data in
            
            let transactions = data ?? []
            self.transactionsData = TransactionsViewModel(transactions: transactions)
            
            DispatchQueue.main.async {
            }
            
            var highest = 0
            
            for item in self.transactionsData.transactions{
                if highest == 0 || item.transactionID > highest{
                    highest = item.transactionID
                }
            }
            let lastBalance = self.transactionsData.transactions.first { TransactionElement in
                TransactionElement.transactionID == highest
            }?.availableBalance
            
            let Balance = Double(lastBalance ?? 0) - (Double(self.checkBudget()) ?? 0.0)
            
            completion(Balance)
        })
    }

    // MARK: - IBActions

    //IBAction to add new expense
    @IBAction func addBtn(_ sender: Any) {
        if Double(checkBudget()) ?? 0 >= lastBalance{
            let alertController = UIAlertController(title: "Limit Reached", message: "You have R0 left to budget", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "OK", style: .default) { _ in

            }

            alertController.addAction(submitAction)

            self.present(alertController, animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "Add To Budget", message: "Please enter an amount and select a category (R\(checkBudget())):", preferredStyle: .alert)
            alertController.addTextField { (textField) in
                textField.placeholder = "Your amount here"
                
            }
            
            //controls the color of the texts and triggers the alert controller
            addCategoryAction(for: "FOOD", color: .black, alertController: alertController)
            addCategoryAction(for: "TRANSPORT", color: .gray, alertController: alertController)
            addCategoryAction(for: "TUITION", color: .gray, alertController: alertController)
            addCategoryAction(for: "BOOKS", color: .gray, alertController: alertController)
            addCategoryAction(for: "ACCOMMODATION", color: .gray, alertController: alertController)
            addCategoryAction(for: "OTHER", color: .gray, alertController: alertController)
            
            //control the action of when you click cancel button
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
            cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
            tableView.reloadData()

         }
      
    }
    
    // MARK: - AddsCategory
    
    //Creates new category in alert
    func addCategoryAction(for name: String, color: UIColor, alertController: UIAlertController) {
        tableView.reloadData()

        let action = UIAlertAction(title: name, style: .default) { _ in
            if let textField = alertController.textFields?.first, let newGoal = textField.text {
                //self.addExpense(name: name, newGoal: newGoal)
                self.tableView.reloadData()

 //               valiateds user input to check if a budget is still posible
                var total: Double = 0
                for item in self.budgetData.budgets {
                    total += Double(item.amountSet)
                }

                if let newGoalValue = Double(newGoal), (newGoalValue + total) > self.lastBalance {
                    self.overBudget()
                } else {
                    if newGoal.isEmpty {
                        self.noBudget()
                    } else {

                        self.addExpense(name: name, newGoal: newGoal)
                        
                    }
                }
                self.tableView.reloadData()

            }
        }
         
        action.setValue(color, forKey: "titleTextColor")
        alertController.addAction(action)
        tableView.reloadData()

    }
    
    //adds a new expense to data list when called
    func addExpense(name: String, newGoal: String){
//        BudgetService().addToJson(amount: Int(newGoal) ?? 0)
        //BudgetService().addToJson(amount: Int(newGoal) ?? 0, type: name)
        if (budgetData.budgets.first(where: { $0.transactionsType == name }) != nil) {
            expenseExsits()
        }
        
        if (budgetData.budgets == []) || (budgetData.budgets.first(where: { $0.transactionsType == name }) == nil){

                BudgetService().addToJson(amount: Int(newGoal) ?? 0, type: name)
                //self.items.append(Item(name: newName, status: newStatus, goal: Int(newGoal) ?? 0, progress: newProgress))
                self.tableView.reloadData()
                self.getBalance()
            }
        
        self.tableView.reloadData()
        self.getBalance()
    }
    
    //alert for add if total budget equal to amount deposited
    func noBudget(){
        let alertController = UIAlertController(title: "No budget set", message: "Please set a budget first", preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "OK", style: .default) { _ in
        
        }
        
        alertController.addAction(submitAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    //alert for add if expense already exsists
    func expenseExsits(){
        let alertController = UIAlertController(title: "Already Added", message: "The expense you selected already has a budget", preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "OK", style: .default) { _ in
        
        }
        
        alertController.addAction(submitAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    //alert for add if expense excceds balance
    func overBudget(){
        let alertController = UIAlertController(title: "Limit Reached", message: "You do not have that much left to budget", preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "OK", style: .default) { _ in
        
        }
        
        alertController.addAction(submitAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    func checkBudget() -> String{
        var total: Int = 0
        //setup()
        while budgetData == nil {
            setup()
        }
        for item in budgetData.budgets{
            total = total + item.amountSet
        }
        return String(total)
    }
    
    func getBalance(){
        let budgeted = (Double(checkBudget()) ?? 0)
        if budgeted == 0 {
            let balance = lastBalance
            lblBalance.text = "R" + String(balance) + "0"
        }else{
            let balance = lastBalance - (Double(checkBudget()) ?? 0)
            lblBalance.text = "R" + String(balance) + "0"
        }
        
        if budgeted == 0{
            let balance = lastBalance
            lblBalance.text = "R" + String(balance) + "0"
        }else{
            let balance = lastBalance - budgeted
            lblBalance.text = "R" + String(balance) + "0"
        }
    }
    
    func getRecieved() -> Double{
        
        var count = 0
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM" // Choose your desired date format
        let formattedDate = dateFormatter.string(from: currentDate)
        
        for transaction in transactionsData.transactions {
            if transaction.transactionType == "DEPOSIT"{
                let transactionDate = transaction.transactionDate.suffix(24)
                
                if transactionDate.prefix(2) == formattedDate{
                    count = count + transaction.moneyIn
                }
            }
        }
        return Double(count)
    }
}
    

// MARK: - extension for tableView

extension ManageBudgetVC: UITableViewDataSource {

    //Gets length of data list for number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRows = budgetData?.numberOfRowsInSection(section) {
                return numberOfRows
            } else {
                return 0
            }
    }

    //Loads data from data list into tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as? BudgetTableViewCell

        let budget = self.budgetData.budgetsAtIndex(indexPath.row)
        //print(budget)
        cell?.lblExpCategory.text = budget.transactionType
//        cell?.lblStatus.text = budget.status

        if budget.status == "COMPLETED" {
//            budgetData.budgets[indexPath.row].status = "Complete"
            cell?.lblStatus.text = "Completed"
            cell?.lblStatus.textColor = UIColor(red: 0.00, green: 0.63, blue: 0.18, alpha: 1.00)
            
        }

        if budget.status == "IN_PROGRESS" {
//            budgetData.budgets[indexPath.row].status = "In Progress"
            cell?.lblStatus.text = "In Progress"
            cell?.lblStatus.textColor = UIColor(red: 0.52, green: 0.03, blue: 0.34, alpha: 1.00)
        }

        if budget.status == "OVER_BUDGET" {
//            budgetData.budgets[indexPath.row].status = "Over Budget"
            cell?.lblStatus.text = "Over Budget"
            cell?.lblStatus.textColor = UIColor.red
        }

        let progress = "R" + String(budget.progress) + " of " + "R" + String(budget.amountBudgeted)
        cell?.lblProgress.text = progress
        
        return cell!
    }

    // MARK: - swiping(Delete and edit)
    
    //Adds swiping animation to each row for delete and update
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completion) in
            tableView.beginUpdates()
            //self?.items.remove(at: indexPath.row)
            //let transactionToRemove = Budget(transactionType: "DEPOSIT", amount: 6000.00, description: "ALLOWANCE")
            let id = self?.budgetData.budgets[indexPath.row].budgetID
            BudgetService().delete(id: id ?? 0)
//            BudgetService().removeTransactionFromJSON(ToRemove: (self?.budgetData.budgets[indexPath.row])!)
            self?.budgetData.budgets.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            tableView.endUpdates()
//            self?.getBalance()
            completion(true)
        }
        deleteAction.backgroundColor = UIColor.red

        let moreAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completion) in
            
            let alertController = UIAlertController(title: "Update Expense", message: "How much have you spent today?", preferredStyle: .alert)

            alertController.addTextField { (textField) in
                textField.placeholder = "Your amount here"
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in}

            let submitAction = UIAlertAction(title: "Submit", style: .default) {[weak self] _ in
            
                if let textField = alertController.textFields?.first, let enteredText = textField.text {
                    
                    let newProgress = (self?.budgetData.budgets[indexPath.row].progressAmount ?? 0) + (Int(enteredText) ?? 0)
                    let amountSet = self?.budgetData.budgets[indexPath.row].amountSet
                    let type = self?.budgetData.budgets[indexPath.row].transactionsType
                    let id = self?.budgetData.budgets[indexPath.row].budgetID
                    self?.updateProgress(set: amountSet ?? 0, progress: newProgress, type: type ?? "default", id: id ?? 0)
                    self?.setup()
                }
               
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(submitAction)
            
            self?.present(alertController, animated: true, completion: nil)
        }
        moreAction.backgroundColor = UIColor(red: 0.52, green: 0.03, blue: 0.34, alpha: 1.00)
        
        if budgetData.budgets[indexPath.row].amountSet == budgetData.budgets[indexPath.row].progressAmount || budgetData.budgets[indexPath.row].progressAmount > budgetData.budgets[indexPath.row].amountSet{
            let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
            return swipeConfig
        }else{
            let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction,moreAction])
            return swipeConfig
        }
    }
    
    func updateProgress(set: Int, progress: Int, type: String, id: Int){
        for budget in budgetData.budgets{
            if budget.transactionsType == type{
                BudgetService().updateJson(set: set, progress: progress, type: type, id: id)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
       viewDidLoad()
    }
}

