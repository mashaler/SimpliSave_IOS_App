//
//  ResetPasswordVC.swift
//  SimpliSave
//
//  Created by DA MAC  M1 154 on 2023/07/18.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
//MARK: - Outlets
    
    @IBOutlet weak var txtPasswordNew: UITextField!
    @IBOutlet weak var txtPasswordConfirm: UITextField!
    @IBOutlet weak var resetButton: UIButton!

//MARK: - Variables - Masana - 30/08/2023
    
        var userEmail: String?
        var receivedOTP: String?
        var viewModel: ResetPasswordViewModel!
    
        var passwordNewToggleImageView: UIImageView!
        var passwordConfirmToggleImageView: UIImageView!

//MARK: - View Lifecycle
    
        override func viewDidLoad() {
            super.viewDidLoad()
            print("Received OTP in Reset: \(receivedOTP ?? "No OTP")")
            // Customize UI if needed
            let imgIcon = UIImageView(image: UIImage(named: "lock 1"))
            imgIcon.tintColor = .gray
            imgIcon.frame = CGRect(x: 10, y: 0, width: 40, height: 25)

            let contentView = UIView()
            contentView.addSubview(imgIcon)
            contentView.frame = CGRect(x: 10, y: 0, width: 40, height: 25)

            resetButton.layer.cornerRadius = 15.0
            
            
            txtPasswordNew.leftView = contentView
            txtPasswordNew.leftViewMode = .always
         

            txtPasswordNew.layer.cornerRadius = 15
            txtPasswordNew.layer.borderColor = UIColor(named: "absa")?.cgColor
            txtPasswordNew.layer.borderWidth = 1
            txtPasswordNew.layer.masksToBounds = true
            
            let imgIcon2 = UIImageView(image: UIImage(named: "email"))
            imgIcon2.tintColor = .gray
            imgIcon2.frame = CGRect(x: 10, y: 0, width: 40, height: 25)

            let contentView2 = UIView()
            contentView2.addSubview(imgIcon2)
            contentView2.frame = CGRect(x: 10, y: 0, width: 40, height: 25)

            txtPasswordConfirm.leftView = contentView2
            txtPasswordConfirm.leftViewMode = .always
          

            txtPasswordConfirm.layer.cornerRadius = 15
            txtPasswordConfirm.layer.borderColor = UIColor(named: "absa")?.cgColor
            txtPasswordConfirm.layer.borderWidth = 1
            txtPasswordConfirm.layer.masksToBounds = true
            
            setupPasswordNewTextField()
            setupPasswordConfirmTextField()
            viewModel = ResetPasswordViewModel(resetPasswordService: ResetPasswordDataService())
        
            navigationItem.hidesBackButton = true
        }
//MARK: - Functions - Masana - 30/08/2023
    
    func setupPasswordNewTextField() {
        
        // Creates a view to hold the password toggle icon - Masana - 30/08/2023
        
            let passwordRightView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 24))
            let passwordContentView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 24))
            
        // Creates an image view for the password toggle icon - Masana - 30/08/2023
        
            passwordNewToggleImageView = UIImageView(image: UIImage(named: "closedeye"))
            passwordNewToggleImageView.contentMode = .scaleAspectFit
            passwordNewToggleImageView.frame = CGRect(x: 6, y: 0, width: 24, height: 24)
            passwordContentView.addSubview(passwordNewToggleImageView)
            
        // Adds a tap gesture recognizer to toggle the password visibility - Masana - 30/08/2023
        
            let passwordTapGesture = UITapGestureRecognizer(target: self, action: #selector(passwordNewToggleTapped))
            passwordContentView.addGestureRecognizer(passwordTapGesture)
        
        // Puts the password toggle icon view and add it as the right view of the password field - Masana - 30/08/2023
        
            passwordRightView.addSubview(passwordContentView)
            txtPasswordNew.rightView = passwordRightView
            txtPasswordNew.rightViewMode = .always
            txtPasswordNew.isSecureTextEntry = true
        }
    func setupPasswordConfirmTextField() {
        
        // Creates a view to hold the password toggle icon - Masana - 30/08/2023
        
            let passwordRightView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 24))
            let passwordContentView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 24))
            
        // Creates an image view for the password toggle icon - Masana - 30/08/2023
        
            passwordConfirmToggleImageView = UIImageView(image: UIImage(named: "closedeye"))
            passwordConfirmToggleImageView.contentMode = .scaleAspectFit
            passwordConfirmToggleImageView.frame = CGRect(x: 6, y: 0, width: 24, height: 24)
            passwordContentView.addSubview(passwordConfirmToggleImageView)
            
        // Adds a tap gesture recognizer to toggle the password visibility - Masana - 30/08/2023
        
            let passwordTapGesture = UITapGestureRecognizer(target: self, action: #selector(passwordConfirmToggleTapped))
            passwordContentView.addGestureRecognizer(passwordTapGesture)
        
        // Puts the password toggle icon view and add it as the right view of the password field - Masana - 30/08/2023
        
            passwordRightView.addSubview(passwordContentView)
            txtPasswordConfirm.rightView = passwordRightView
            txtPasswordConfirm.rightViewMode = .always
            txtPasswordConfirm.isSecureTextEntry = true
        }
    // Function to toggle the visibility of the password text in the passwordTextField - Masana - 30/08/2023
    
    @objc func passwordConfirmToggleTapped() {
            txtPasswordConfirm.isSecureTextEntry.toggle()
            let imageName = txtPasswordConfirm.isSecureTextEntry ? "closedeye" : "openeye"
            passwordConfirmToggleImageView.image = UIImage(named: imageName)
        }

    // Function to toggle the visibility of the password text in the passwordTextField - Masana - 30/08/2023
    
    @objc func passwordNewToggleTapped() {
            txtPasswordNew.isSecureTextEntry.toggle()
            let imageName = txtPasswordNew.isSecureTextEntry ? "closedeye" : "openeye"
            passwordNewToggleImageView.image = UIImage(named: imageName)
        }
    // Function to validate the password against a specific pattern using a regular expression - Masana - 04/09/2023
    
    private func isValidPassword(_ password: String) -> Bool {
           let passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$"
           let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
           return passwordPredicate.evaluate(with: password)
       }
//MARK: - Actions - Masana - 03/02/2023
// Function to reset password - Masana - 03/02/2023
    
        @IBAction func btnReset(_ sender: UIButton) {
            guard let newPassword = txtPasswordNew.text,
                      let confirmPassword = txtPasswordConfirm.text,
                      let enteredOTP = receivedOTP else {
                showAlert(title: "Error", message: "Please enter all the fields")
                    return
                }
        // perform reset password - Masana - 30/08/2023
            
                let resetPasswordModel = ResetPasswordModel(
                    otp: enteredOTP,
                    newPassword: newPassword,
                    confirmPassword: confirmPassword
                )
            if txtPasswordNew.text != txtPasswordConfirm.text {
                showAlert(title: "Error", message: "Passwords do not match.")
                return
            }
            if !isValidPassword(txtPasswordNew.text!) {
                showAlert(title: "Error", message: "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one digit.")
                return
            }
                
            viewModel.resetPassword(resetPasswordModel: resetPasswordModel) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        // Display success message here
                        self?.showAlert(title: "Success", message: "Password reset was successful")
                    case .failure:
                        // Display error message here
                        self?.showAlert(title: "Error", message: "Password reset failed, please send another request")
                    }
                }
            }
        }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in }

        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    }

