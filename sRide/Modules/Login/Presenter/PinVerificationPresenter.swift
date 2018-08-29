//
//  PinVerificationPresenter.swift
//  sRide
//
//  Created by sride on 25/08/18.
//  Copyright © 2018 sride. All rights reserved.
//

import UIKit



protocol UserViewDelegate {
    func startLoading()
    func finishLoading()
    func verifyOTP(otpData : User)
}

class PinVerificationPresenter {

    fileprivate let verifyOTPService:VerifyOTPService

    init(verifyOTPService:VerifyOTPService){
        self.verifyOTPService = verifyOTPService
    }
    func verifyOTP(user : User){
        verifyOTPService.verifyOTP(userData: user, completionHandler: {
            (userData) in
            
            print(userData)
            
        })
        
        
    }
}
