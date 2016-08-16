//
//  ChatProtocol.swift
//  Botoo
//
//  Created by 혜인 on 2016. 8. 11..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import Foundation

protocol ChatProtocol {
    
    func saveMessage(messageInfo: Dictionary<String,String>?, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask?
    func getMessage(senderId: String, userId: String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask?
    func countMessage(userId: String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask?
}