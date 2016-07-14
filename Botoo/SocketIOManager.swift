//
//  SocketIOManager.swift
//  Botoo
//
//  Created by 이은조 on 2016. 7. 14..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class SocketIOManager: NSObject {
    
    static let sharedInstance = SocketIOManager()
    
    override init() {
        super.init()
    }
    
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://ec2-52-42-42-59.us-west-2.compute.amazonaws.com")!)
    
    /*
    Socket connect establish/ disconnect
 
    func establishConnection() {
        socket.connect()
        print("connected successfully")
    }
    
    
    func closeConnection() {
        socket.disconnect()
    }
     */
    
    /*
    func applicationDidBecomeActive(application: UIApplication) {
        SocketIOManager.sharedInstance.establishConnection()
    }
    */
    
    /*
    
    func applicationDidEnterBackground(application: UIApplication) {
        SocketIOManager.sharedInstance.closeConnection()
    }
    */
    

}
