//
//  albumViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 7. 4..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class albumViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let messageList = FileManager.sharedInstance.readFile()
        
        if messageList == [] { return }
        
        dispatch_async(dispatch_get_main_queue()) {
//            var startCount = 0
//            var endCount = startCount+10
//            
//            var messageListTemp = messageList //10개 씩 읽어오기
            
//            if endCount < messageList.count {
//                messageListTemp = Array(messageList[startCount ..< endCount]) //10개 씩 읽어오기
//            }
            
            for var message in messageList {
                if message != "" {
                    message.removeAtIndex(message.endIndex.predecessor())
                    
                    let result = self.convertStringToDictionary(message)
                    print(result!["type"] as! String)
                    
                    if result!["type"] as! String == "pic" {
                        print("pic message")
                    }
                }
            }
            
//            startCount = startCount + 10
            
            //            while startCount < messageList.count - 10 {
            //                let messageListTemp = Array(messageList[startCount ..< startCount+10]) //10개 씩 읽어오기
            //
            //                for var message in messageListTemp {
            //                    if message != "" {
            //                        message.removeAtIndex(message.endIndex.predecessor())
            //
            //                        let result = self.convertStringToDictionary(message)
            //                        if result!["type"] as! String == "pic" {
            //                            print("pic message")
            //                        }
            //                    }
            //                }
            //                
            //                startCount = startCount + 10
            //            }
        }

    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
}
