//
//  MyRideTableViewCell.swift
//  sRide
//
//  Created by trupti adalapure on 27/08/18.
//  Copyright © 2018 sride. All rights reserved.
//

import UIKit

class MyRideTableViewCell: UITableViewCell {

   
    
    @IBOutlet weak var bookedViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var requestSentHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var heightOfRequestRecieved: NSLayoutConstraint!
    @IBOutlet weak var matcheVIewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var rideDetailsView: UIView!
    
    @IBOutlet weak var bookedView: UIView!
    @IBOutlet weak var sentRequestView: UIView!
    @IBOutlet weak var requestRecievedView: UIView!
    @IBOutlet weak var rideMatchesView: UIView!
    
    @IBOutlet weak var lblStartAdrdess: UILabel!
    @IBOutlet weak var lblRideTime: UILabel!
    @IBOutlet weak var destinationAddress: UILabel!
    
    @IBOutlet weak var imgForBookAndMatches: UIImageView!
    @IBOutlet weak var lblMatchesCount: UILabel!
    
    //recieved requests
    @IBOutlet weak var lblRecRequestCount: UILabel!
    
    //sent request
    
    @IBOutlet weak var lblSentRequestCount: UILabel!
    
    @IBOutlet weak var lblBookedCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
