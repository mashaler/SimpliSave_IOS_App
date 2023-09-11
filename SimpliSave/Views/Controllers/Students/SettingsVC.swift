//
//  SettingsVC.swift
//  SimpliSave
//
//  Created by DA MAC  M1 154 on 2023/07/18.
//

import UIKit
import Alamofire
class SettingsVC: UIViewController {

// MARK: - Outlets
    private var viewModel = userGetDetails()
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var myDetails: UIButton!
    @IBOutlet weak var help: UIButton!
    @IBOutlet weak var privacy: UIButton!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userName: UILabel!
    
// MARK: - View Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Robert 04/09/2023 checking if the token expired, and redirecting to login
        let token = TokenManager()
        
        if token.isExpire {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let dashboard = storyboard.instantiateViewController(withIdentifier: "Login") as? LoginVC {
                self.navigationController?.pushViewController(dashboard, animated: true)
            }        } else {
            print("Still Valid")
        }
        
        /*
         Getting user details from the API ROBERT 25 08 2023
         */
        
        var login=LoginVC()
        
        viewModel.fetchData { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
    
            
            DispatchQueue.main.async {

                self.updateUI()
            }
        }
        
      
    //printUserDetails()
    // customise buttons - Masana - 27/07/2023
        
        myDetails.layer.cornerRadius = 15.0
        myDetails.clipsToBounds = false
        myDetails.layer.shadowColor = UIColor.black.cgColor
        myDetails.layer.shadowOffset = CGSize(width: 0, height: 2)
        myDetails.layer.shadowOpacity = 0.1
        myDetails.layer.shadowRadius = 4
        
        help.layer.cornerRadius = 15.0
        help.clipsToBounds = false
        help.layer.shadowColor = UIColor.black.cgColor
        help.layer.shadowOffset = CGSize(width: 0, height: 2)
        help.layer.shadowOpacity = 0.1
        help.layer.shadowRadius = 4
        
        privacy.layer.cornerRadius = 15.0
        privacy.clipsToBounds = false
        privacy.layer.shadowColor = UIColor.black.cgColor
        privacy.layer.shadowOffset = CGSize(width: 0, height: 2)
        privacy.layer.shadowOpacity = 0.1
        privacy.layer.shadowRadius = 4
        
        logout.layer.cornerRadius = 15.0
        logout.clipsToBounds = false
        logout.layer.shadowColor = UIColor.black.cgColor
        logout.layer.shadowOffset = CGSize(width: 0, height: 2)
        logout.layer.shadowOpacity = 0.1
        logout.layer.shadowRadius = 4
        
        
        
//        // Retrieve the stored profile image from UserDefaults
//                if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
//                    let image = UIImage(data: imageData) {
//                    imageView.image = image
//
////                    imageView.layer.cornerRadius = imageView.frame.width / 2 // Make it circular
////                    imageView.clipsToBounds = true // Ensure content doesn't go beyond rounded bounds
//
//                }
        imageView.layer.cornerRadius=65.0
        imageView.layer.masksToBounds=true
        imageView.layer.shadowOpacity=0.2
        imageView.layer.shadowOffset.width=1
        imageView.layer.shadowOffset.height=1.5
//
//    // Add an observer to listen for the "ProfilePictureUpdated" notification: 21/08/2023 | Rolva
//            NotificationCenter.default.addObserver(self, selector: #selector(updateProfilePicture), name: NSNotification.Name(rawValue: "ProfilePictureUpdated"), object: nil)
//
//
//
//
//        // Retrieve the stored user information from UserDefaults for username: 03/08/2023, Rolva
//        if let user_Name = UserDefaults.standard.data(forKey: "reg1"), let name = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(user_Name) as? [String] {
//
//            let fullName = name[0] + " " + name[1]
//            //userName.text = fullName
//
//        }
//
//      // Retrieve the stored user information from UserDefaults for email: 03/08/2023, Rolva
//        if let email_Address = UserDefaults.standard.data(forKey: "reg5"), let name = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(email_Address) as? [String] {
//
//            //email.text=name[0]
//        }
//

    }
    
    // Selector method to update the profile picture: 21/08/2023 | Rolva
//    @objc func updateProfilePicture() {
//        // Retrieve the stored profile image from UserDefaults
//                if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
//                    let image = UIImage(data: imageData) {
//                    //imageView.image = image
//
////                    imageView.layer.cornerRadius = imageView.frame.width / 2
////                                imageView.clipsToBounds = true
//        }
//    }
   
    @IBAction func logoutClick(_ sender: Any) {
        //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.removeObject(forKey: "tokenExpire")

    }
    
    //updating UI 25/08/2023 Robert
    private func updateUI() {
        let imageUrlString = self.viewModel.userProfile?.imageUrl ?? ""
        let trimmedImageUrlString = imageUrlString.replacingOccurrences(of: "http://res.cloudinary.com/", with: "")

        if let imageUrl = URL(string: "https://res.cloudinary.com/" + trimmedImageUrlString) {
            URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
                guard let self = self else {
                    return // Avoiding strong reference cycles
                }

                if let error = error {
                    print("Error fetching image:", error)
                    // Handle the error appropriately, e.g., display an error message to the user
                    return
                }

                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }.resume()
        }

        print(imageUrlString)
        email.text = viewModel.userProfile?.email ?? ""
        userName.text = viewModel.userProfile!.firstName + " " + viewModel.userProfile!.lastName
    }
   
}




