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
       
       checking if the token expired, and redirecting to login
        let token = TokenManager()
        
        if token.isExpire {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let dashboard = storyboard.instantiateViewController(withIdentifier: "Login") as? LoginVC {
                self.navigationController?.pushViewController(dashboard, animated: true)
            }        } else {
            print("Still Valid")
        }
        
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
    // customise buttons
        
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
        
        
        imageView.layer.cornerRadius=65.0
        imageView.layer.masksToBounds=true
        imageView.layer.shadowOpacity=0.2
        imageView.layer.shadowOffset.width=1
        imageView.layer.shadowOffset.height=1.5

    }
    
   
    @IBAction func logoutClick(_ sender: Any) {
        //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.removeObject(forKey: "tokenExpire")

    }
    
    //updating UI 
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




