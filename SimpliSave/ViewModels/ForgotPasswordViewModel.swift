//
//  ForgotPasswordViewModel.swift
//  SimpliSave
//

// View Model For Forgot Password

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





