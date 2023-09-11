//
//  Register7.swift
//  SimpliSave
//
//  Created by DA MAC M1 126 on 2023/07/28.
//

import UIKit

class Register7VC: UIViewController {

    @IBOutlet weak var lblTarget: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var userName: UILabel!
    
    
    var setState = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.layer.cornerRadius = 15
        lblTarget.layer.cornerRadius = 15
        
        lblTarget.clipsToBounds = true
        lblTarget.layer.borderWidth = 1
        lblTarget.layer.borderColor = (UIColor(red: 0.52, green: 0.03, blue: 0.34, alpha: 1.00)).cgColor
        
        // Getting the registered userName to display - Masana - 07/08/2023
        
        if let user_Name = UserDefaults.standard.data(forKey: "reg1"), let name = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(user_Name) as? [String] {
            
            userName.text=name[0]
        }
        
        // Do any additional setup after loading the view.
        if let pageViewController = parent as? RegisterPageVC {
            pageViewController.setCount = false
        }
    }
    
    func addSavings(){
        
    }

    @IBAction func btnEnter(_ sender: Any) {
        if lblTarget.text!.isEmpty {
            print("empty")
            let alertController = UIAlertController(title: "Empty Field", message: "Please fill in the field", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                }
                alertController.addAction(okAction)
                
                present(alertController, animated: true, completion: nil)
        }else{
            //if the fields are not empty, the entered data is saved to userDefault 02/08/2023 Robert

            let reg7 = lblTarget.text
            
            UserDefaults.standard.set(reg7, forKey: "reg7")
            
//            if let data = try? NSKeyedArchiver.archivedData(withRootObject: reg7, requiringSecureCoding: false) {
//                UserDefaults.standard.set(data, forKey: "reg7")
//                UserDefaults.standard.synchronize()
//            }
            
            
            
            if let pageViewController = parent as? RegisterPageVC {
                pageViewController.setCount = true
                pageViewController.changePage(to: 5, animated: true)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
