//
//  OTPViewModel.swift
//  SimpliSave
//

// One Time Pin View Model
import Foundation

class OTPViewModel {
    
    private let otpService: OTPDataService
    
    init(otpService: OTPDataService) {
        self.otpService = otpService
    }
    
    func sendOTPRequest(email: String, completion: @escaping (Result<String, Error>) -> Void) {
        otpService.sendOTPRequest(email: email) { result in
            switch result {
            case .success(let otpModel):
                completion(.success(otpModel.otp))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
