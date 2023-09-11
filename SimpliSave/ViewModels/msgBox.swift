//
//  msgBox.swift
//  SimpliSave
//
//  Created by Robert on 2023/09/04.
//

import UIKit

class showAlert:UIViewController{
    func  showAlert(msg:String){
        let alertController = UIAlertController(
            title: "Error",
                 message: msg,
                 preferredStyle: .alert
            
             )
        
        //`setting the color of heading to red
        let attributedString = NSAttributedString(
            string: "Error",
            attributes: [
                .foregroundColor: UIColor.red
            ]
        )

        // Set the attributed title for the alert controller
        alertController.setValue(attributedString, forKey: "attributedTitle")
        
        // Add an action button to the alert
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
           
        }
        
        // Add the action button to the alert controller
        alertController.addAction(okAction)
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
}
