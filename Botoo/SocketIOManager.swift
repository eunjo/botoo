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
    
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://52.42.42.59:3000")!)
    
    // connecting
    func establishConnection() {
        socket.connect()
    }
    
    // disconnecting
    func closeConnection() {
        socket.disconnect()
    }
    
    // 대망의 메세지 보내기
    func sendMessage(message: String, withNickname nickname: String) {
        socket.emit("chatMessage", nickname, message)
    }
    
    // 대망의 메세지 받기
    func getChatMessage(completionHandler: (messageInfo: [String: AnyObject]) -> Void) {
        socket.on("newChatMessage") { (dataArray, socketAck) -> Void in
            var messageDictionary = [String: AnyObject]()
            messageDictionary["nickname"] = dataArray[0] as! String //센더
            messageDictionary["message"] = dataArray[1] as! String //내용
            messageDictionary["date"] = dataArray[2] as! String //시간
            
            completionHandler(messageInfo: messageDictionary)
        }
    }
    
    // 유저 네임 서버에 보내기 // 유저 연결 Online
    func connectToServerWithNickname(nickname: String, completionHandler: (userList: [[String: AnyObject]]!) -> Void) {
        socket.emit("connectUser", nickname)
        
        //유저 리스트 반환
        socket.on("userList") { ( dataArray, ack) -> Void in
            completionHandler(userList: dataArray[0] as! [[String: AnyObject]])
        }
    }
    
    // 유저 연결 끊기 Offline
    func exitChatWithNickname(nickname: String, completionHandler: () -> Void) {
        socket.emit("exitUser", nickname)
        completionHandler()
    }
}