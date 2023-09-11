//
//  SavingsSummaryVC.swift
//  SimpliSave
//
//  Created by DA MAC M1 126 on 2023/07/27.
//
import Charts
import UIKit

struct Save {
    var target: Int
    var saved: Int
}

class SavingsSummaryVC: UIViewController, ChartViewDelegate {

    var pieChart = PieChartView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    @IBOutlet weak var balanceView: UIView!
    @IBOutlet weak var lblSavedThisMonth: UILabel!
    @IBOutlet weak var lblToSave: UILabel!
    @IBOutlet weak var lblSaved: UILabel!
    @IBOutlet weak var lblTarget: UILabel!
    @IBOutlet weak var innerSummaryView: UIView!
    @IBOutlet weak var innerChartView: UIView!
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var lblTotalSaved: UILabel!
    
    var overTarget = false
//    var thisMonthCount: Double = 0.0
    var savingsData: Savings!
    var savings: SavingsViewModel!
    var saving: SavingViewModel!
    var transactionsData: TransactionsViewModel!
    var currentSaved = 0.0
    var amountSet = 0.0
    var totalSaved = 0.0
    var Id = 0
    var isUpdated = false
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        updateOnStart()
        monthlySaved()
  
        navigationItem.title = "Savings"
        innerChartView.layer.cornerRadius = 15.0
        innerChartView.clipsToBounds = false
        
        
        balanceView.layer.cornerRadius = 15.0
        balanceView.layer.shadowColor = UIColor.black.cgColor
        balanceView.layer.shadowOffset = CGSize(width: 0, height: 2)
        balanceView.layer.shadowOpacity = 0.1
        balanceView.layer.shadowRadius = 4
        balanceView.clipsToBounds = false
        
        
        innerSummaryView.layer.cornerRadius = 15.0
        innerSummaryView.clipsToBounds = false
        
        chartView.layer.cornerRadius = 15.0
        chartView.clipsToBounds = false
        chartView.layer.shadowColor = UIColor.black.cgColor
        chartView.layer.shadowOffset = CGSize(width: 0, height: 2)
        chartView.layer.shadowOpacity = 0.1
        chartView.layer.shadowRadius = 4
        
        summaryView.layer.cornerRadius = 15.0
        summaryView.clipsToBounds = false
        summaryView.layer.shadowColor = UIColor.black.cgColor
        summaryView.layer.shadowOffset = CGSize(width: 0, height: 2)
        summaryView.layer.shadowOpacity = 0.1
        summaryView.layer.shadowRadius = 4
        
        let token = TokenManager()
        if token.isExpire {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let dashboard = storyboard.instantiateViewController(withIdentifier: "Login") as? LoginVC {
                self.navigationController?.pushViewController(dashboard, animated: true)
            }        } else {
            print("Still Valid")
        }
    }

    //Calls the fetchSavingsData function in the services file, 10/08/2023, Shahiel
    func setup(){
        getId{ Id in self.Id = Int((Id ?? 0))}
        getCurrentSaved{ currentSavedValue in self.currentSaved = (currentSavedValue ?? 0)}
        getAmountSet{ amountSetValue in self.amountSet = (amountSetValue ?? 0)}
        getTotal{ totalSaved in self.totalSaved = (totalSaved ?? 0)}
 
        SavingsService().fetchSavingsData(completion: { data in
            
            self.savings = SavingsViewModel(savings: data?.data ?? [])
            DispatchQueue.main.async {
                self.lblTarget.text = String(self.amountSet)
                self.lblSaved.text = String(self.currentSaved)
                self.lblTotalSaved.text = String(self.totalSaved)
                self.lblToSave.text = String((self.amountSet) - (self.currentSaved))
                self.generateChart()
            }
        })
        
      
    }
    
    func monthlySaved(){
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM" // Choose your desired date format
        let formattedDate = dateFormatter.string(from: currentDate)
        
        var thisMonthCount = 0.0
        
        TransactionService().fetchDataFromJSON(completion: { data in
            self.transactionsData = (TransactionsViewModel(transactions: data ?? []))
            DispatchQueue.main.async {
//                print(self.transactionsData.transactions)
                for item in self.transactionsData.transactions {
                    let transactionDate = item.transactionDate.prefix(7)
//
//                    print(formattedDate)
//                    print(transactionDate)
                    
                    
                    if transactionDate == formattedDate{
                        //print(item.moneyOut)
                        thisMonthCount = thisMonthCount + Double(item.moneyOut)
                    }
                }
                
                self.lblSavedThisMonth.text = "R" + String(thisMonthCount)
            }
        })
        
   
    }
    
    func getCurrentSaved(completion: @escaping (Double?) -> Void) {
        SavingsService().fetchSavingsData(completion: { data in
            
            let savingsData = data?.data ?? []
            self.savings = SavingsViewModel(savings: savingsData)
            
            DispatchQueue.main.async {
                // Perform any UI updates if needed
            }
            
            // Now you can pass the value of currentSaved using the completion handler
            if let highestGoalIndex = savingsData.firstIndex(where: { $0.goalID == self.Id }){
                let currentSavedValue = Double(self.savings.savings[highestGoalIndex ].currentSaved )
                completion(currentSavedValue)
            }
            
        })
    }
    
    func getAmountSet(completion: @escaping (Double?) -> Void) {
        SavingsService().fetchSavingsData(completion: { data in
            
            let savingsData = data?.data ?? []
            self.savings = SavingsViewModel(savings: savingsData)
            
            DispatchQueue.main.async {
                // Perform any UI updates if needed
            }
            
            // Now you can pass the value of currentSaved using the completion handler
            if(savingsData.count>0){
                let highestGoalIndex = savingsData.firstIndex(where: { $0.goalID == self.Id })
                let amountSetValue = Double(self.savings.savings[highestGoalIndex ?? 0].amountSet)
                //print(amountSetValue)
                completion(amountSetValue)
            }
//            let highestGoalIndex = savingsData.firstIndex(where: { $0.goalID == self.Id })
//            let amountSetValue = Double(self.savings.savings[highestGoalIndex ?? 0].amountSet)
//            print(amountSetValue)
//            completion(amountSetValue)
        })
    }
    
    func getTotal(completion: @escaping (Double?) -> Void) {
        SavingsService().fetchSavingsData(completion: { data in
            
            let savingsData = data?.data ?? []
            self.savings = SavingsViewModel(savings: savingsData)
            
            DispatchQueue.main.async {
                // Perform any UI updates if needed
            }
            
            // Now you can pass the value of currentSaved using the completion handler
           // let highestGoalIndex = savingsData.firstIndex(where: { $0.goalID == self.Id })
            let totalSaved = Double(self.savings.savings.last?.savingsAccount.totalSavings ?? 0)
            completion(totalSaved)
        })
    }
    
    func getId(completion: @escaping (Double?) -> Void) {
        SavingsService().fetchSavingsData(completion: { data in
            let setDefault = [Saving(goalID: 9, amountSet: 100, currentSaved: 5, description: "String", dateCreated: "String", savingsAccount: SavingsAccount2(savingsAccountID: 1, totalSavings: 5, dateUpdated: "nil", savingsAccountNumber: "JSONNull2"), deleteGoalSavings: false, deleted: false)]
            
            let savingsData = data?.data ?? setDefault
            self.savings = SavingsViewModel(savings: savingsData)
            
            DispatchQueue.main.async {
                // Perform any UI updates if needed
            }
            
            // Now you can pass the value of currentSaved using the completion handler
            let highestGoalId = savingsData.map({ $0.goalID }).max() ?? 0
            completion(Double(highestGoalId))
//            let Id = Double(self.savings.savings.last?.goalID ?? 0)
//            completion(Id)
        })
    }
    
    //Update code that is called when required, but is for the first instance where total and current savings will need to 0, 10/08/2023, Shahiel
    func updateOnStart(){
        //SavingsService().addNewGoal(ToAdd:UserDefaults.standard.integer(forKey: "reg7"))
        setup()
    }
    
    //Update code that is called when required, 10/08/2023, Shahiel
    func update(set: Double,current: Double,total: Double){
        SavingsService().updateJson(ToUpdate: Int(current), id: Int(Id))
        setup()
        viewDidAppear(false)
    }
    
    func add(newGoal: Int){
        SavingsService().addNewGoal(ToAdd: newGoal)
        setup()
        viewDidAppear(false)
    }
    // MARK: - IBActions
    
    //Peforms action on button click, 02/08/23, Shahiel
    @IBAction func btnUpdateSavings(_ sender: Any) {
        isMonthEnd()
    }
    
    // MARK: - updateSaved
    
    //Prompts alert to update savings, 02/08/23, Shahiel
    func updateSaved(){
        let alertController = UIAlertController(title: "Update Savings", message: "How much have you saved today?", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            textField.placeholder = "Your text here"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }

        let submitAction = UIAlertAction(title: "Submit", style: .default) {[weak self] _ in
        
            if let textField = alertController.textFields?.first, let enteredText = textField.text {
                
                let userInput = (Double(enteredText) ?? 0)

                if ((self?.currentSaved ?? 0) + (userInput)) > (self?.amountSet ?? 0){
                    //Handles update when users savings exceed target, 02/08/23, Shahiel
                    self?.ifExeeded(input: userInput)
                    //self?.setup()
                    self?.viewDidAppear(false)
                }else{
                    //Handles update when users savings is blow target, 02/08/23, Shahiel
                    self?.ifNotExeeded(input: userInput)
                    //self?.setup()
                    self?.viewDidAppear(false)
                }
            }
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - targetReached
    
    //Handles update when users savings target is reached, 02/08/23, Shahiel
    func targetReached(){
        //print(overTarget)
        if overTarget == false {
            newTarget()
        }else{
            let alertController = UIAlertController(title: "Over Target", message: "You have saved more then the set target", preferredStyle: .alert)

            let submitAction = UIAlertAction(title: "Submit", style: .default) {[weak self] _ in
                self?.newTarget()
            }
            
            alertController.addAction(submitAction)
            
            present(alertController, animated: true, completion: nil)
        }
        setup()
    }
    
    //Checks and performs code if budget limit is not exceeded, 10/08/2023, Shahiel
    func ifNotExeeded(input: Double){
        let toUpdate = (input)
        update(set: 0,current: toUpdate,total: 0)
        //setup()
//        thisMonthCount = (thisMonthCount) + ((input))
        monthlySaved()
//        lblSavedThisMonth.text = String(thisMonthCount)
    }
    
    //Checks and performs code if budget limit is exceeded, 10/08/2023, Shahiel
    func ifExeeded(input: Double){
        add(newGoal: Int(input))
        //setup()
//        thisMonthCount = (thisMonthCount) + (input)
        monthlySaved()
//        lblSavedThisMonth.text = String(thisMonthCount)
        overTarget = true
    }
    // MARK: - newTarget
    
    //prompts alert to sets new savings target, 02/08/23, Shahiel
    func newTarget(){
        let alertController = UIAlertController(title: "Add New Savings Target", message: "What is your next target", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            textField.placeholder = "Your text here"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.add(newGoal: 0)
            self.setup()
        }

        let submitAction = UIAlertAction(title: "Submit", style: .default) {[weak self] _ in
        
            if let textField = alertController.textFields?.first, let enteredText = textField.text {
                self?.add(newGoal: Int(enteredText) ?? 0)
                self?.setup()
            }
           
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)
        
        present(alertController, animated: true, completion: nil)
        setup()
    }
    
    // MARK: - generateChart
    //Handles to generate and uodate the piechart, 02/08/23, Shahiel
    func generateChart(){
        innerChartView.addSubview(pieChart)
        
        //Sets location of piechart in specified view, 02/08/23, Shahiel
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pieChart.centerXAnchor.constraint(equalTo: innerChartView.centerXAnchor),
            pieChart.centerYAnchor.constraint(equalTo: innerChartView.centerYAnchor),
            pieChart.widthAnchor.constraint(equalToConstant: 250),
            pieChart.heightAnchor.constraint(equalToConstant: 250)
        ])

        pieChart.holeRadiusPercent = 0.75
        pieChart.holeColor = UIColor.clear
        
        var entries = [PieChartDataEntry]()
        
        //finds the savings and taget values so it can be set in the piechart, 02/08/23, Shahiel
        for index in 0...1{
            if index == 0 {
                let entry = PieChartDataEntry(value: currentSaved)
                entries.append(entry)
            }
            if index == 1 {
                let value = (amountSet) - (currentSaved)
                let entry = PieChartDataEntry(value: Double(value))
                entries.append(entry)
            }
        }
        
        //Sets Values, set colours, changes properties of piechart, 02/08/23, Shahiel
        let set = PieChartDataSet(entries: entries, label: "Donut Chart")
        set.colors = [UIColor(red: 0.52, green: 0.03, blue: 0.34, alpha: 1.00), UIColor(red: 0.72, green: 0.71, blue: 0.71, alpha: 1.00)]
        set.sliceSpace = 2
        
        let data = PieChartData(dataSet: set)
        data.setDrawValues(false)
        pieChart.data = data
        pieChart.drawEntryLabelsEnabled = false
        pieChart.legend.enabled = false
        pieChart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeOutSine)
        pieChart.delegate = self
        pieChart.isUserInteractionEnabled = false
        
//        if ((amountSet) != 0){
//            if ((currentSaved) == (amountSet)){
//                targetReached()
//            }
//        }
    }
    
    // MARK: - MonthEnd
    
    //Finds last day of the month, 02/08/23, Shahiel
    func lastDayOfMonth(for date: Date) -> Date? {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month], from: date)
        components.month! += 1
        components.day = 0
        return calendar.date(from: components)
    }
    
    //Takes in data and formats it to a set date format, 02/08/23, Shahiel
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    //Checks if the current day is the last day of the month. Prompts alert to handle savings target if it is month end, 02/08/23, Shahiel
    func isMonthEnd() {
        let currentDate = Date()
        let lastDayOfMonth = lastDayOfMonth(for: currentDate) ?? currentDate

        let currentDayFormatted = formatDate(currentDate)
        let lastDayOfMonthFormatted = formatDate(lastDayOfMonth)
        
        if currentDayFormatted == lastDayOfMonthFormatted {
            isUpdated = true
        }
        
       // print(isUpdated)
        if isUpdated == true{
            if (currentSaved) == (amountSet){
                targetReached()
            }else{
                updateSaved()
            }
        }else{
            if currentDayFormatted == lastDayOfMonthFormatted {
                
                isUpdated = true
                
//                thisMonthCount = 0
                let alertController = UIAlertController(title: "Month Over", message: "Set a new target or continue with the current one", preferredStyle: .alert)

                let continueAction = UIAlertAction(title: "Continue", style: .default) {[weak self] _ in
                    if (self?.currentSaved) == (self?.amountSet) {
                        self?.targetReached()
                    }else{
                        self?.updateSaved()
                    }
                }
                
                let newAction = UIAlertAction(title: "New", style: .default) {[weak self] _ in
                    self?.newTarget()
    //                self?.update(set: 0, current: 0, total: self?.savings.savings[0].totalSavings ?? 0)
//                    self?.lblSavedThisMonth.text = String(0)
//                    self?.thisMonthCount = 0
                    self?.monthlySaved()
                }
                
                alertController.addAction(continueAction)
                alertController.addAction(newAction)
                
                present(alertController, animated: true, completion: nil)
            }else{
                if (currentSaved) == (amountSet) {
                    targetReached()
                    setup()
                }else{
                    updateSaved()
                }
            }

        }
        
    }
    
    //Manages state of page to ensure the graph refreshes properly, 17/08/2023, Shahiel
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        pieChart.removeFromSuperview()
        setup()
        generateChart()
        monthlySaved()
    }

}
