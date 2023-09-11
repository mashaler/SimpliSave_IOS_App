//
//  ResetPasswordModel.swift
//  SimpliSave
//

//Model for Reset Password
import Foundation

struct ResetPasswordModel : Codable {
    
    var otp: String
    var newPassword: String
    var confirmPassword: String
}
