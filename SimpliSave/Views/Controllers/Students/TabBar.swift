//
//  TabBar.swift
//  SimpliSave
//
//  Created by DA MAC M1 126 on 2023/07/26.
//

import UIKit

class TabBar: UITabBarController, UITabBarControllerDelegate {
    
    @IBOutlet weak var bottomNav: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        navigationItem.hidesBackButton = true
        navigationItem.title = "DashBoard"
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        
        tabBar.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
    }
    
    //gets current selected index and sets page title for it, 27/07/23, Shahiel
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedTabIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            if selectedTabIndex == 0 {
                navigationItem.title = "DashBoard"
            }
            if selectedTabIndex == 1 {
                navigationItem.title = "Budget"
            }
            if selectedTabIndex == 2 {
                navigationItem.title = "Savings"
            }
            if selectedTabIndex == 3 {
                navigationItem.title = "Transactions"
            }
            if selectedTabIndex == 4 {
                navigationItem.title = "Academy"
            }
            

        }
    }
    
}

//            let selectedView = self.viewControllers?[selectedIndex].view
//                UIView.transition(
//                with: view,
//                duration:0.7,
//                options:[.transitionCrossDissolve],
//                animations:{selectedView?.alpha=1.0},
//                completion: nil)
