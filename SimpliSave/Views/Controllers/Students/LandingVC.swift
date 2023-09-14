//
//  LandingVC.swift
//  SimpliSave
//
//  Created by Rolva Mashale  on 2023/07/18.
//

import UIKit

class LandingVC: UIViewController {
    
    //Outlet for the UIButton used to start with registration
    @IBOutlet weak var button: UIButton!
    
    //Outlet for the UIButton used to login
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        // Set button corner radius, border width and bordercolor
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor(named: "AppColor")?.cgColor
    }
}
