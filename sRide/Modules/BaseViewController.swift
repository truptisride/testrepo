//
//  BaseViewController.swift
//  sRide
//
//  Created by Rachit Sharma on 25/08/18.
//  Copyright © 2018 sride. All rights reserved.
//

import UIKit

enum AlertType {
    case oneButton
    case twoButtonWithOK
    case twoButtonWithoutOK
    case threeButton
}

class BaseViewController: UIViewController {

    @IBOutlet weak var constraintNavigationHeight:NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if(self.constraintNavigationHeight != nil){
            if AppConstant.DeviceType.IS_IPHONE_X{
                self.constraintNavigationHeight?.constant = AppConstant.IPHONE_X_DEFAULT_NAVIGATION_BAR_HEIGHT
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Basic Alerts for displaying Error Messages.
    func showBasicAlert(title:String, message:String,alertType:AlertType, completion:@escaping (_ isFirstButton:Bool , _ isSecondButton:Bool ) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        switch alertType {
        case .oneButton:
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                completion(true, false)
            }))
            break
        case .twoButtonWithOK:
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                completion(true, false)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { action in
                self.dismiss(animated: true, completion: nil)
            }))
            break
        case .threeButton:
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                completion(true, false)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { action in
                self.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: { action in
                completion(false, true)
            }))
        case .twoButtonWithoutOK:
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: { action in
                completion(true, false)
            }))
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { action in
                self.dismiss(animated: true, completion: nil)
            }))
            break
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
