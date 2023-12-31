//
//  uViewModel.swift
//  SimpliSave
//

import Foundation
class uViewModel{
    //working with local file
    var getUserDetails: UserRegister?

    func getData(completion: @escaping () -> ()) {
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent("userDetails.json")
            
            if FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    let data = try Data(contentsOf: fileURL)
                    let jsonDecoder = JSONDecoder()
                    let empData = try jsonDecoder.decode(UserRegister.self, from: data)
                    self.getUserDetails = empData
                    completion()
                } catch {
                    print("Error reading JSON file: \(error)")
                }
            }
        } else {
            print("Documents directory not found.")
        }
    }
    

    
    
   
    //savig data to the jason file
    
        private var userDetails: UserRegister?
        
        func setUserDetails(firstName: String, lastName: String, cellphoneNumber: String, email: String, idNo: String, password: String, createdAt: String, updatedAt: String) {
            userDetails = UserRegister(firstName: firstName, lastName: lastName, cellphoneNumber: cellphoneNumber, email: email, imageUrl: "String", idNo: idNo, password: password, createdAt: createdAt, updatedAt: updatedAt)
        }
    
   
    func saveData(completion: @escaping (Error?) -> ()) {
        guard let userDetails = userDetails else {
            completion(nil) // No data to save
            return
        }
        
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(userDetails)
            
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentsDirectory.appendingPathComponent("userDetails.json")
                print(fileURL)
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    do {
                        try jsonData.write(to: fileURL)
                        completion(nil) // Success
                    } catch {
                        completion(error) // Error writing to file
                    }
                } else {
                    // Create an empty JSON file if it doesn't exist
                    do {
                        let emptyData = Data()
                        try emptyData.write(to: fileURL)
                        print("Empty JSON file created.")
                        
                        // Write the JSON data to the file after creating it
                        do {
                            try jsonData.write(to: fileURL)
                            completion(nil) // Success
                        } catch {
                            completion(error) // Error writing to file
                        }
                    } catch {
                        completion(error) // Error creating empty JSON file
                    }
                }
            }
        } catch {
            completion(error) // Error encoding data
        }
        
        
    }
}
