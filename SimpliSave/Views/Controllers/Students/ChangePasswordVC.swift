//
//  ChangePasswordVC.swift
//  SimpliSave
//
//Author: Ofentse Malebye
//Date: 2023-08-07
//
//

import UIKit
import Lottie

class ChangePasswordVC: UIViewController {
    let animationView = LottieAnimationView(name: "ChangePassword")
    
    
    @IBOutlet weak var oldPasswordTF: UITextField!
    
    @IBOutlet weak var newPasswordTF: UITextField!
    
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    @IBOutlet weak var changePasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Author: Ofentse Malebye
        //Date: 2023-08-07
        //setting up Lottie animation by creating an animationView, configuring its appearance and behavior.
        animationView.contentMode = .scaleAspectFit
        animationView.frame = CGRect(x: 100, y: 110, width: 200, height: 200)
        view.addSubview(animationView)
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        animationView.play()
        
        //Author: Ofentse Malebye
        //Date: 25/07/2023
        //Description: Setting up the visual appearance of the old password text field :
        oldPasswordTF.layer.borderWidth = 1
        oldPasswordTF.layer.borderColor = UIColor(named: "AppColor")?.cgColor
        oldPasswordTF.layer.cornerRadius = 15
        oldPasswordTF.clipsToBounds = true
        
        //Author: Ofentse Malebye
        //Date: 25/07/2023
        //Description: Setting up the visual appearance of the new password text field: 25/07/2023
        newPasswordTF.layer.borderWidth = 1
        newPasswordTF.layer.borderColor = UIColor(named: "AppColor")?.cgColor
        newPasswordTF.layer.cornerRadius = 15
        newPasswordTF.clipsToBounds = true
        
        //Author: Ofentse Malebye
        //Date:  25/072023
        //Description: Setting up the visual appearance of the confirm password text field
        confirmPasswordTF.layer.borderWidth = 1
        confirmPasswordTF.layer.borderColor = UIColor(named: "AppColor")?.cgColor
        confirmPasswordTF.layer.cornerRadius = 15
        confirmPasswordTF.clipsToBounds = true
        
        changePasswordButton.layer.cornerRadius = 15
        changePasswordButton.clipsToBounds = true
        
        // Print the stored password after a successful update
                printStoredPassword()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        guard let oldPassword = oldPasswordTF.text,
              let newPassword = newPasswordTF.text,
              let confirmNewPassword = confirmPasswordTF.text else {
            // Handle nil or empty input
            return
        }
        

        // Validate user input : 27/07/2023 | Ofentse Malebye

        if newPassword.isEmpty || newPassword.count < 6 {
            // Display an error message for weak password
            showAlert(message: "Password should be at least 6 characters long.")
            return
        }
        //Check if new password matches confirm password : 27/07/2023 | Ofentse Malebye
        if newPassword != confirmNewPassword {
            // Displaying an error message for mismatched passwords
            showAlert(message: "New password and confirmation password do not match.")
            return
            
        }
        
        // Perform authentication to verify the current password: 02/08/2023 | Rolva Mashale
                if !verifyOldPassword(oldPassword) {
                    // Display an error message for incorrect current password
                    showAlert(message: "Incorrect current password.")
                    return
                }
        
        // Update the password in local storage : 02/08/2023 | Rolva Mashale
                updatePassword(newPassword)
                
                // Show success message: 02/08/2023 | rolav Mashale
                showAlert(message: "Password updated successfully.")
        }
    
    // Method to verify the old password
        func verifyOldPassword(_ oldPassword: String) -> Bool {

            // Implement your authentication logic here : 02/08/2023 | Rolva Mashale

            let storedPassword = "123456"
            return oldPassword == storedPassword
        }
    
    // Method to update the password in local storage (UserDefaults) : 02/08/2023 | Rolva Mashale
        func updatePassword(_ newPassword: String) {
            UserDefaults.standard.set(newPassword, forKey: "password")
        }
    
    
        
    // Method to show an alert message : 27/07/2023 | Ofentse Malebye
        func showAlert(message: String) {
            let alert = UIAlertController(title: "Change Password", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    
    // Method to retrieve and print the stored password from UserDefaults: 02/08/2023 | Rolva Mashale
        func printStoredPassword() {
            if let storedPassword = UserDefaults.standard.string(forKey: "password") {
                print("Stored Password: \(storedPassword)")
            } else {
                print("Password not found in UserDefaults.")
            }
        }
        
    }

