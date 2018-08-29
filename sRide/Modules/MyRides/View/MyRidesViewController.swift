//
//  DashboardViewController.swift
//  sRide
//
//  Created by sride on 25/08/18.
//  Copyright © 2018 sride. All rights reserved.
//

import UIKit
import ObjectMapper

public enum Type :Int{
    
    case Number
    case String
    case Bool
    case Array
    case Dictionary
    case Null
    case Unknown
}

class MyRidesViewController: BaseViewController {
    
    @IBOutlet weak var myRidesTableView: UITableView!
    var myRidesDictonary : Dictionary<String, Ride>?
    var myRidesArray = Array<Ride>()
     var userView: UIImageView!
    var matchesCount = 0
    var sentReqCount = 0
    var recReqCount = 0
    var bookedCOunt = 0
    var cellHeight = 0.0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let ride = Ride.init(time: "5:30 PM", saddress: "Teerth Technospace Pune", desAddress: "Dange Chowk, Main Road, Pune", matchCount: "0", sentReqCount: "2", recReqCount: "7", bookCount: "2")
        myRidesArray.append(ride)
        let ride1 = Ride.init(time: "6:30 PM", saddress: "Karishma Society, Mai Road Kothrud", desAddress: "CCPL Society, Narhe, Pune", matchCount: "2", sentReqCount: "0", recReqCount: "4", bookCount: "1")
        myRidesArray.append(ride1)

        let rid2 = Ride.init(time: "7:30 PM", saddress: "Teerth Technospace Pune", desAddress: "Dange Chowk, Main Road, Pune", matchCount: "6", sentReqCount: "3", recReqCount: "0", bookCount: "3")
        myRidesArray.append(rid2)

        let rid3 = Ride.init(time: "8:30 AM", saddress: "Gaytri Landmarks Phase 2, Pune", desAddress: "City Mall, Ganeshkhind Road, University Circle,Pune", matchCount: "64", sentReqCount: "32", recReqCount: "17", bookCount: "0")
        myRidesArray.append(rid3)
        
        let ride4 = Ride.init(time: "10:30 AM", saddress: "Mahad", desAddress: "Karad", matchCount: "4", sentReqCount: "98", recReqCount: "1", bookCount: "6")
        
        
        myRidesArray.append(ride4)*/
        
        self.populateMyRideData()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func populateMyRideData(){
       // myRidesDictonary = []
        
        var paramsDict = Dictionary<String, Any>()
        
        paramsDict = ["user_id":"Rc37Fe0vif",
                      ]
        NetworkManager.sharedInstance.requestForMyRides(requestURL: MYRIDESURL, params: paramsDict as [String : AnyObject], successHandler: {
            (responseDict, isOTPValid) in
            
            
            let rides : Array<Ride> = responseDict as! Array<Ride>
            //print(rides)
                self.myRidesArray = rides
            self.myRidesTableView.reloadData()
           
        })
        {
            (failuremsg, isOTPNotSent) in
            print(failuremsg)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}//eof

extension MyRidesViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return myRidesArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15; // space b/w cells
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell:MyRideTableViewCell = (tableView.dequeueReusableCell(withIdentifier: TableViewCellID.MYRIDECELLID) as! MyRideTableViewCell?)!
        let ride = myRidesArray[indexPath.section]
        
        cell.lblStartAdrdess.text = ride.sourceAddress
        cell.lblRideTime.text = ride.rideTime
        cell.lblMatchesCount.text = "2 Matches"
        cell.destinationAddress.text = ride.destinationAddress
        //cell.lblRecRequestCount.text = ride.receivedRequestCount+" Request Recieved"
        //cell.lblSentRequestCount.text = ride.sentRequestCount+" Request Send"
        //matchesCount = Int(ride.matchesCount)!
        //sentReqCount = Int(ride.sentRequestCount)!
        //recReqCount = Int(ride.receivedRequestCount)!
        //bookedCOunt = Int(ride.bookedCount)!
        
     /* if(recReqCount == 0)
        {
            cell.heightOfRequestRecieved.constant = 0
            cell.requestRecievedView.isHidden = true
        }
       
        
        if(sentReqCount == 0)
        {
            cell.requestSentHeight.constant = 0
            cell.sentRequestView.isHidden = true
        }
        
        if(matchesCount == 0)
        {
            cell.lblMatchesCount.text = "No matches yet"
        }
        cellHeight = Double(cell.contentView.layer.frame.height)
        */
        return  cell

    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       /* if(sentReqCount == 0 || bookedCOunt == 0 || recReqCount == 0)
       {
        return 200
       }else if matchesCount == 0{
        return 200
        }else{
            return 250
        }*/
        return 300//CGFloat(cellHeight)
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
   
    
}
