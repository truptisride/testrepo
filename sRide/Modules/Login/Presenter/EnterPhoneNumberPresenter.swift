//
//  EnterPhoneNumberPresenter.swift
//  sRide
//
//  Created by sride on 24/08/18.
//  Copyright © 2018 sride. All rights reserved.
//

import UIKit

struct OTPViewData{
    let requestCode: String
    let number: String
}

protocol OTPViewDelegate {
    func startLoading()
    func finishLoading()
    func requestOTP(phoneNumber: String)
    func getOTP(_ otp: [OTPViewData])
    //func setEmptyUsers()
}

class EnterPhoneNumberPresenter {

    fileprivate let userService:EnterPhoneNumberService
    fileprivate var delegate : OTPViewDelegate?  = nil
    
    init(userService:EnterPhoneNumberService){
        self.userService = userService
    }
    
    func attachView(_ view:OTPViewDelegate){
        delegate = view
    }
    
    func detachView() {
        delegate = nil
    }
    
    //MARK: Request Phone Number and Validate it.
    func isPhoneNumberValidFor(phoneNumber: String, completion:@escaping (_ isPhoneNumberValid:Bool) -> Void) {
        if phoneNumber.isPhoneNumber {
            completion(true)
        }else{
            completion(false)
        }
    }
    
    //MARK: Send Phone Number for getting OTP
    func requestOTP(phoneNumber: String, completion:@escaping (_ userData:User) -> Void) {
        print(phoneNumber)
        self.userService.getOTPService(mobileNumber: phoneNumber) {
            (userData) in
            completion(userData)
        }
    }
}
