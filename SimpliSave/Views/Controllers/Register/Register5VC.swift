//
//  Register5VC.swift
//  SimpliSave
//
//  Created by DA MAC  M1 154 on 2023/07/18.
//

import UIKit

class Register5VC: UIViewController {
    
// MARK: - Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cellTextField: UITextField!
    @IBOutlet weak var nextStep: UIButton!
    @IBOutlet weak var userName: UILabel!
    

// MARK: - View Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customise the emTextField - Masana - 21/07/2023
        
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = UIColor(hex: "#850856")?.cgColor
        emailTextField.layer.cornerRadius = 15.0
        emailTextField.clipsToBounds = true
        
       // Customise the cellTextField - Masana - 21/07/2023
        
        cellTextField.layer.borderWidth = 1.0
        cellTextField.layer.borderColor = UIColor(hex: "#850856")?.cgColor
        cellTextField.layer.cornerRadius = 15.0
        cellTextField.clipsToBounds = true
        
        
      // Customise the nextStep button - Masana - 21/07/2023
        
        nextStep.layer.cornerRadius = 15.0 // Set the corner radius here
        nextStep.clipsToBounds = true // Ensures the corners are rounded
        nextStep.layer.backgroundColor = UIColor(hex: "#850856")?.cgColor
        
      // Getting the registered userName to display - Masana - 07/08/2023
        
        if let user_Name = UserDefaults.standard.data(forKey: "reg1"), let name = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(user_Name) as? [String] {
            
            userName.text=name[0]
        }
        
      // navigates to the next View Controller - Masana - 21/07/2023
        
        if let pageViewController = parent as? RegisterPageVC {
            pageViewController.setCount = false
        }
    }
    
// MARK: - Button Actions
    
    
    @IBAction func btnNext(_ sender: Any) {
        
        // Check if emailTextField and cellTextField have values, otherwise show an alert - Masana - 25/07/2023
        
        guard let email = emailTextField.text, let cellNumber = cellTextField.text else {
                    showAlert(message: "Please enter all fields")
                    return
                }
        // Check if emailTextField and cellTextField are not empty after trimming whitespace, otherwise show an alert - Masana - 25/07/2023
        
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                   cellNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                   showAlert(message: "Please fill in all fields")
                   return
               }
        
        // Check if the email is in a valid format using a regular expression pattern - Masana - 25/07/2023
        
        let emailPattern = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
                let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
                if !emailPredicate.evaluate(with: email) {
                    showAlert(message: "Please enter a valid email address.")
                    return
                }
        // Check if the cell number is in a valid format using a regular expression pattern - Masana - 25/07/2023
        
        let cellPattern = "^0\\d{9}$"
                let cellPredicate = NSPredicate(format: "SELF MATCHES %@", cellPattern)
                if !cellPredicate.evaluate(with: cellNumber) {
                    showAlert(message: "Please enter a valid cellphone number.")
                    return
                }
        
        // Check if email is already registered - Masana - 07/08/2023
        
//        if let existingData = UserDefaults.standard.data(forKey: "reg5"),
//                   let existingRegData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(existingData) as? [String],
//                   let existingEmail = existingRegData.first,
//                   existingEmail == email {
//                    showAlert(message: "This email is already registered.")
//                    return
//                }
        //if the fields are not empty, the entered data is saved to userDefault 02/08/2023 Robert

        let reg5=[emailTextField.text,cellTextField.text]

                if let data = try? NSKeyedArchiver.archivedData(withRootObject: reg5, requiringSecureCoding: false) {
                    UserDefaults.standard.set(data, forKey: "reg5")
                    UserDefaults.standard.synchronize()
                }
        
        
        if let pageViewController = parent as? RegisterPageVC {
            pageViewController.setCount = true
            print( pageViewController.setCount)
            pageViewController.changePage(to: 6, animated: true)
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
