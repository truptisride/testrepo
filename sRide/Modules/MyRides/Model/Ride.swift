//
//  Ride.swift
//  sRide
//
//  Created by trupti adalapure on 27/08/18.
//  Copyright © 2018 sride. All rights reserved.
//
import ObjectMapper
import UIKit


class Ride : SRideBaseModel {
    
     var rideTime : String?
     var sourceAddress : String?
     var destinationAddress : String?
    private var matchesCount : String?
    private var sentRequestCount : String?
    private var receivedRequestCount : String?
    private var bookedCount : String?
    private var status : Bool = false
    private var isEditable : Bool = false
    private var userType : String?
    private var viaAddress : String?
     var tripId : String?
    private var totalSeats : Int?
    private var seatsLeft : Int?
    private var rideDistanceInMeter : Double?
    private var bikeDriverAmount : Double?
    private var bikeRiderAmount : Double?
    private var riderAmount : Double?
    private var driverAmount : Double?
    private var origin : String?
    private var overviewPolyline : String?
    private var startLocationArray : Array<Location>?
    private var endLocationArray : Array<Location>?
    private var southWestPoint : Array<Location>?
    private var northEastPoint : Array<Location>?
    private var steps : Array<Steps>?
    private var endAddressObject : Array<Address>?
    private var startAddressObject : Array<Address>?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        rideTime <- map["date"]
        sourceAddress <- map["from"]
        destinationAddress <- map["to"]
        status <- map["status"]
        userType <- map["userType"]
        viaAddress <- map["viaAddress"]
        tripId <- map["tripId"]
        totalSeats <- map["seats"]
        isEditable <- map["isEditable"]
        seatsLeft <- map["seatsLeft"]
        rideDistanceInMeter <- map["distanceInMeter"]
        origin <- map["origin"]
        startLocationArray <- map["startLocation"]
        endLocationArray <- map["endLocation"]
        southWestPoint <- map["southWestPoint"]
        northEastPoint <- map["northEastPoint"]
        riderAmount <- map["riderAmount"]
        driverAmount <- map["driverAmount"]
        bikeDriverAmount <- map["bikeDriverAmount"]
        bikeRiderAmount <- map["bikeRiderAmount"]
        overviewPolyline <- map["overviewPolyline"]
        steps <- map["steps"]
        endAddressObject <- map["endAddressObject"]
        startAddressObject <- map["startAddressObject"]
    }
    

   
    
   
    
    
    // Response objects
    
    
    
    
}
