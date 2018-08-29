//
//  PinVerificationViewController.swift
//  sRide
//
//  Created by sride on 24/08/18.
//  Copyright © 2018 sride. All rights reserved.
//

import UIKit

class PinVerificationViewController: BaseViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var otpView: VPMOTPView!
    @IBOutlet weak var lblPinVerificationtxt: UILabel!
    var enteredOtp: String = ""
    var numberString : String = ""
    var requestCode : String = ""
    let pinVerificationPresenter = PinVerificationPresenter(verifyOTPService: VerifyOTPService())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        //SetNavigation Bar and Items
        setNavigationBarAndItems()
        
        //initialize OTP View
        initializeOTPView()
    
        //setUpTextAndColor
        setUpTextAndColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: set All label text and color
    func setUpTextAndColor(){
        lblPinVerificationtxt.text = "Please send Verification code to \(numberString) number"
    }
    
    //MARK: Set Navigation Bar and Items
    func setNavigationBarAndItems(){
        self.navigationItem.title = numberString
    }
    
    //MARK: Initialize Custom OTP View
    func initializeOTPView(){
        otpView.otpFieldsCount = 4
        otpView.otpFieldDefaultBorderColor = UIColor.red
        otpView.otpFieldEnteredBorderColor = UIColor.blue
        otpView.otpFieldErrorBorderColor = UIColor.green
        otpView.otpFieldBorderWidth = 1
        otpView.otpFieldSize = 28
        otpView.otpFieldSeparatorSpace = 8
        otpView.otpFieldDisplayType = .square
        otpView.delegate = self
        otpView.shouldAllowIntermediateEditing = false

        // Create the UI
        otpView.initializeUI()
    }
    
    //Navigate To Dashboard View Controller
    func navigateToDashboardVC(){
        let dashboardTabVC = UIStoryboard.init(name: StoryboardConstants.DASHBOARD_STORYBOARD, bundle: Bundle.main).instantiateViewController(withIdentifier: ViewControllerIdentifier.DASHBOARDTABVIEWCONTROLLER) as? UITabBarController
        self.navigationController?.pushViewController(dashboardTabVC!, animated: true)
    }
}

//MARK: CUSTOM OTP View Delegate Methods
extension PinVerificationViewController: VPMOTPViewDelegate {
    
    func hasEnteredAllOTP(hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        if hasEntered{
            if enteredOtp.count != 0 {
                let userData : User = User()
                userData.phoneNumber = numberString
                userData.otp = enteredOtp
                userData.requestCode = requestCode
                pinVerificationPresenter.verifyOTP(user: userData)
                DispatchQueue.main.async {
                    self.navigateToDashboardVC()
                }
            }
        }
        return enteredOtp == "1234"
    }
    
    func shouldBecomeFirstResponderForOTP(otpFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otpString: String) {
        enteredOtp = otpString
        print("OTPString: \(otpString)")
    }
}

//MARK: Resend Code Method Action
extension PinVerificationViewController {
    @IBAction func resendCodeActionMethod(_ sender: Any) {
        self.showBasicAlert(title: "NUMBER CONFIRMATION", message: " \n \(numberString) \n \n  is your phone number above correct?", alertType: .twoButtonWithOK) { _,_  in
            print("Number Action")
        }
    }//eof action
    
    func isValidData(otpStr : String) -> Bool {
        var isValid = false
        if enteredOtp.count != 0 || !enteredOtp.isEmpty{
            print("Otp Correct ! Now go to the Main Landing Screen")
            isValid = true
        }else{
        }
        return isValid
    }
}
