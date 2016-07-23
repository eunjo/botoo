//
//  LetterProtocol.swift
//  Botoo
//
//  Created by 혜인 on 2016. 7. 23..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import Foundation

protocol LetterProtocol {
    
    func writeLetter(letterInfo: Dictionary<String,String>?, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask?
    func callLetter(connectID: String,completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask?
    func deleteLetter(connectID: String,letterID:String,completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask?
    func updateLetter(connectID: String, letterID: String, isRead: String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask?
}