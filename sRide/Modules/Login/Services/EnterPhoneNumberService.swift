//
//  EnterPhoneNumberService.swift
//  sRide
//
//  Created by sride on 24/08/18.
//  Copyright © 2018 sride. All rights reserved.
//

import UIKit

enum OTPRequestResult {
    case success(Bool,String)
    case failure(Bool)
}

enum OTPValidateResult {
    case success(Bool)
    case failure(Bool)
}

class EnterPhoneNumberService{

    func getOTPService(mobileNumber: String,completionHandler: @escaping (User) -> Void ){
        var paramsDict = Dictionary<String, Any>()
    
        paramsDict = ["phoneNumber":mobileNumber,
                      "countryCode":"+91","country":"IN"]
        
        let userDetails : User = User(requestCode: "")

        NetworkManager.sharedInstance.requestForPostAPIWithParameters(requestURL: REQUESTOTPURL, params: paramsDict as [String : AnyObject], successHandler: {
            (responseDict, isOTPValid) in
            print(responseDict)
            
            if isOTPValid
            {
                _  = responseDict["status"] as! Bool
                let resultArray : Dictionary<String,Any> = responseDict["result"] as! Dictionary<String, Any>
                print(resultArray)
                userDetails.requestCode = resultArray["requestCode"] as! String
                completionHandler(userDetails)
               // completion(.success(isValidOTP))
            }else{
                //completion(.failure(isOTPValid))
            }
            
        })
        {
            (failuremsg, isOTPNotSent) in
            print(failuremsg)
        }
        
    }
    
    
}
