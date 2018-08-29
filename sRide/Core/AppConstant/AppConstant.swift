//
//  AppConstant.swift
//  sRide
//
//  Created by Rachit Sharma on 26/08/18.
//  Copyright © 2018 sride. All rights reserved.
//

import Foundation
import UIKit

class AppConstant: NSObject {
    internal let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    internal static let IPHONE_X_DEFAULT_NAVIGATION_BAR_HEIGHT:CGFloat = 88
    
    struct ScreenSize
    {
        static let SCREEN_WIDTH         = UIScreen.main.nativeBounds.width
        static let SCREEN_HEIGHT        = UIScreen.main.nativeBounds.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType
    {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 1136.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 1136.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 1334.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 2208.0
        static let IS_IPHONE_X  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 2436.0
    }
}
