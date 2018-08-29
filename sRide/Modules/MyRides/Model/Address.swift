//
//  Address.swift
//  sRide
//
//  Created by trupti adalapure on 29/08/18.
//  Copyright © 2018 sride. All rights reserved.
//

import UIKit
import ObjectMapper

class Address: SRideBaseModel {

    private var vicinity : String?
    private var name : String?
    private var addressComponents : Array<AddressComponenets>?
    private var types : Dictionary<String,Any>?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        vicinity <- map ["vicinity"]
        name <- map["name"]
        addressComponents <- map["address_components"]
        types <- map["types"]
    }
    
}

class AddressComponenets : Address{
    
    private  var short_name : String?
    private var long_name : String?

    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        short_name <- map ["short_name"]
        long_name <- map["long_name"]
    }
}
