//
//  WantsVsNeedsVC.swift
//  SimpliSave
//
//  Created by DA MAC  M1 154 on 2023/07/18.
//

import UIKit

class WantsVsNeedsVC: UIViewController {

    @IBOutlet weak var needsVswantsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        needsVswantsView.layer.cornerRadius = 15.0 // Set the corner radius here
        needsVswantsView.layer.shadowColor = UIColor.black.cgColor
        needsVswantsView.layer.shadowOffset = CGSize(width: 0, height: 2)
        needsVswantsView.layer.shadowOpacity = 0.1
        needsVswantsView.layer.shadowRadius = 4
        needsVswantsView.clipsToBounds = false // Allow shadow to be visible beyond the bounds of the UITextView
    }
    

}
