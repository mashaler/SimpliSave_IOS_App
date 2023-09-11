import Foundation

/*
 created 10 08 2023
 updated: 15 08 2023
 Dev: Robert
 Class name:AuthViewModel
 Description: Class contains two functions register and login
 */
class AuthViewModel {
    /*
     created 10 08 2023
     updated: 15 08 2023
     Dev: Robert
     Function name:register
     Description: takes in firstName: String, lastName: String, cellphoneNumber: String, email: String, idNo: String, password: String, createdAt: String, updatedAt: String
     
     The function pass data to the API
     */
//    func register(firstName: String, lastName: String, cellphoneNumber: String, email: String, idNo: String, password: String, createdAt: String, updatedAt: String){
//        
//        var regDataService=RegisterDataService()
//        regDataService.register(firstName: firstName, lastName: lastName, cellphoneNumber: cellphoneNumber, email: email, idNo: idNo, password: password, createdAt: createdAt, updatedAt: updatedAt)
//    }

/*
 save pic to API robert 28/08/2023
 */
    func savePicture(profilePic: String){
        
        var picDataService=uploadPic()
        picDataService.register(imageUrl:profilePic )
    }
    
    /*
     created 10 08 2023
     updated: 15 08 2023
     Dev: Robert
     Function name:login
     Description: takes in username: String, password: String (NB) username is the Email
     
     The function pass data to the API to authenticate the user and return a token which is saved in user default with key "user_token"
     */
    private var dataService=loginDataService()
    func login(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        dataService.login(username: username, password: password, completion: completion)
    }
}


