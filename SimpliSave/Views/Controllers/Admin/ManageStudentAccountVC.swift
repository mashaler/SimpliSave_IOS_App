import UIKit

//class for Manage student  Account: 29/08/2023 | Rolva
class ManageStudentAccountVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: ManageStudentViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        tableView.delegate = self
        tableView.dataSource = self

        let dataService = DataService()
        viewModel = ManageStudentViewModel(dataService: dataService)

        viewModel.fetchData {
            self.tableView.reloadData()
        }

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let accountName = viewModel.accountName(at: indexPath.row)
        cell.textLabel?.text = accountName

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfAccounts()
    }
}
