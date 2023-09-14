import Foundation

class AuthViewModel {

    func savePicture(profilePic: String){
        
        var picDataService=uploadPic()
        picDataService.register(imageUrl:profilePic )
    }
    
    private var dataService=loginDataService()
    func login(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        dataService.login(username: username, password: password, completion: completion)
    }
}


