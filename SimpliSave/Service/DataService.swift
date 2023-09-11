//
//  DataService.swift
//  SimpliSave
//
//  Created by DA MAC M1 126 on 2023/08/07.
//

import Foundation
import UIKit

//helps to handle certain errors related to network errors: 28/08/2023 | Rolva
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case serverError(Int)
}


class TransactionService {
    private var transactions: [TransactionElement] = []
    
    //Sercive that fetches transactions data 07/08/2023 Shahiel
    //Updated and intergrated with the API 14/08/2023 Shahiel
    
//    func fetchDataFromJSON(completion: @escaping ([TransactionElement]?) -> Void) {
//        if let fileURL = Bundle.main.path(forResource: "dataT", ofType: "json") {
//            //print(fileURL)
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: fileURL))
//                //print(data)
//                let decodedData = try JSONDecoder().decode([TransactionElement].self, from: data)
//                //print(decodedData)
//                completion(decodedData)
//            } catch {
//
//                print("Error parsing JSON: \(error)")
//                completion(nil)
//            }
//        } else {
//            print("Unable to find the JSON file.")
//            completion(nil)
//        }
//    }
    
    func fetchDataFromJSON(completion: @escaping ([TransactionElement]?) -> Void) {
        if let fileURL = URL(string: "https://simplisave.software/api/v1/transactions/transactions") {
           let get = URLSession.shared.dataTask(with: fileURL) { (data, response, error) in
                //print(data)
                if let error = error {
                    print(error.localizedDescription)
                    //print("error.localizedDescription")
                    completion(nil)
                } else if let data = data {
                    //print(data)

                    do {
                        let decodedData = try JSONDecoder().decode([TransactionElement].self, from: data)
                        //print(decodedData)
                        completion(decodedData)
                    } catch {
                        print("Error parsing JSON: \(error)")
                        completion(nil)
                    }
                }
            }
            get.resume()
        } else {
            completion(nil)
        }
    }
}

class BudgetService {
    
    //Sercive that fetches the Budget data from 07/08/2023 Shahiel
//    func fetchBudgetData(completion: @escaping ([Budget]?) -> Void) {
//        if let fileURL = Bundle.main.path(forResource: "dataB", ofType: "json") {
//            //print(fileURL)
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: fileURL))
//                //print(data)
//                let decodedData = try JSONDecoder().decode([Budget].self, from: data)
//                //print(decodedData)
//                completion(decodedData)
//            } catch {
//
//                print("Error parsing JSON: \(error)")
//                completion(nil)
//            }
//        } else {
//            print("Unable to find the JSON file.")
//            completion(nil)
//        }
//    }
    
    func fetchBudgetData(completion: @escaping (Budget?) -> Void) {
        if let fileURL = URL(string: "https://simplisave.software/api/v1/budget/details") {
           let get = URLSession.shared.dataTask(with: fileURL) { (data, response, error) in
                //print(data)
                if let error = error {
                    print(error.localizedDescription)
                    //print("error.localizedDescription")
                    completion(nil)
                } else if let data = data {
                    //print(data)

                    do {
                        let decodedData = try JSONDecoder().decode(Budget.self, from: data)
                       // print(decodedData)
                        completion(decodedData)
                    } catch {
                        print("Error parsing JSON: \(error)")
                        completion(nil)
                    }
                }
            }
            get.resume()
        } else {
            completion(nil)
        }
    }
    
    func updateJson(set: Int, progress: Int, type: String, id: Int)  {
        
        var request = URLRequest(url:URL(string: "https://simplisave.software/api/v1/budget/progress/\(id)")!)
        request.httpMethod  = "PATCH"
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let parameters: [String: Any] = [
            "amountSet": set,
            "progressAmount": progress,
            "transactionsType": type
        ]
        // covert diectionary to json
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        
        request.httpBody =  jsonData
        
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request){(data,res,err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            guard let _ = data else {return}
            if err == nil,let response = res as? HTTPURLResponse {
                if response.statusCode == 201
                {
                    DispatchQueue.main.async {
//                        self.isCreated = true
//                        self.addAlert(message: "Successfully Added", title: "Success")
                    }
                    
                }
            }
         
        }.resume()
        
    }
    
    //MARK: - Sercive that performs a delete on a specific budegts 07/08/2023 Shahiel
//    func removeTransactionFromJSON(ToRemove: Budget) {
//        if let fileURL = Bundle.main.url(forResource: "dataB", withExtension: "json") {
//            do {
//                var data = try Data(contentsOf: fileURL)
//                var decodedData = try JSONDecoder().decode([Budget].self, from: data)
//
//                decodedData.removeAll { $0 == ToRemove }
//
//                let updatedData = try JSONEncoder().encode(decodedData)
//
//                try updatedData.write(to: fileURL)
//                print("Data updated and written to \(fileURL)")
//            } catch {
//                print("Error parsing JSON: \(error)")
//            }
//        } else {
//            print("Unable to find the JSON file.")
//        }
//    }
    
    //MARK: - Sercive that performs a add for a budegts  08/08/2023 Shahiel
//    func addToJson(ToAdd: Budget){
//        if let fileURL = Bundle.main.url(forResource: "dataB", withExtension: "json"){
//            do{
//                let data = try Data(contentsOf: fileURL)
//
//                var decodedData = try JSONDecoder().decode([Budget].self, from: data)
//
//                var new = ToAdd
//
//                if ToAdd.progressAmount == ToAdd.amountSet {
//                    new.status = "Complete"
//                }
//
//                if ToAdd.progressAmount < ToAdd.amountSet {
//                    new.status = "In Progress"
//                }
//
//                if ToAdd.progressAmount > ToAdd.amountSet {
//                    new.status = "Over Budget"
//                }
//
//                if ToAdd.progressAmount == 0 {
//                    new.status = "Not Started"
//                }
//
//                decodedData.append(new)
//
//                let updatedData = try JSONEncoder().encode(decodedData)
//
//                try updatedData.write(to: fileURL)
//                print("Data updated and written to \(fileURL)")
//            } catch {
//                print("Error parsing JSON: \(error)")
//            }
//        }
//    }
    
    func delete(id: Int)  {
        
        var request = URLRequest(url:URL(string: "https://simplisave.software/api/v1/budget/\(id)")!)
        
        request.httpMethod  = "DELETE"
        let session = URLSession(configuration: .default)
        session.dataTask(with: request){(data,res,err)in
            
            if err != nil {
                print(err!.localizedDescription)
                
            }
            if err == nil,let data = data, let response = res as? HTTPURLResponse {
                print(response.statusCode)
                print(data)
                
                DispatchQueue.main.async {
                }
                
            }
            
        }.resume()
    }

    
    func addToJson(amount: Int, type: String) {
        // URL of the API endpoint
        var request = URLRequest(url:URL(string: "https://simplisave.software/api/v1/budget/creation")!)
        request.httpMethod  = "POST"

        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let parameters: [String: Any] = [
            "amountSet": amount,
            "transactionsType": type,
        ]
        // covert diectionary to json
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)

        request.httpBody =  jsonData


        let session = URLSession(configuration: .default)
        session.dataTask(with: request){(data,res,err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            guard let _ = data else {return}
            if err == nil,let response = res as? HTTPURLResponse {
                if response.statusCode == 201
                {
                }
            }

        }.resume()
    }
    
    
//    let url = URL(string: "https://simplisave.software/api/v1/budget/creation")!
//
//    do {
//        // Convert data to JSON format
//        let requestData = try JSONSerialization.data(withJSONObject: Budget.self, options: [])
//
//        // Create a URLRequest
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = requestData
//
//
//        // Create a URLSession task
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("Error: \(error)")
//                return
//            }
//
//            if let data = data {
//                // Process the response data
//                if let responseString = String(data: data, encoding: .utf8) {
//                    print("Response: \(responseString)")
//                }
//            }
//        }
//
//        // Start the task
//        task.resume()
//
//    } catch {
//        print("JSON serialization error: \(error)")
//    }
    
    //Sercive that performs a update on a specific budegt  09/08/2023 Shahiel
//    func updateJson(ToUpdate: Budget, progress: Int, index: IndexPath) {
//        if let fileURL = Bundle.main.url(forResource: "dataB", withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: fileURL)
//
//                var decodedData = try JSONDecoder().decode([Budget].self, from: data)
//
////                let new = SimpliSave.Budget(
////                    transactionType: ToUpdate.transactionType,
////                    amountBudgeted: ToUpdate.amountBudgeted,
////                    progress: ToUpdate.progress,
////                    status: ToUpdate.status
////                )
//
//                var toChange = decodedData[index.row]
//                //print(toChange)
//                //print(decodedData)
//                if ToUpdate.progressAmount == ToUpdate.amountSet {
//                    toChange.status = "Complete"
//                }
//
//                if ToUpdate.progressAmount < ToUpdate.amountSet {
//                    toChange.status = "In Progress"
//                }
//
//                if ToUpdate.progressAmount > ToUpdate.amountSet {
//                    toChange.status = "Over Budget"
//                }
//
//                if ToUpdate.progressAmount == 0 {
//                    toChange.status = "Not Started"
//                }
//
//                toChange.progressAmount = ToUpdate.progressAmount
//
//               //print(toChange)
//                decodedData[index.row] = toChange
//                //print(decodedData)
//                let updatedData = try JSONEncoder().encode(decodedData)
//
//                try updatedData.write(to: fileURL)
//                print("Data updated and written to \(fileURL)")
//
//            } catch {
//                print("Error parsing JSON: \(error)")
//            }
//        }
//    }
}

class DashService {
    
    //Sercive that fetches budget data for the dashboard and adds it to the dashboard json 10/08/2023 Shahiel
//    func fetchAddData() {
//    var addData:[DashBudget] = []
//        if let fileURL = Bundle.main.url(forResource: "dataB", withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: fileURL)
//
//                var decodedData = try JSONDecoder().decode([Budget].self, from: data)
//
//                for index in 0..<decodedData.count {
//                    let element = decodedData[index]
//                    let perctentage = Double(element.progressAmount) * 100.0 / 5000.00
//
//                    var new = SimpliSave.DashBudget(
//                        transactionType: element.transactionsType,
//                        amountBudgeted: element.amountSet,
//                        progress: Double(element.progressAmount),
//                        status: element.status,
//                        percentage: perctentage
//                    )
//                    addData.append(new)
//                }
//                let updatedData = try JSONEncoder().encode(addData)
//
//                if let file2URL = Bundle.main.url(forResource: "dataD", withExtension: "json"){
//                    do {
//                        try updatedData.write(to: file2URL)
//                        //print("Data updated and written to \(file2URL)")
//                    } catch {
//                        print("Error parsing JSON: \(error)")
//                    }
//                }
//            } catch {
//                print("Error parsing JSON: \(error)")
//            }
//        }
//    }
    
    func fetchdashboardData(completion: @escaping (DashBudget?) -> Void) {
        if let fileURL = URL(string: "https://simplisave.software/api/v1/budget/details") {
           let get = URLSession.shared.dataTask(with: fileURL) { (data, response, error) in
                //print(data)
                if let error = error {
                    print(error.localizedDescription)
                    //print("error.localizedDescription")
                    completion(nil)
                } else if let data = data {
                    //print(data)

                    do {
                        let decodedData = try JSONDecoder().decode(DashBudget.self, from: data)
                       // print(decodedData)
                        completion(decodedData)
                    } catch {
                        print("Error parsing JSON: \(error)")
                        completion(nil)
                    }
                }
            }
            get.resume()
        } else {
            completion(nil)
        }
    }
    
    
    //Sercive that fetches data from the dashboard json that was previously added 10/08/2023 Shahiel
//    func fetchdashboardData(completion: @escaping ([DashBudget]?) -> Void) {
//       // fetchAddData()
//        if let fileURL = Bundle.main.path(forResource: "dataD", ofType: "json") {
//            //print(fileURL)
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: fileURL))
//                //print(data)
//                let decodedData = try JSONDecoder().decode([DashBudget].self, from: data)
//                //print(decodedData)
//                completion(decodedData)
//            } catch {
//                
//                print("Error parsing JSON: \(error)")
//                completion(nil)
//            }
//        } else {
//            print("Unable to find the JSON file.")
//            completion(nil)
//        }
//    }
}


class SavingsService {
    
    //Sercive that fetches data from the savings json 14/08/2023 Shahiel
    //    func fetchSavingsData(completion: @escaping (Savings?) -> Void){
    //        if let fileURL = Bundle.main.path(forResource: "dataS", ofType: "json") {
    //            do {
    //
    //                let decoder = JSONDecoder()
    //                decoder.dateDecodingStrategy = .iso8601
    //
    //                let data = try Data(contentsOf: URL(fileURLWithPath: fileURL))
    //                print(data)
    //                let decodedData = try decoder.decode(Savings.self, from: data)
    //
    //                completion(decodedData)
    //            } catch {
    //                print("Error parsing JSON: \(error)")
    //                completion(nil)
    //            }
    //        } else {
    //            print("Unable to find the JSON file.")
    //            completion(nil)
    //        }
    //
    //    }
    
    //    func fetchSavingsData(completion: @escaping(Savings) -> Void){
    //
    //        guard let url = URL(string: "https://simplisave.software/api/v1/goalSavings/goals") else {return}
    //
    //        let session = URLSession.shared
    //
    //        let dataTask = session.dataTask(with: url) { data, response, error in
    //            if data != nil, error == nil{
    //                do {
    //                    let parsingData = try JSONDecoder().decode(Savings.self, from:data!)
    //                    //print(parsingData)
    //                    completion(parsingData)
    //                } catch {
    //                    print("parsing error")
    //                }
    //            }
    //        }
    //        dataTask.resume()
    //    }
    
    func fetchSavingsData(completion: @escaping (Savings?) -> Void) {
        if let fileURL = URL(string: "https://simplisave.software/api/v1/goalSavings/goals") {
            let get = URLSession.shared.dataTask(with: fileURL) { (data, response, error) in
                //print(data)
                if let error = error {
                    print(error.localizedDescription)
                    //print("error.localizedDescription")
                    completion(nil)
                } else if let data = data {
                    print(data)
                    
                    do {
                        let decodedData = try JSONDecoder().decode(Savings.self, from: data)
                        //print(decodedData)
                        completion(decodedData)
                    } catch {
                        print("Error parsing JSON: \(error)")
                        completion(nil)
                    }
                }
            }
            get.resume()
        } else {
            completion(nil)
        }
    }
    
    //Sercive that update data on a specific savings item 14/08/2023 Shahiel
    //    func updateJson(ToUpdate: Savings) {
    //        if let fileURL = Bundle.main.path(forResource: "dataS", ofType: "json") {
    //            do {
    //                //print("hello")
    //                let decoder = JSONDecoder()
    //                decoder.dateDecodingStrategy = .iso8601
    //
    //                let encoder = JSONEncoder()
    //                encoder.dateEncodingStrategy = .iso8601
    //
    //                let data = try Data(contentsOf: URL(fileURLWithPath: fileURL))
    //
    //                var decodedData = try decoder.decode([Savings].self, from: data)
    //
    //                decodedData[0] = ToUpdate
    //
    //
    //                let updatedData = try encoder.encode(decodedData)
    //                //print(updatedData)
    //                try updatedData.write(to: URL(fileURLWithPath: fileURL))
    //                print("Data updated and written to \(fileURL)")
    //
    //            } catch {
    //                print("Error parsing JSON: \(error)")
    //            }
    //        }
    //    }
    
    func updateJson(ToUpdate: Int, id: Int)  {
        
        var request = URLRequest(url:URL(string: "https://simplisave.software/api/v1/simplisaving/transfer/\(id)")!)
        request.httpMethod  = "POST"
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let parameters: [String: Any] = [
            "amount": ToUpdate,
        ]
        // covert diectionary to json
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        
        request.httpBody =  jsonData
        
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request){(data,res,err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            guard let _ = data else {return}
            if err == nil,let response = res as? HTTPURLResponse {
                if response.statusCode == 201
                {
                    DispatchQueue.main.async {
                        //                        self.isCreated = true
                        //                        self.addAlert(message: "Successfully Added", title: "Success")
                    }
                    
                }
            }
            
        }.resume()
        
    }
    
    func addNewGoal(ToAdd:Int)  {
        //passing the data gotten to the parameters
        let parameters: [String: Any] = [
            "amountSet": ToAdd,
            "description": "Laptop",
        ]
        
        // getting the url from the info file Robert 29/08/2023
        let apiUrl = Bundle.main.object(forInfoDictionaryKey: "addGoal") as! String
        guard let url = URL(string: apiUrl) else {
            print("Invalid URL")
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Convert parameters to JSON data
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error creating JSON data: \(error)")
            return
        }
        
        // Create a URLSession task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Response: \(json)")
                        // Handle the response JSON here
                    }
                } catch {
                    print("Error parsing JSON response: \(error)")
                }
            }
            
        }
        
        // Start the URLSession task
        task.resume()
    }
}
    //Sercive that add data to the savings json 14/08/2023 Shahiel
//    func addToJson(ToAdd: Savings){
//        if let fileURL = Bundle.main.url(forResource: "dataB", withExtension: "json"){
//            do{
//                let encoder = JSONEncoder()
//                encoder.dateEncodingStrategy = .iso8601
//
//                let data = try Data(contentsOf: fileURL)
//
//                var decodedData = try JSONDecoder().decode([Savings].self, from: data)
//
//                decodedData.append(ToAdd)
//
//                let updatedData = try encoder.encode(decodedData)
//
//                try updatedData.write(to: fileURL)
//                print("Data updated and written to \(fileURL)")
//            } catch {
//                print("Error parsing JSON: \(error)")
//            }
//        }
//    }
    
        


/*
 created 21 08 2023
 updated: 21 08 2023
 Dev: Robert
 Function name:login
 Description: takes in username: String, password: String (NB) username is the Email
 
 The function pass data to the API to authenticate the user and return a token which is saved in user default with key "user_token"
 */
class loginDataService{
       func login(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        
           // getting the url from the info file Robert 29/08/2023
           let apiUrl = Bundle.main.object(forInfoDictionaryKey: "loginStudent") as! String
               let loginURL = URL(string: apiUrl)!

           
        var loginRequest = URLRequest(url: loginURL)
        loginRequest.httpMethod = "POST"
        loginRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        //parameters for login Robert 14/08/2023
        let loginData: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: loginData, options: [])
            loginRequest.httpBody = jsonData
            
            // Perform the login request
            URLSession.shared.dataTask(with: loginRequest) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
             
                if let data = data {
                        do {
                            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                            if let token = jsonResponse?["token"] as? String{
                            
                                //saving login token robert
                                UserDefaults.standard.set(token, forKey: "user_token")
                                UserDefaults.standard.synchronize()
                                
                                completion(.success("Login successful"))
                                print(token)
                            } else {
                                //if the user authentication failed, no token is returned Robert...
                                completion(.failure(NSError(domain: "Token not found in response", code: -1, userInfo: nil)))
                            }
                        }catch {
                        completion(.failure(error))
                    }
                }
            }.resume()
            
        } catch {
            completion(.failure(error))
        }
    }
   
}

/*
 created 21 08 2023
 updated: 05 09 2023
 Dev: Robert
 Function name:register
 Description: takes in firstName: String, lastName: String, cellphoneNumber: String, email: String, idNo: String, password: String, createdAt: String, updatedAt: String
 
 The function pass data to the API
 */
 
class registerDataService: UIViewController {

    var errorMsg = ""

    // Add a completion handler to the register method
    func register(firstName: String, lastName: String, cellphoneNumber: String, email: String, idNo: String, password: String, createdAt: String, updatedAt: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        // getting the url from the info file Robert 29/08/2023\
        
        let parameters: [String: Any] = [
                  "email": email,
                  "password": password,
                  "firstName": firstName,
                  "lastName": lastName,
                  "cellphoneNumber": cellphoneNumber,
                  "createdAt": createdAt,
                  "updatedAt": updatedAt,
                  "idNo": idNo
              ]
        
                let apiUrl = Bundle.main.object(forInfoDictionaryKey: "studentRegister") as! String
                guard let url = URL(string: apiUrl) else {
                    print("Invalid URL")
                    return
                }
                
                // Create the request
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Convert parameters to JSON data
             do {
                 request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
             } catch {
                 print("Error creating JSON data: \(error)")
                 return
             }
        
        // Create a URLSession task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Response: \(error)")
                completion(.failure(error))
                return
            }

            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        completion(.success(json))
                    }
                } catch {
                    print("Error parsing JSON response: \(error)")
                    completion(.failure(error))
                }
            }
        }

        // Start the URLSession task
        task.resume()
    }
}


/*
 reading data from the API and displayig to the user Robert 25/08/2023
 */
class userGetDetails {
    var userProfile: UserRegister?
    func fetchData(completion: @escaping (Error?) -> Void) {
        

        // getting the url from the info file Robert 29/08/2023
        let apiUrl = Bundle.main.object(forInfoDictionaryKey: "userDetails") as! String
        let url = URL(string: apiUrl)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                self.userProfile = try decoder.decode(UserRegister.self, from: data)
                completion(nil)
            } catch {
                completion(error)
            }
        }.resume()
    }
    
    func update(user: UserRegister) {

        var request = URLRequest(url: URL(string:"https://simplisave.software/api/v1/student/refinement")!)

        // Setting the HTTP method to "PATCH" to indicate that we want to make a partial update to the resource.
        request.httpMethod = "PATCH"
        
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
                         
        
        let parameters: [String: Any] = [
            "firstName" : user.firstName,
            "lastName": user.lastName,
            "cellPhone": user.cellphoneNumber,
            "emailAddress": user.email
        ]

        // Create an instance of JSONEncoder, which is used to encode Swift objects or structs into JSON format.
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user data: \(error.localizedDescription)")
            return
        }

        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { (data, res, err) in
            if err != nil {
                print(err!.localizedDescription)
            }
            if err == nil, let response = res as? HTTPURLResponse {
                print(response.statusCode)
                print(data ?? "No data received")

                DispatchQueue.main.async {
                    // Handle the response or perform any necessary UI updates after updating the employee
                }
            }
        }.resume()
    }
}

//retrieves data from the API: 28/08/2023 | Rolva
class DataService {
    func fetchStudents(completion: @escaping (Result<Transaction, Error>) -> Void) {
        let url = URL(string: "https://simplisave.software/api/v1/admin/students")!
        let isLogined=UserDefaults.standard.string(forKey:"user_token")
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(isLogined)", forHTTPHeaderField: "Authorization")  // Set the authorization header
        
        URLSession.shared.dataTask(with: request) { data, response, error in
//            print(data)
//            print(response)
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    print(data)
                    let decodedData = try JSONDecoder().decode(Transaction.self, from: data)
                    print(decodedData)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    

}


/*
 uploading the image to the API using multipart/form-data
 Author: Robert
 Date: 28/08/2023
 */
class uploadPic{
    func register(imageUrl: String){
        //passing the data gotten to the parameters
        let parameters: [String: Any] = [
            "imageUrl": imageUrl
        ]
        
        // getting the url from the info file Robert 29/08/2023
        let apiUrl = Bundle.main.object(forInfoDictionaryKey: "uploadImage") as! String
        guard let url = URL(string: apiUrl) else {

            print("Invalid URL")
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        
        // Convert parameters to JSON data
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error creating JSON data: \(error)")
            return
        }
        
        // Create a URLSession task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Response: \(json)")
                        // Handle the response JSON here
                    }
                } catch {
                    print("Error parsing JSON response: \(error)")
                }
            }
        }
        
        // Start the URLSession task
        task.resume()
        
    }
}

// MARK: - Service that performs forgot password - Masana Chauke - 28/08/2023

class ForgotPasswordDataService {
    
        func sendForgotPasswordRequest(forgotPassword: ForgotPassword, completion: @escaping (Result<Void, Error>) -> Void) {
            let forgotPasswordURL = URL(string: "https://simplisave.software/api/v1/auth/forgot-password")!
            
            var request = URLRequest(url: forgotPasswordURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let jsonData = try JSONEncoder().encode(forgotPassword)
                request.httpBody = jsonData
                
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(.failure(NetworkError.invalidResponse))
                        return
                    }
                    
                    if (200...299).contains(httpResponse.statusCode) {
                        completion(.success(()))
                    } else {
                        // Handle specific error cases based on the server response here
                        completion(.failure(NetworkError.serverError(httpResponse.statusCode)))
                    }
                }.resume()
                
            } catch {
                completion(.failure(error))
            }
        }
    }
//MARK: - service that performs otp verification - Masana - 30/08/2023

class OTPDataService {
    func sendOTPRequest(email: String, completion: @escaping (Result<OTPModel, Error>) -> Void) {
        let otpURLString = "https://simplisave.software/api/v1/auth/reset-password"
        guard let otpURL = URL(string: otpURLString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: otpURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = ["email": email]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                    return
                }
                
                do {
                    let otpModel = try JSONDecoder().decode(OTPModel.self, from: data)
                    completion(.success(otpModel))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
            
        } catch {
            completion(.failure(error))
        }
    }
}


//MARK: - service that performs reset password - Masana - 29/08/2023
class ResetPasswordDataService {
    
    func sendResetPasswordRequest(resetPasswordModel: ResetPasswordModel, completion: @escaping (Result<Void, Error>) -> Void) {

        let resetPasswordURL = URL(string: "https://simplisave.software/api/v1/auth/reset-password")!
        
        var request = URLRequest(url: resetPasswordURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(resetPasswordModel)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                
                if (200...299).contains(httpResponse.statusCode) {
                    completion(.success(()))
                } else {
                    // Handle specific error cases based on the server response here
                    completion(.failure(NetworkError.serverError(httpResponse.statusCode)))
                }
            }.resume()
            
        } catch {
            completion(.failure(error))
        }
    }
}

class budgetCreateDataService{
    func create(amountSet:String, transactionsType:String){
        //passing the data gotten to the parameters
        let parameters: [String: Any] = [
            "amountSet": amountSet,
            "transactionsType": transactionsType,
            
        ]
        
        // getting the url from the info file Robert 29/08/2023
        let apiUrl = Bundle.main.object(forInfoDictionaryKey: "budget") as! String
        guard let url = URL(string: apiUrl) else {
            print("Invalid URL")
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Convert parameters to JSON data
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error creating JSON data: \(error)")
            return
        }
        
        // Create a URLSession task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Response: \(json)")
                        // Handle the response JSON here
                    }
                } catch {
                    print("Error parsing JSON response: \(error)")
                }
            }
        }
        
        // Start the URLSession task
        task.resume()
        
    }
}


class getBudget{
    var bgt:budgetDetails?
    func fetchData(completion: @escaping (Error?) -> Void) {
        // getting the url from the info file Robert 31/08/2023
        let apiUrl = Bundle.main.object(forInfoDictionaryKey: "budget") as! String
        let url = URL(string: apiUrl)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                self.bgt = try decoder.decode(budgetDetails.self, from: data)
                completion(nil)
            } catch {
                completion(error)
            }
        }.resume()
    }
    
    
}

