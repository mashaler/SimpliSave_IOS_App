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

        // Set the corner radius here
        // Allow shadow to be visible beyond the bounds of the UITextView
        ManageStudentAccounts.layer.cornerRadius = 15.0
        ManageStudentAccounts.clipsToBounds = false
        AccountDetails.layer.cornerRadius = 15.0
        AccountDetails.clipsToBounds = false
        
       Logout.layer.cornerRadius = 15.0
       Logout.clipsToBounds = false
        
    }

}

