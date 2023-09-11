//
//  Register2VC.swift
//  SimpliSave
//
//  Created by DA MAC  M1 154 on 2023/07/18.
//

import UIKit

class Register2VC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblBank: UILabel!
    @IBOutlet weak var btnSelectBank: UIButton!
    @IBOutlet weak var userName: UILabel!
    
    
    var isDropdownVisible = false
    var setState = false
    let dropdownData = [ "Absa","FNB", "NetBank", "Standard Bank"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.layer.cornerRadius = 15
        btnSelectBank.layer.cornerRadius = 15
        lblBank.layer.cornerRadius = 15
        lblBank.clipsToBounds = true
        lblBank.layer.backgroundColor = (UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.00)).cgColor
        
        // Getting the registered userName to display - Masana - 07/08/2023
        
        if let user_Name = UserDefaults.standard.data(forKey: "reg1"), let name = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(user_Name) as? [String] {
            
            userName.text=name[0]
        }
        
        //sets he page to false so that it cannot be accessed, 25/07/23, Shahiel
        if let pageViewController = parent as? RegisterPageVC {
            pageViewController.setCount = false
            print(pageViewController.setCount)
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.layer.isHidden = true
    }
    
    //MARK: - IBActions
    
    //hides and unhides the picker view, 25/07/23, Shahiel
    @IBAction func btnSelect(_ sender: Any) {
        if setState == false{
            pickerView.layer.isHidden = false
            setState = true
        }else{
            pickerView.layer.isHidden = true
            setState = false
        }

    }
    
    //Validates user input and moves to next page on click, 25/07/23, Shahiel
    @IBAction func btnNext(_ sender: Any) {
        if lblBank.text == "" {
            print("empty")
            let alertController = UIAlertController(title: "Empty Field", message: "Please select a bank", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                }
                alertController.addAction(okAction)
                
                present(alertController, animated: true, completion: nil)
        }else{
            //if the fields are not empty, the entered data is saved to userDefault 02/08/2023 Robert

            let reg2=[lblBank.text]
            
            if let data = try? NSKeyedArchiver.archivedData(withRootObject: reg2, requiringSecureCoding: false) {
                UserDefaults.standard.set(data, forKey: "reg2")
                UserDefaults.standard.synchronize()
            }
            
            if let pageViewController = parent as? RegisterPageVC {
                pageViewController.setCount = true
                print( pageViewController.setCount)
                pageViewController.changePage(to: 2, animated: true)
            }
        }
    }

}

//MARK: - extension pickerview

extension Register2VC {
    
    //sets number of columns for pickerview, 25/07/23, Shahiel
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //sets number of rows in pickerview, 25/07/23, Shahiel
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dropdownData.count
    }
    
    //gets dat for picker view from array, 25/07/23, Shahiel
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dropdownData[row]
    }
    
    //gets the selected option and displays it in a label, 25/07/23, Shahiel
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedOption = dropdownData[row]
        lblBank.text = selectedOption
    }
}
