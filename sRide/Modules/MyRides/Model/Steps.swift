//
//  Steps.swift
//  sRide
//
//  Created by trupti adalapure on 28/08/18.
//  Copyright © 2018 sride. All rights reserved.
//

import UIKit
import ObjectMapper

class Steps: SRideBaseModel {
    
    private var overviewPolyline : String?

    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        overviewPolyline <- map ["overviewPolyline"]
    }
    
}
