//
//  OneTimePinVC.swift
//  SimpliSave
//
//  Created by DA MAC M1 160 on 2023/08/02.
//

import UIKit

class OneTimePinVC: UIViewController {
    
 //MARK: - Outlets
    
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
//MARK: - View Lifecycle - Masana - 02/08/2023
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customise the appearance of the otpTextField
        otpTextField.layer.borderWidth = 1.0
        otpTextField.layer.borderColor = UIColor(hex: "#850856")?.cgColor
        otpTextField.layer.cornerRadius = 15.0
        otpTextField.clipsToBounds = true
        
        nextButton.layer.cornerRadius = 15.0
        
        navigationItem.hidesBackButton = true
    }
  //MARK: - Actions - Masana - 28/08/2023
    
    @IBAction func nextButton(_ sender: UIButton) {
        //checks if one time pin is empty
        guard let enteredOTP = otpTextField.text, !enteredOTP.isEmpty else {
               showAlert(msg: "OTP can't be empty")
               return
           }
           //navigates to reset password
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let resetPasswordVC = storyboard.instantiateViewController(withIdentifier: "ResetPassword") as? ResetPasswordVC {
               resetPasswordVC.receivedOTP = enteredOTP
               self.navigationController?.pushViewController(resetPasswordVC, animated: true)
           }
    }
//MARK: - Functions - Masana - 28/08/2023
    
        func showAlert(msg: String) {
            let alertController = UIAlertController(
                title: "Message",
                message: msg,
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
     
