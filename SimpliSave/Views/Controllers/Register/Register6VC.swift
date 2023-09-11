//
//  Register6VC.swift
//  SimpliSave
//
//  Created by DA MAC  M1 154 on 2023/07/18.
//

import UIKit
import Alamofire
class Register6VC: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var endStep: UIButton!
    
    var passwordToggleImageView: UIImageView!
    var confirmPasswordToggleImageView: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Customise the passwordTextField - Masana - 21/07/2023
        
           passwordTextField.layer.borderWidth = 1.0
           passwordTextField.layer.borderColor = UIColor(hex: "#850856")?.cgColor
           passwordTextField.layer.cornerRadius = 15.0
           passwordTextField.clipsToBounds = true
          
        // Customise the confrimPassword - Masana - 21/07/2023
        
           confirmPassword.layer.borderWidth = 1.0
           confirmPassword.layer.borderColor = UIColor(hex: "#850856")?.cgColor
           confirmPassword.layer.cornerRadius = 15.0
           confirmPassword.clipsToBounds = true
           
        // Customize the endStep button - Masana - 21/07/2023
        
           endStep.layer.cornerRadius = 15.0
           endStep.clipsToBounds = true
           endStep.layer.backgroundColor = UIColor(hex: "#850856")?.cgColor
        
       // Call septup password and confirm password to secure textfielfds - Masana - 07/08/2023
        
        setupPasswordTextField()
        setupConfirmPasswordTextField()
        
    }
    func setupPasswordTextField() {
        
        // Creates a view to hold the password toggle icon - Masana - 07/08/2023
        
            let passwordRightView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 24))
            let passwordContentView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 24))
            
        // Creates an image view for the password toggle icon - Masana - 07/08/2023
        
            passwordToggleImageView = UIImageView(image: UIImage(named: "closedeye"))
            passwordToggleImageView.contentMode = .scaleAspectFit
            passwordToggleImageView.frame = CGRect(x: 6, y: 0, width: 24, height: 24)
            passwordContentView.addSubview(passwordToggleImageView)
            
        // Adds a tap gesture recognizer to toggle the password visibility - Masana - 07/08/2023
        
            let passwordTapGesture = UITapGestureRecognizer(target: self, action: #selector(passwordToggleTapped))
            passwordContentView.addGestureRecognizer(passwordTapGesture)
        
        // Puts the password toggle icon view and add it as the right view of the password field - Masana - 07/08/2023
        
            passwordRightView.addSubview(passwordContentView)
            passwordTextField.rightView = passwordRightView
            passwordTextField.rightViewMode = .always
            passwordTextField.isSecureTextEntry = true
        }
    func setupConfirmPasswordTextField() {
        
        // Creates a view to hold the confirm password toggle icon - Masana - 07/08/2023
        
            let confirmPasswordRightView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 24))
            let confirmPasswordContentView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 24))
            
        // Creates an image view for the confirm password toggle icon - Masana - 07/08/2023
        
            confirmPasswordToggleImageView = UIImageView(image: UIImage(named: "closedeye"))
            confirmPasswordToggleImageView.contentMode = .scaleAspectFit
            confirmPasswordToggleImageView.frame = CGRect(x: 6, y: 0, width: 24, height: 24)
            confirmPasswordContentView.addSubview(confirmPasswordToggleImageView)
        
        // Adds a tap gesture recognizer to toggle the confirm password visibility - Masana - 07/08/2023
        
            let confirmPasswordTapGesture = UITapGestureRecognizer(target: self, action: #selector(confirmPasswordToggleTapped))
            confirmPasswordContentView.addGestureRecognizer(confirmPasswordTapGesture)
            
        // Puts the confirm password toggle icon view and add it as the right view of the confirm password field - Masana - 07/08/2023
        
            confirmPasswordRightView.addSubview(confirmPasswordContentView)
            confirmPassword.rightView = confirmPasswordRightView
            confirmPassword.rightViewMode = .always
            confirmPassword.isSecureTextEntry = true
        }
    
    // Function to toggle the visibility of the password text in the passwordTextField - Masana - 03/08/2023
    
    @objc func passwordToggleTapped() {
            passwordTextField.isSecureTextEntry.toggle()
            let imageName = passwordTextField.isSecureTextEntry ? "closedeye" : "openeye"
            passwordToggleImageView.image = UIImage(named: imageName)
        }
        
    // Function to toggle the visibility of the password text in the confrimPassword - Masana - 03/08/2023
    
        @objc func confirmPasswordToggleTapped() {
            confirmPassword.isSecureTextEntry.toggle()
            let imageName = confirmPassword.isSecureTextEntry ? "closedeye" : "openeye"
            confirmPasswordToggleImageView.image = UIImage(named: imageName)
        }
    
    // Function called when the endStep button is tapped - Masana -  25/07/2023
    
    @IBAction func endReg(_ sender: Any) {
        // Check if both password and confirmPassword fields are filled, otherwise show an alert - Masana - 25/07/2023
        guard let password = passwordTextField.text,
              let confirm_Password = confirmPassword.text else {
            showAlert(message: "Please fill in all fields.")
            return
        }
        if password.isEmpty || confirm_Password.isEmpty {
            showAlert(message: "Please fill in all fields.")
            return
        }
        // Check if the password is valid according to a specific pattern, otherwise show an alert - Masana - 25/07/2023
        
        if !isValidPassword(password) {
            showAlert(message: "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one digit.")
            return
        }
        // Check if the password and confirmPassword match, otherwise show an alert - Masana - 25/07/2023
        
        if password != confirm_Password {
            showAlert(message: "Passwords do not match.")
            return
        }
        
        //if the fields are not empty, the entered data is saved to userDefault 02/08/2023 Robert
        
        let reg6=[passwordTextField.text,confirmPassword.text]
        
        if let data = try? NSKeyedArchiver.archivedData(withRootObject: reg6, requiringSecureCoding: false) {
            UserDefaults.standard.set(data, forKey: "reg6")
            UserDefaults.standard.synchronize()
        }
        
        
        //getting all the saved values and sending them to the API
        var firstName=""
        var lastName=""
        var cellPhoneNumber=""
        var userEmailA=""
        var idNo=""
        var imageUrl="test"
        var uPassword=""
        let date = Date()
        
        //getting current date in this format "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" Robert 15/08/2023
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC+2")
        let formattedDate = dateFormatter.string(from: date)
        
        
        
        if let reg1 = UserDefaults.standard.data(forKey: "reg1"), let reg_1 = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(reg1) as? [String]{
            if let reg2 = UserDefaults.standard.data(forKey: "reg2"), let reg_2 = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(reg2) as? [String]{
                if let reg3 = UserDefaults.standard.data(forKey: "reg3"), let reg_3 = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(reg3) as? [String]{
                    if let reg4 = UserDefaults.standard.data(forKey: "reg4"), let reg_4 = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(reg4) as? [String]{
                        if let reg5 = UserDefaults.standard.data(forKey: "reg5"), let reg_5 = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(reg5) as? [String]{
                            if let reg6 = UserDefaults.standard.data(forKey: "reg6"), let reg_6 = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(reg6) as? [String]{
                                
                                //print(reg_6[0])
                                firstName=reg_1[0]
                                lastName=reg_1[1]
                                
                                userEmailA=reg_5[0]
                                cellPhoneNumber=reg_5[1]
                                
                                idNo=reg_4[0]
                                //imageUrl=reg1[]
                                uPassword=reg_6[0]
                            }
                            
                        }
                    }
                }
            }
        }
        
        
        print("Firstname: "+firstName)
        print("Lastname: "+lastName)
        print("email: "+userEmailA)
        print("cell: "+cellPhoneNumber)
        print("id: "+idNo)
        print("Password: "+password)
        print("date: "+formattedDate)
        
        /*
         created 10 08 2023
         updated: 15 08 2023
         Dev: Robert
         Function name:Register
         Description: Calling the register function and passing data.
         */
//        let authViewModel = registerDataService()
//
//
//        authViewModel.register(firstName: firstName, lastName: lastName, cellphoneNumber: cellPhoneNumber, email: userEmailA, idNo: idNo, password: password, createdAt: formattedDate, updatedAt: formattedDate)
        
        let authViewModel = registerDataService()

        authViewModel.register(firstName: firstName, lastName: lastName, cellphoneNumber: cellPhoneNumber, email: userEmailA, idNo: idNo, password: password, createdAt: formattedDate, updatedAt: formattedDate) { result in
            switch result {
            case .success(let response):
                print("Server Response: \(response)")
                if let message = response["Message"] as? String {
                    DispatchQueue.main.async {
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        if(message=="Registration Success!"){
                            if let dashboard = storyboard.instantiateViewController(withIdentifier: "Login") as? LoginVC {
                                self.navigationController?.pushViewController(dashboard, animated: true)
                            }
                        }
                        else{
                            self.dspResponse(message: message)

                        }
                       
                    }
                }

            case .failure(let error):
                print("Error: \(error)")
            }
        }
        

        
        
        /*
         saving data to json files robert 25/08/2023
         */
//        let viewModel = uViewModel()
//
//        //passing data to the function to be saved to the Json file Robert 25 08 2023
//        viewModel.setUserDetails(firstName: firstName, lastName: lastName, cellphoneNumber: cellPhoneNumber, email: userEmailA, idNo: idNo, password: password, createdAt: formattedDate, updatedAt: formattedDate)
//
//
//        //error handling
//        viewModel.saveData { error in
//            if let error = error {
//                print("Error saving data: \(error)")
//            } else {
//                print("Data saved successfully.")
//            }
//
//        }
        
    }
    
    
    
    func dspResponse(message:String){
        showAlert(message: message)
    }
    
    
    // Function to validate the password against a specific pattern using a regular expression - Masana - 25/08/2023
    
    private func isValidPassword(_ password: String) -> Bool {
           let passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$"
           let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
           return passwordPredicate.evaluate(with: password)
       }
    // Function to show an alert with the given message - Masana - 25/07/2023
    
    private func showAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
}
