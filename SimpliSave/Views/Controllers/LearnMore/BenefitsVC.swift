//
//  BenefitsVC.swift
//  SimpliSave
//
//  Created by DA MAC  M1 154 on 2023/07/18.
//

import UIKit

class BenefitsVC: UIViewController {
    
    
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view1.layer.cornerRadius = 15.0 // Set the corner radius here
        view1.clipsToBounds = false
        view1.layer.shadowColor = UIColor.black.cgColor
        view1.layer.shadowOffset = CGSize(width: 0, height: 2)
        view1.layer.shadowOpacity = 0.1
        view1.layer.shadowRadius = 4
        
        
        view2.layer.cornerRadius = 15.0 // Set the corner radius here
        view2.clipsToBounds = false
        view2.layer.shadowColor = UIColor.black.cgColor
        view2.layer.shadowOffset = CGSize(width: 0, height: 2)
        view2.layer.shadowOpacity = 0.1
        view2.layer.shadowRadius = 4
    
    
    }
}
