//
//  VerifyOTPService.swift
//  sRide
//
//  Created by sride on 25/08/18.
//  Copyright © 2018 sride. All rights reserved.
//

import UIKit

enum VerifyOTPResult {
    case success(Bool,String)
    case failure(Bool)
}

class VerifyOTPService {

    func verifyOTP(userData: User,completionHandler: @escaping (User) -> Void ){
    
        var paramsDict = Dictionary<String, Any>()
        paramsDict = ["phoneNumber":userData.phoneNumber,
                      "countryCode":"+91","country":"IN","requestCode":userData.requestCode,"pin":userData.otp]
       
        NetworkManager.sharedInstance.requestForPostAPIWithParameters(requestURL: VERIFYOTPURL, params: paramsDict as [String : AnyObject], successHandler: {
            (responseDict, isOTPValid) in
            print(responseDict)
            if isOTPValid
            {
                _  = responseDict["status"] as! Bool
                let resultArray : Dictionary<String,Any> = responseDict["result"] as! Dictionary<String, Any>
                let accessToken : String = resultArray["accessToken"] as! String
                print(accessToken)
               // completion(.success(isValidOTP))
            }else{
                //completion(.failure(isOTPValid))
            }
            
            
        })//failure handler
        {
            (failuremsg, isOTPNotSent) in
            print(failuremsg)
        }
        
        
    }//eof
    
}
