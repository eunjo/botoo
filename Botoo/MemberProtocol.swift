//
//  TestProtocol.swift
//  Botoo
//
//  Created by 혜인 on 2016. 7. 11..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import Foundation

protocol MemberProtocol {
    
    func setOnline(userId: String, isOnline: Bool, completionHandler: (AnyObject!, NSError?) -> Void)-> NSURLSessionTask?
    func checkEmail(userEmail: String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask?
    func register(userInfo: Dictionary<String,String>?, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask?
    func drop(userId: String, loverEmail: String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask?
    func changeName(userID: String, userName: String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask?
    func changeMsg(userID: String, userMsg: String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask?
    func updateDate(userID: String, loverID: String, userDate: String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask?
    func sendAlert(myEmail: String, loverEmail: String, completionHandler: (AnyObject!, NSError?) -> Void)-> NSURLSessionTask?
    func acceptAlert(myEmail: String, loverEmail: String, completionHandler: (AnyObject!, NSError?) -> Void)-> NSURLSessionTask?
    func setProPicDefault(myEmail: String, completionHandler: (AnyObject!, NSError?) -> Void)-> NSURLSessionTask?
     
}