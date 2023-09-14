//
//  Register1VC.swift
//  SimpliSave
//
//  Created by DA MAC  M1 154 on 2023/07/18.
//

import UIKit

class Register1VC: UIViewController {

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblSurname: UITextField!
    @IBOutlet weak var lblName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.layer.cornerRadius = 15
        lblName.layer.cornerRadius = 15
        lblName.clipsToBounds = true
        lblName.layer.borderWidth = 1
        lblName.layer.borderColor = (UIColor(red: 0.52, green: 0.03, blue: 0.34, alpha: 1.00)).cgColor
        lblSurname.layer.cornerRadius = 15
        lblSurname.clipsToBounds = true
        lblSurname.layer.borderWidth = 1
        lblSurname.layer.borderColor = (UIColor(red: 0.52, green: 0.03, blue: 0.34, alpha: 1.00)).cgColor

    }
    
    //MARK: -IBActions
    
    //Validates user input and moves to next page on click
    @IBAction func btnNext(_ sender: Any) {
        if lblName.text == "" || lblSurname.text == "" {
            let alertController = UIAlertController(title: "Empty Field", message: "Please fill in both fields", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                }
                alertController.addAction(okAction)
                
                present(alertController, animated: true, completion: nil)
        }else{
            
            //if the fields are not empty, the entered data is saved to userDefault 
            let reg1=[lblName.text,lblSurname.text]

            if let data = try? NSKeyedArchiver.archivedData(withRootObject: reg1, requiringSecureCoding: false) {
                UserDefaults.standard.set(data, forKey: "reg1")
                UserDefaults.standard.synchronize()
            }
            
            
           
                
            
            if let pageViewController = parent as? RegisterPageVC {
                pageViewController.setCount = true
                pageViewController.changePage(to: 1, animated: true)
            }
        }
        
    }
}
