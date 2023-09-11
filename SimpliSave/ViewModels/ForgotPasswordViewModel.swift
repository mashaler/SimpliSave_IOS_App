//
//  ForgotPasswordViewModel.swift
//  SimpliSave
//
//  Created by DA MAC M1 160 on 2023/08/28.
//

// View Model For Forgot Password - Masana - 28/08/2023

import Foundation

class ForgotPasswordViewModel {
    
    private let forgotPasswordService: ForgotPasswordDataService
    
    init(forgotPasswordService: ForgotPasswordDataService) {
        self.forgotPasswordService = forgotPasswordService
    }
    
    func sendForgotPasswordRequest(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let forgotPassword = ForgotPassword(email: email)
        
        forgotPasswordService.sendForgotPasswordRequest(forgotPassword: forgotPassword) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}





