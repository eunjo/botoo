//
//  ViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 6. 27..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    struct getUserInfo {
        static var userInfo = UserInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        
        let userEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
        let userName = NSUserDefaults.standardUserDefaults().stringForKey("userName")
        
        if (!isUserLoggedIn) {
            self.performSegueWithIdentifier("toLoginView", sender: self)
        } else {
            /** 
                    서버 연결 후 수정
            **/
            getUserInfo.userInfo = UserInfo(memberId: "0", ver: (NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString")?.description)!, email: userEmail!, name: userName!, gender: 0, regId: "", msg: "", image: "", lover: "")
        }
    }

}

