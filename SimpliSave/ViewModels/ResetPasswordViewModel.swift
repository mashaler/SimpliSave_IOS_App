//
//  ResetPasswordViewModel.swift
//  SimpliSave
//
//  Created by DA MAC M1 160 on 2023/08/28.
//

// Reset Password View Model - Masana - 28/08/2023
import Foundation

class ResetPasswordViewModel {
    
    private let resetPasswordService: ResetPasswordDataService
    
    init(resetPasswordService: ResetPasswordDataService) {
        self.resetPasswordService = resetPasswordService
    }
    
    func resetPassword(resetPasswordModel: ResetPasswordModel, completion: @escaping (Result<Void, Error>) -> Void) {

        resetPasswordService.sendResetPasswordRequest(resetPasswordModel: resetPasswordModel) { result in
            switch result {
            case .success:
                completion(.success(())) // Password reset successful
            case .failure(let error):
                completion(.failure(error)) // Handle password reset failure
            }
        }
    }
}
