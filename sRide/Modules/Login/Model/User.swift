//
//  User.swift
//  sRide
//
//  Created by sride on 24/08/18.
//  Copyright © 2018 sride. All rights reserved.
//

import Foundation

class User {
    var userName : String
    var phoneNumber : String
    var emailID : String
    var otp : String
    var requestCode : String
    var accessToken : String
    
    init(name: String = "" ,
         number : String = "",
         email: String = "",
         otp: String = "",
         requestCode:String = "",
         accessToken : String = "") {
        
        self.userName = name
        self.phoneNumber = number
        self.emailID = email
        self.otp = otp
        self.requestCode = requestCode
        self.accessToken = accessToken
    }
   
}
