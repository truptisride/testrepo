//
//  StartLocation.swift
//  sRide
//
//  Created by trupti adalapure on 28/08/18.
//  Copyright © 2018 sride. All rights reserved.
//

import UIKit
import ObjectMapper

class Location: SRideBaseModel {

    private var latitude : Double?
    private var longitude : Double?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        latitude <- map ["endLocation.0"]
        longitude <- map ["endLocation.1"]
    }
    
    
}
