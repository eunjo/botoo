//
//  LockSetViewController.swift
//  Botoo
//
//  Created by 혜인 on 2016. 6. 29..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class LockSetViewController: UIViewController {

    @IBOutlet var lockSet_sc: UISwitch!
    
    let isLock = NSUserDefaults.standardUserDefaults().boolForKey("lock")
    
    struct getCheckLock {
        static var checkLock = false
    }
    
    override func viewDidLoad(){
        //switch init
        lockSet_sc.setOn( NSUserDefaults.standardUserDefaults().boolForKey("lock"), animated: false)
        getCheckLock.checkLock = isLock
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        if (isLock && getCheckLock.checkLock) {
            LockViewController.getSender.sender = 1
            self.performSegueWithIdentifier("toLockView", sender: self)
        }
    }
    @IBAction func onClickChangePw(sender: UIButton) {
        LockViewController.getSender.sender = 2
        self.performSegueWithIdentifier("toLockView", sender: self)
    }
    
    @IBAction func setLockOnOff(sender: UISwitch) {
        if sender.on {
            HomeViewController.getUserInfo.userInfo.lock = true
            NSUserDefaults.standardUserDefaults().setObject(true, forKey: "lock")
            
            if (NSUserDefaults.standardUserDefaults().stringForKey("lockPw")==nil){
                LockViewController.getSender.sender = 2
                self.performSegueWithIdentifier("toLockView", sender: self)
            }
        } else {
            HomeViewController.getUserInfo.userInfo.lock = false
            NSUserDefaults.standardUserDefaults().setObject(false, forKey: "lock")
        }
        
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
