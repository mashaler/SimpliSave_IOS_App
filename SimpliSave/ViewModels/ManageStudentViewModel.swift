import Foundation

// class for ManageStudent view Model: 29/08/2023 | Rolva
class ManageStudentViewModel {
    private var account: [Transaction] = []
    private let dataService: DataService
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func fetchData(completion: @escaping () -> Void) {
        dataService.fetchStudents { [weak self] result in
            switch result {
            case .success(let students):
                self?.account = [students]
                completion()
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }

    func numberOfAccounts() -> Int {
        return account.count
    }
    
    func accountName(at index: Int) -> String {
        let student = account[index]
        
        return student.data[index].firstName
    }
}

struct ManageStudentsViewModel {
    private var accounts: Account
    
    init(accounts: Account) {
        self.accounts = accounts
    }
}

extension ManageStudentsViewModel{
    
}

