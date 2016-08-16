//
//  TabBarViewController.swift
//  Botoo
//
//  Created by 혜인 on 2016. 7. 28..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let connectIdTemp = NSUserDefaults.standardUserDefaults().stringForKey("userConnectId")
        let userId =  NSUserDefaults.standardUserDefaults().stringForKey("userId")
        let loveId = NSUserDefaults.standardUserDefaults().stringForKey("loverId")
        
        if loveId != nil {
            //메세지 개수 로드 (뱃지)
            ChatConstruct().countMessage(userId!, completionHandler: { (json, error) -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    if json != nil && json.count != 0 {
                        self.tabBar.items![1].badgeValue = String(json.count)
                    } else {
                        self.tabBar.items![1].badgeValue = nil
                    }
                }
            })
        }
        
        if connectIdTemp != nil && userId != nil {
            //편지 개수 로드 (뱃지)
            LetterConstruct().callLetter(connectIdTemp!,
                                         completionHandler: { (json, error) -> Void in
                                            
                                            if json == nil || json.count == 0 {
                                                
                                            } else {
                                                let JsonData = json as! [[String: AnyObject]]
                                                var isReadCount = 0
                                                
                                                for data in JsonData {
                                                    if(Int(data["isRead"] as! String) == 0 && userId != data["senderId"] as! String){
                                                        isReadCount += 1
                                                    }
                                                }
                                                
                                                dispatch_async(dispatch_get_main_queue()) {
                                                    if (isReadCount==0){
                                                        self.tabBar.items![2].badgeValue = nil
                                                    } else {
                                                        self.tabBar.items![2].badgeValue = String(isReadCount)
                                                    }
                                                }
                                            }
            })
        }
    }
    
}
