//
//  userSession.swift
//  SimpliSave
//

import Foundation
import UIKit

class TokenManager:UIViewController {
    
    func redirectLogin(){
        if let expiryDate=UserDefaults.standard.string(forKey: "tokenExpire"),expiryDate.isEmpty{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let dashboard = storyboard.instantiateViewController(withIdentifier: "Login") as? LoginVC {
                self.navigationController?.pushViewController(dashboard, animated: true)
            }
        }
        else{
            print("not emptyyyyy")
            
        }
    }
    
    var isExpire:Bool{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC+2")
        let currentTime = dateFormatter.string(from: date)
       // let expiryDate=UserDefaults.standard.string(forKey: "tokenExpire")
        var results:Bool=false
        if let expiryDate=UserDefaults.standard.string(forKey: "tokenExpire"){
            results=currentTime>expiryDate
        }
       
        return results
        
    }
    
    
}
