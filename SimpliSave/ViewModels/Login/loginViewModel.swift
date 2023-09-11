//
//  loginViewModel.swift
//  SimpliSave
//
//  Created by Robert on 2023/08/07.
//

import Foundation
/*/
 Created by Robert
 Date: 07 08 2023
 Updated: 07 08 2023
 Class name: loginViewModel
 Desc: The class takes in the API link and decode the data.
        The data is then passed to "userDetails" model
 */
class loginViewModel{
//    var getUserDetails:userDetails?
//        private let sourcesURL = URL(string: "https://pokeapi.co/api/v2/pokemon/ditto")!
//
//        func getData(completion : @escaping () -> ()) {
//
//            URLSession.shared.dataTask(with: sourcesURL) { [weak self] (data, urlResponse, error) in
//                if let data = data {
//
//                    let jsonDecoder = JSONDecoder()
//
//                    let empData = try! jsonDecoder.decode(userDetails.self, from: data)
//                    self?.getUserDetails = empData
//                    completion()
//                }
//            }.resume()
//        }
    
    //working with local file
    var getUserDetails: UserDetails?

    func getData(completion: @escaping () -> ()) {
        if let path = Bundle.main.path(forResource: "userDetails", ofType: "json", inDirectory: "resource") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonDecoder = JSONDecoder()
                let empData = try jsonDecoder.decode(UserDetails.self, from: data)
                self.getUserDetails = empData
                completion()
            } catch {
                print("Error reading JSON file: \(error)")
            }
        } else {
            print("JSON file not found.")
        }
    }

}
