//
//  NetworkManager.swift
//  LetzGO[workspace]
//
//  Created by sride on 21/08/18.
//  Copyright © 2018 Covo LLC. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class NetworkManager: NSObject {

    var reachability: Reachability!

    class var sharedInstance : NetworkManager {
        struct Static {
            static let instance : NetworkManager = NetworkManager()
        }
        return Static.instance
    }
    
    //MARK:- GET Method
    /**
     This function will send request and fetch response for GET Type
     - parameter parameterDictionary: No params
     - parameter requestURL: Request URL
     - parameter successHandler: Return response and status flag if successed
     - parameter failureHandler: Return error message and status flag if failed
     */
    
    func requestForGetAPI(requestURL:String, headers:HTTPHeaders, successHandler:@escaping (Dictionary<String,Any>,Bool) -> Void, failureHandler:@escaping (String,Bool) -> Void) {
        print("URL--->",requestURL)
        print("headers--->",headers)
        Alamofire.request(requestURL, headers: headers).responseJSON { response in
            // print("Response",response)
            print("Response value",response.result.value as Any)
            switch response.result {
            case .success:
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")
                if let json = response.result.value {
                    //let jsonDictionary : NSDictionary = json as! NSDictionary
                    //successHandler(jsonDictionary,true)
                    let jsonDictionary : Dictionary<String, Any> = json as! Dictionary
                    successHandler(jsonDictionary,true)
                }
            case .failure(let error):
                print(error.localizedDescription)
                failureHandler(error.localizedDescription ,false)
            }
        }
    }
    
    //MARK:- POST Method
    
    /**
     This function will send request and fetch response for POST Type
     - parameter parameterDictionary: Parameters required for request
     - parameter requestURL: Request URL
     - parameter successHandler: Return response and status flag if successed
     - parameter failureHandler: Return error message and status flag if failed
     */
    
    func requestForPostAPI(requestURL:String, headers:HTTPHeaders, successHandler:@escaping (_ responseData:Any, _ responseStatus:Bool) -> Void, failureHandler:@escaping ((_ errorMessage:String,_ responseStatus:Bool) -> Void)) {
        
        Alamofire.request(requestURL, method: .post, headers: headers).responseJSON {
            response in
            switch response.result {
            case .success:
                if let json = response.result.value {
                    
                    //let jsonDictionary : NSDictionary = json as! NSDictionary
                    //successHandler(jsonDictionary,true)
                    
                    let jsonDictionary : Dictionary<String, Any> = json as! Dictionary
                    successHandler(jsonDictionary,true)
                } else {
                    failureHandler("Process failed",false)
                }
                break
            case .failure(let error):
                print(error)
                failureHandler(error.localizedDescription,false)
            }
        }
        
    }
    
    //-------------test method----------------
  
    func requestForMyRides(requestURL:String,params : [String : AnyObject], successHandler:@escaping (_ responseData:Any, _ responseStatus:Bool) -> Void, failureHandler:@escaping ((_ errorMessage:String,_ responseStatus:Bool) -> Void)) {
        var ride : Ride?
        Alamofire.request(requestURL, method: .post, parameters: params, encoding: URLEncoding.httpBody).responseJSON {
            response in
            switch response.result {
            case .success:
                if let json = response.result.value {
                    var tempArray = Array<Ride>()
                    
                    if json is NSDictionary{
                        let tempDic:NSDictionary? = (json as! NSDictionary)
                        let reultsObjects : NSDictionary? = tempDic!["result"] as? NSDictionary
                        if reultsObjects != nil{
                            
                            for dataObjects in reultsObjects!
                            {
                                //print(dataObjects)
                                let keyData = dataObjects.value
                                let mapper = Mapper<Ride>()
                                if let testObject = mapper.map(JSON: keyData as! [String : Any]){
                                    ride = testObject
                                    tempArray.append(ride!)
                                }
                            }
                            
                        }
                    }
                    
                    let responseData = json as? Dictionary<String,Any>
                    guard responseData != nil else{
                        return
                    }
                    
                    
                  
                 
                   
                    
                    let jsonDictionary : Dictionary<String, Any> = json as! Dictionary
                    successHandler(tempArray as Any,true)
                    
                } else {
                    failureHandler("Process failed",false)
                }
                break
            case .failure(let error):
                print(error)
                failureHandler(error.localizedDescription,false)
            }
        }
        
    }
    
    /*guard let responseJSON = response.result.value as? Array<[String: AnyObject]> else {
    failure(0,"Error reading response")
    return
    }
    guard let customers:[Customer] = Mapper<Customer>().mapArray(JSONArray: responseJSON) else {
    failure(0,"Error mapping response")
    return
    }*/
    
    
    //MARK:- POST Method
    
    /**
     This function will send request and fetch response for POST Type
     - parameter parameterDictionary: Parameters required for request
     - parameter requestURL: Request URL
     - parameter successHandler: Return response and status flag if successed
     - parameter failureHandler: Return error message and status flag if failed
     */
    func requestForPostAPIWithParameters(requestURL:String, params : [String : AnyObject],successHandler:@escaping (_ responseData:Dictionary<String,Any>, _ responseStatus:Bool) -> Void, failureHandler:@escaping ((_ errorMessage:String,_ responseStatus:Bool) -> Void)) {
        
        Alamofire.request(requestURL, method: .post, parameters: params, encoding: URLEncoding.httpBody).responseJSON { response in
            
            print(response.result)   // result of response serialization
            
            if response.response?.statusCode == 200{
                //print("success")
                if let json = response.result.value {
                    
                    let jsonDictionary : Dictionary<String,Any> = json as! Dictionary
                    let status : Bool = jsonDictionary["status"] as! Bool
                    if(status)
                    {
                        successHandler(jsonDictionary,true)
                    }else{
                        successHandler(jsonDictionary,false)
                    }
                    
                }
            }else{
                if response.result.value != nil {
                    print("no response")
                    //let jsonDictionary : NSDictionary = json as! NSDictionary
                    //successHandler(jsonDictionary,false)
                }
                
            }
            
        }
    }//eof
    
    //MARK:- DOWNLOAD Method
    
    /**
     This function will send request and fetch response for Download Image
     - parameter parameterDictionary: Parameters required for request if any
     - parameter requestURL: Request URL
     - parameter successHandler: Return response and status flag if successed
     - parameter failureHandler: Return error message and status flag if failed
     */
    
    func requestForDownloadImage(parameterDictionary:Parameters, requestURL:String, successHandler:@escaping (_ responseData:Any, _ responseStatus:Bool) -> Void, failureHandler:@escaping ((_ errorMessage:String,_ responseStatus:Bool) -> Void))  {
        Alamofire.download(requestURL).downloadProgress { progress in
            print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseData { response in
                switch response.result {
                case .success:
                    if let data = response.result.value {
                        let image = UIImage(data: data)
                        successHandler(image as Any,true)
                    }
                    break
                case .failure(let error):
                    print("Error",error)
                    failureHandler(error.localizedDescription,false)
                    break
                }
        }
    }
    
    //MARK:- UPLOAD Method
    
    /**
     This function will send request and fetch response for Download Image
     - parameter image: Image for upload
     - parameter requestURL: Request URL
     - parameter successHandler: Return response and status flag if successed
     - parameter failureHandler: Return error message and status flag if failed
     */
    
    func requestForUploadImage(image:UIImage, requestURL:String, successHandler:@escaping (_ responseData:Any, _ responseStatus:Bool) -> Void, failureHandler:@escaping ((_ errorMessage:String,_ responseStatus:Bool) -> Void))  {
        let imageData = UIImageJPEGRepresentation(image, 0.9)!
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData, withName: "photo_path", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
        }, to:requestURL)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    print(response.response as Any) // URL response
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
    ///////---------------------- URLSESSION METHOD START-----------------------------//////////

    /**
     This function will send request and fetch response for POST Type
     - parameter parameterDictionary: Parameters required for request
     - parameter requestURL: Request URL
     - parameter successHandler: Return response and status flag if successed
     - parameter failureHandler: Return error message and status flag if failed
     */
    func requestForPostAPIWithParametersWithURLSession(requestURL:String, params : [String : AnyObject],successHandler:@escaping (_ responseData:Any, _ responseStatus:Bool) -> Void, failureHandler:@escaping ((_ errorMessage:String,_ responseStatus:Bool) -> Void)) {
        
        let url = URL(string: requestURL)
        
        do{
            let jsonDataTemp = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            // let decoded = try JSONSerialization.jsonObject(with: jsonDataTemp, options: [])
            
            if !jsonDataTemp.isEmpty {
                var request = URLRequest(url: url!)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonDataTemp
                print(request.debugDescription)
                
                let task = URLSession.shared.dataTask(with: request, completionHandler: { (responseData: Data?, response: URLResponse?, error: Error?) in
                    print(responseData?.description as Any)
                    
                    do{
                        //here dataResponse received from a network request
                        let jsonResponse = try JSONSerialization.jsonObject(with:
                            responseData!, options: [])
                        print(jsonResponse) //Response result
                        let responseDict = jsonResponse as! Dictionary<String, Any>
                        let status = responseDict["status"] as! Bool
                        if(status){
                            successHandler(responseDict,true)
                        }else{
                            successHandler(responseDict,false)
                        }
                        
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                })
                task.resume()
            }
        }catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Reachablity -
    var isWifiWithInternetAvailable: Bool {
        get {
            let reachability: Reachability = Reachability.forInternetConnection()
            let networkStatus: Int = reachability.currentReachabilityStatus().rawValue
            return networkStatus != 0
        }
    }
    var isLocalWiFiAvailable: Bool {
        get {
            let reachability: Reachability = Reachability.forLocalWiFi()
            let networkStatus: Int = reachability.currentReachabilityStatus().rawValue
            return networkStatus != 0
        }
    }
    func isHostNameReachable(_ hostName: String) -> Bool {
        let reachability: Reachability = Reachability(hostName: hostName)
        let networkStatus: Int = reachability.currentReachabilityStatus().rawValue
        return networkStatus != 0
    }
    
}//eof









