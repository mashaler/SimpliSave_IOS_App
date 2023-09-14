//
//  DashboardVC.swift
//  SimpliSave
//
//  Created by DA MAC  M1 154 on 2023/07/18.
//

import UIKit

import Charts

class DashboardVC: UIViewController, ChartViewDelegate {

    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionSubView: UIView!

    var pieChart = PieChartView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    var dashboardData: DashboardsViewModel!
    var dashboard: [Display] = []
    var total = 0.0
    var dataEntries: [DashBudget] = []
//    var colorsSet: [UIColor] = []
    var colors: [UIColor] = [
        UIColor(red: 0.61, green: 0.19, blue: 0.57, alpha: 1.00),
        UIColor(red: 0.39, green: 0.24, blue: 0.73, alpha: 1.00),
        UIColor(red: 0.97, green: 0.72, blue: 0.64, alpha: 1.00),
        UIColor(red: 0.55, green: 0.59, blue: 0.78, alpha: 1.00),
        UIColor(red: 0.78, green: 0.38, blue: 0.61, alpha: 1.00),
        UIColor(red: 0.38, green: 0.21, blue: 0.37, alpha: 1.00),
        UIColor(red: 0.29, green: 0.19, blue: 0.45, alpha: 1.00)
       ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "DashBoard"
        
        chartView.layer.cornerRadius = 15.0
        chartView.clipsToBounds = false
        chartView.layer.shadowColor = UIColor.black.cgColor
        chartView.layer.shadowOffset = CGSize(width: 0, height: 2)
        chartView.layer.shadowOpacity = 0.1
        chartView.layer.shadowRadius = 4
        
        collectionSubView.layer.cornerRadius = 15.0
        collectionSubView.clipsToBounds = false
        collectionView.layer.cornerRadius = 15
        collectionSubView.layer.shadowColor = UIColor.black.cgColor
        collectionSubView.layer.shadowOffset = CGSize(width: 0, height: 2)
        collectionSubView.layer.shadowOpacity = 0.1
        collectionSubView.layer.shadowRadius = 4

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
    
    //Calls the fetchdashboardData function in the services file
    func setup(){
        DashService().fetchdashboardData { data in
            self.dashboardData = DashboardsViewModel(dashBudgets: data?.budgets ?? [])
            
            DispatchQueue.main.async {
                self.getTotal()
                self.getPercentage()
                self.collectionView.reloadData()
                self.generateChart()
            }
        }
    }
    
    //Gets total of all expenses and displays it in the label
    func getTotal() {
        total = 0
        for index in 0..<dashboardData.dashBudgets.count {
            let value = dashboardData.dashBudgets[index].progressAmount
            total = total + Double(value)
        }
        lblAmount.text = "R\(total)"
        lblMessage.text = "SPENT THIS MONTH"
    }
    
    func getPercentage(){
        self.getTotal()
        
        for item in self.dashboardData.dashBudgets{
            
            if item.progressAmount == 0 {
                let percent = 0.0
                
                let newItem = SimpliSave.Display(
                    budgetID: item.budgetID,
                    amountSet: item.amountSet,
                    progressAmount: item.progressAmount,
                    percentage: Double(percent),
                    budgetCreated: item.budgetCreated,
                    budgetStatus: item.budgetStatus,
                    transactionsType: item.transactionsType)
                
                dashboard.append(newItem)
                //collectionView.reloadData()
            }else{
                let percent = (item.progressAmount * 100) / (Int(total))
                
                let newItem = SimpliSave.Display(
                    budgetID: item.budgetID,
                    amountSet: item.amountSet,
                    progressAmount: item.progressAmount,
                    percentage: Double(percent),
                    budgetCreated: item.budgetCreated,
                    budgetStatus: item.budgetStatus,
                    transactionsType: item.transactionsType)
                
                dashboard.append(newItem)
               // collectionView.reloadData()
            }
            //collectionView.reloadData()
        }
    }
    
    // MARK: - generateChart
    
    //Generates piechart
    func generateChart(){
        chartView.addSubview(pieChart)
        
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pieChart.centerXAnchor.constraint(equalTo: chartView.centerXAnchor),
            pieChart.centerYAnchor.constraint(equalTo: chartView.centerYAnchor),
            pieChart.widthAnchor.constraint(equalToConstant: 250),
            pieChart.heightAnchor.constraint(equalToConstant: 250)
        ])

        pieChart.holeRadiusPercent = 0.75
        pieChart.holeColor = UIColor.clear

        var entries = [PieChartDataEntry]()
        if dashboardData.dashBudgets == []{
            let entry = PieChartDataEntry(value: 1, label: "default")
            entries.append(entry)
        }else{
            for dataEntry in dashboardData.dashBudgets {
                let value = Double(dataEntry.progressAmount)
                let label = dataEntry.transactionsType
                let entry = PieChartDataEntry(value: value, label: label)
                entries.append(entry)
            }
        }
       

        let set = PieChartDataSet(entries: entries, label: "Donut Chart")
        set.colors = colors
        set.sliceSpace = 2

        let data = PieChartData(dataSet: set)
        data.setDrawValues(false)
        pieChart.data = data
        pieChart.drawEntryLabelsEnabled = false
        pieChart.legend.enabled = false
        pieChart.usePercentValuesEnabled = true
        pieChart.animate(xAxisDuration: 2.0, yAxisDuration: 1.0, easingOption: .easeOutSine)
        pieChart.delegate = self
    }

    //Changes labels to display expense for selected piece of pie chart
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let pieEntry = entry as? PieChartDataEntry else { return }
        
        if dashboardData.dashBudgets == []{
            lblAmount.text = "R0"
            lblMessage.text = "No Budget"
        }else{
            let price = pieEntry.value
            let label = pieEntry.label ?? ""

            lblAmount.text = "R\(price)"
            lblMessage.text = "\(label)"
        }
    }
    
    //calls abd executes getTotal when piece of piechart is not selected
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        getTotal()
    }

    //Randomly generates colours and adds it to an array
//    func generateColours() -> [UIColor] {
//        setup()
//        for _ in 0..<2 {
//            let randomRed = CGFloat.random(in: 0...1)
//            let randomGreen = CGFloat.random(in: 0...1)
//            let randomBlue = CGFloat.random(in: 0...1)
//
//            let color = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
//            colorsSet.append(color)
//        }
//        return colors
//    }
    
}

// MARK: - extension collectionView

extension DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    //Sets number of sections to 1
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Gets length of data list for number of rows
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let numberOfRows = dashboardData?.numberOfRowsInSection(section) {
                return numberOfRows
            } else {
                return 0
            }
    }
    
    //Loads data from data list into collectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DashBoardCollectionViewCell else {return UICollectionViewCell()}
       
        cell.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = false
        var percent=0
        //getPercentage()
        let dash = self.dashboardData.dashboardAtIndex(indexPath.row)
        if(total==0){
             percent = (dash.progress * 100) / 1 + (Int(total))
        }
        else{
             percent = (dash.progress * 100) / (Int(total))
        }
        
        cell.category.text = dash.transactionType
        cell.price.text = "R" + String(dash.progress)
        cell.percentage.text = String(percent) + "%"
        cell.btnColour.tintColor = colors[indexPath.row]

        return cell
    }
    
    //Sets height and width of each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 360, height: 90)
    }
    
    //Manages state of page to ensure the graph refreshes properly and after and upate on the budget screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        pieChart.removeFromSuperview()
        setup()
        collectionView.reloadData()
    }
    
}


