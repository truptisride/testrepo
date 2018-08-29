//
//  PhoneNumberViewController.swift
//  sRide
//
//  Created by sride on 24/08/18.
//  Copyright © 2018 sride. All rights reserved.
//

import UIKit

class PhoneNumberViewController: BaseViewController {
    
    @IBOutlet weak var btnPhoneNumberSend: UIButton!
    @IBOutlet weak var lblPhoneMessage: UILabel!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    let phoneNumberPresenter = EnterPhoneNumberPresenter(userService: EnterPhoneNumberService())
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        appDelegate.delegate = self
        txtPhoneNumber.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.75, animations: {
            self.txtPhoneNumber.becomeFirstResponder()
            self.btnPhoneNumberSend.isEnabled = false
            
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: OTP View MEthods
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    func requestOTP(phoneNumber: String) {
        if let txtNumber = txtPhoneNumber.text {
            self.navigatetoVerifyVC(number: txtNumber, requestCode: "")
        }
    }
    
    func getOTP(_ otp: [OTPViewData]) {
    }
    
    //MARK : Deinitialization of Variables , objects and instances
    deinit {
        appDelegate.delegate = nil
    }
}

extension PhoneNumberViewController {
    @IBAction func sendPhoneNumberBtnAction(_ sender: UIButton) {
        let networkManager = NetworkManager.sharedInstance
        if networkManager.isWifiWithInternetAvailable || networkManager.isLocalWiFiAvailable{
            if self.txtPhoneNumber.text?.count != 0 {
                self.phoneNumberPresenter.isPhoneNumberValidFor(phoneNumber: self.txtPhoneNumber.text!) { (isValidNumber) in
                    if isValidNumber {
                        //send OTP
                        self.btnPhoneNumberSend.isEnabled = false
                        self.phoneNumberPresenter.requestOTP(phoneNumber: self.txtPhoneNumber.text!, completion: {
                            (user) in
                            print("User is \(user)")
                            self.txtPhoneNumber.text = ""
                            self.txtPhoneNumber.resignFirstResponder()
                            self.navigatetoVerifyVC(number: self.txtPhoneNumber.text!, requestCode: user.requestCode)
                            
                        })
                    }else{
                        print("Invalid Number")
                        self.showBasicAlert(title: "Invalid Number", message: "Please enter valid number.", alertType: .oneButton,completion:{
                            _,_  in
                            print("success")
                        })
                    }
                }
            }else{
                self.showBasicAlert(title: "Blank Field", message: "Phone number can not be empty.", alertType: .oneButton,completion:{
                    _,_  in
                    print("success")
                    self.txtPhoneNumber.becomeFirstResponder()
                })
            }
        }else{
            self.showBasicAlert(title: "No Internet Connection", message: "Please make sure that you are connected to internet.", alertType: .oneButton,completion:{
                _,_  in
                print("success")
                self.txtPhoneNumber.becomeFirstResponder()
            })
        }
    }//eof action
    
    //MARK: Navigate Screen to Verify View COntroller
    func navigatetoVerifyVC(number: String, requestCode : String){
        let storyboard = UIStoryboard(name: StoryboardConstants.LOGIN_STORYBOARD, bundle: nil)
        let verifyOTPVC : PinVerificationViewController = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.PINVERIFICATIONVIEWCONTROLLER)as! PinVerificationViewController
        verifyOTPVC.numberString = number
        verifyOTPVC.requestCode = requestCode
        self.navigationController!.pushViewController(verifyOTPVC, animated: true)
    }
    
    
}

//MARK: Alert View delegate Method
extension PhoneNumberViewController : AlertViewDelegate {
    
    func callAlertViewMethod() {
        self.showBasicAlert(title: "Error", message: "Please check your Wi-Fi Connection.", alertType: .oneButton) {
            _,_ in
        }
    }
}

//Textfield Delegate method
extension PhoneNumberViewController : UITextFieldDelegate {
    //TextField Action Method
    @IBAction func textChangeAction(_ sender: Any) {
        if ((txtPhoneNumber.text?.count)! > LoginConstants.PHONENUMBER_LOWERLIMIT) && ((txtPhoneNumber.text?.count)! < LoginConstants.PHONENUMBER_UPPERLIMIT) {
            self.btnPhoneNumberSend.isEnabled = true
        }
    }
    
    //Textfield Delegate method for Detecting back space
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            if ((txtPhoneNumber.text?.count)! <= LoginConstants.PHONENUMBER_LOWERLIMIT){5
                self.btnPhoneNumberSend.isEnabled = false
            }
        }
        return true
    }
}
