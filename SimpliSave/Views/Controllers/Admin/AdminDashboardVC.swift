//
//  AdminDashboardVC.swift
//  SimpliSave
//
//  Created by DA MAC  M1 154 on 2023/07/18.
//

import UIKit

class AdminDashboardVC: UIViewController {
    

    @IBOutlet weak var PersonImage: UIButton!
    @IBOutlet weak var Logout: UIButton!
    @IBOutlet weak var ManageStudentAccounts: UIButton!
    @IBOutlet weak var AccountDetails: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the corner radius here: 16/07/2023 | Rolva
        // Allow shadow to be visible beyond the bounds of the UITextView: 16/07/2023 | Rolva
        ManageStudentAccounts.layer.cornerRadius = 15.0
        ManageStudentAccounts.clipsToBounds = false
        AccountDetails.layer.cornerRadius = 15.0
        AccountDetails.clipsToBounds = false
        
       Logout.layer.cornerRadius = 15.0
       Logout.clipsToBounds = false
        
    }

}

