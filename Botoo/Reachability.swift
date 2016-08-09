//
//  Reachability.swift
//  Botoo
//
//  Created by 혜인 on 2016. 8. 9..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import SystemConfiguration
import UIKit

public class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    class func alert() -> UIAlertController {
        let myAlert = UIAlertController(title:"알림", message: "인터넷 연결을 확인해주세요.", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title:"확인", style:UIAlertActionStyle.Default) { (alert: UIAlertAction!) -> Void in
            exit(0)
        }
        
        myAlert.addAction(okAction)
        
        return myAlert
    }
}