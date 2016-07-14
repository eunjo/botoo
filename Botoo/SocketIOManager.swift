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
    
    // connecting
    func establishConnection() {
        socket.connect()
        print("connected successfully")
    }
    
    // disconnecting
    func closeConnection() {
        socket.disconnect()
    }

    // app 활성화시 connect
    func applicationDidBecomeActive(application: UIApplication) {
        SocketIOManager.sharedInstance.establishConnection()
    }
    
    
    // app 비활성화시 disconnect
    func applicationDidEnterBackground(application: UIApplication) {
        SocketIOManager.sharedInstance.closeConnection()
    }
    
    

}
