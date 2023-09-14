//
//  ResetPasswordViewModel.swift
//  SimpliSave
//

// Reset Password View Model
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
