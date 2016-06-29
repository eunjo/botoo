//
//  ViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 6. 27..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
    let isLock = NSUserDefaults.standardUserDefaults().boolForKey("lock")
    
    struct getUserInfo {
        static var userInfo = UserInfo()
        static var checkLock = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 무한 루프 방지
        getUserInfo.checkLock = isLock
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        
        if (!isUserLoggedIn) {
            self.performSegueWithIdentifier("toLoginView", sender: self)
        } else {
            if isLock && getUserInfo.checkLock {
                LockViewController.getSender.sender = 0
                self.performSegueWithIdentifier("toLockView", sender: self)
            }
            
            let userEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
            let userName = NSUserDefaults.standardUserDefaults().stringForKey("userName")
            let usergender = NSUserDefaults.standardUserDefaults().integerForKey("gender")
            
            /** 
                    서버 연결 후 수정
            **/
            
            getUserInfo.userInfo = UserInfo(memberId: "0", ver: (NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString")?.description)!, email: userEmail!, name: userName!, gender: usergender, regId: "", msg: "", image: "", lover: "", lock: false)
        }
    }

}

