//
//  Register3VC.swift
//  SimpliSave
//
//  Created by DA MAC  M1 154 on 2023/07/18.
//

import UIKit

class Register3VC: UIViewController {

    @IBOutlet weak var btnConnect: UIButton!
    @IBOutlet weak var lblVerified: UILabel!
    @IBOutlet weak var btnDetails: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btnConnect.layer.cornerRadius = 15
        btnDetails.layer.cornerRadius = 15
        lblVerified.layer.cornerRadius = 15
        lblVerified.clipsToBounds = true
        lblVerified.layer.backgroundColor = (UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.00)).cgColor
        
        if let pageViewController = parent as? RegisterPageVC {
            pageViewController.setCount = false
        }
    }
    
    //MARK: - IBActions
    
    //Validates user input and moves to next page on click, 25/07/23, Shahiel
    @IBAction func btnNext(_ sender: Any) {
        if lblVerified.text == "" {
            let alertController = UIAlertController(title: "Cannot link to account", message: "Please fill in your online banking details or ensure they are correct", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                }
                alertController.addAction(okAction)
                
                present(alertController, animated: true, completion: nil)
        }else{
            //if the fields are not empty, the entered data is saved to userDefault 02/08/2023 Robert

            let reg3=[lblVerified.text]
            
            if let data = try? NSKeyedArchiver.archivedData(withRootObject: reg3, requiringSecureCoding: false) {
                UserDefaults.standard.set(data, forKey: "reg3")
                UserDefaults.standard.synchronize()
            }
            
            if let pageViewController = parent as? RegisterPageVC {
                pageViewController.setCount = true
                pageViewController.changePage(to: 3, animated: true)
            }
        }
       
    }
    
    //displays alert to enter username and password for banking details, 25/07/23, Shahiel
    @IBAction func btnEnter(_ sender: Any) {
        let alertController = UIAlertController(title: "Enter Input", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (Username_) in
            Username_.placeholder = "Enter your username here"
        }
        
        alertController.addTextField { (Password_) in
            Password_.placeholder = "Enter your password here"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] (_) in
            
            guard let Username = alertController?.textFields?.first else { return }
            
            guard let Password = alertController?.textFields?.first else { return }
            
            let input = Username.text
            let input2 = Password.text
            
            if Username.text == "" || Password.text == ""{
                let alertController = UIAlertController(title: "No Detials", message: "Please fill in your online banking details", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                    }
                    alertController.addAction(okAction)
                    
                self.present(alertController, animated: true, completion: nil)
            }else{
                self.lblVerified.text = "Your details have been verified"
            }
            
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
            
    }

}
