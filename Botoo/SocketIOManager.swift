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
    
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.1.2:3000")!)
    
    // connecting
    func establishConnection() {
        socket.connect()
    }
    
    // disconnecting
    func closeConnection() {
        socket.disconnect()
    }
    
    func sendMessage(message: String) {
        socket.emit("chatMessage", message)
    }
}