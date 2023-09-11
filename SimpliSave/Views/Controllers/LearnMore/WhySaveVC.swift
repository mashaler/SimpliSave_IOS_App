//
//  WhySaveVC.swift
//  SimpliSave
//
//  Created by DA MAC  M1 154 on 2023/07/18.
//

import UIKit

class WhySaveVC: UIViewController {

// MARK: - Outlets
    
@IBOutlet weak var whySaveText: UIView!
 
// MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

         //customise the ui view - Masana - 21/07/2023
            whySaveText.layer.cornerRadius = 15.0
            whySaveText.layer.shadowColor = UIColor.black.cgColor
            whySaveText.layer.shadowOffset = CGSize(width: 0, height: 2)
            whySaveText.layer.shadowOpacity = 0.1
            whySaveText.layer.shadowRadius = 4
            whySaveText.clipsToBounds = false
    }
}
