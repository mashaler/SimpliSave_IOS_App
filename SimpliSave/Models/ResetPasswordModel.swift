//
//  ResetPasswordModel.swift
//  SimpliSave
//
//  Created by DA MAC M1 160 on 2023/08/28.
//

//Model for Reset Password - Masana - 28/08/2023
import Foundation

struct ResetPasswordModel : Codable {
    
    var otp: String
    var newPassword: String
    var confirmPassword: String
}
