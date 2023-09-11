//
//  OTPViewModel.swift
//  SimpliSave
//
//  Created by DA MAC M1 160 on 2023/08/29.
//

// One Time Pin View Model - Masana - 29/08/2023
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
