//
//  LockViewController.swift
//  Botoo
//
//  Created by 혜인 on 2016. 6. 29..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class LockViewController: UIViewController {
    
    var pass_bts = [UIImageView]()
    var number_bts = [UIButton]()
    
    let mainColor = UIColor(red: 252.0/255, green: 228.0/255, blue: 236.0/255, alpha: 1)
    var count = 0
    var enteredPw = ""
    let lockPw = NSUserDefaults.standardUserDefaults().stringForKey("lockPw")
    
    struct getSender {
        static var sender = 0
        
        // 0 - Home, 1 - LockSet, 2 - ChangeLockPw
    }
    @IBOutlet var lock_v_root: UIView!
    
    override func viewDidLoad(){
        setBtList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setBtList() {
        for i in 100..<104 {
            let current_bt = lock_v_root.viewWithTag(i) as! UIImageView
            current_bt.layer.cornerRadius = current_bt.frame.size.width / 2
            current_bt.clipsToBounds = true
            current_bt.layer.borderWidth = 1
            current_bt.layer.borderColor = mainColor.CGColor
            
            self.pass_bts.append(current_bt)
        }
        
        for i in 1..<12 {
            let current_bt = lock_v_root.viewWithTag(i) as! UIButton
            current_bt.layer.cornerRadius = current_bt.frame.size.width / 2
            current_bt.clipsToBounds = true
            current_bt.layer.borderWidth = 2
            current_bt.layer.borderColor = UIColor.whiteColor().CGColor
            
            current_bt.addTarget(self, action: #selector(LockViewController.onClickBt(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.number_bts.append(current_bt)
        }
    }
    
    func onClickBt(sender: UIButton) {
        let selectedNum = sender.tag
        
        if (selectedNum < 11) {
            enteredPw = enteredPw + "\(selectedNum)"
        }
        
        pass_bts[count].backgroundColor = UIColor.whiteColor()
        if count < 4 {
            count += 1
            
            if (count == 4) {
                count = 0
                if(getSender.sender == 2) {
                    changePw(enteredPw)
                } else {
                    checkPw(enteredPw)
                    enteredPw = ""
                }
            }
        }
    }
    
    func changePw(enteredPw: String) {
        HomeViewController.getUserInfo.userInfo.lockPw = enteredPw
        NSUserDefaults.standardUserDefaults().setObject(enteredPw, forKey: "lockPw")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func checkPw(enteredPw: String) {
        if (enteredPw == lockPw) {
            if (getSender.sender == 0) {
                HomeViewController.getUserInfo.checkLock = false
            } else if (getSender.sender == 1) {
                LockSetViewController.getCheckLock.checkLock = false
            }
            
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            for i in 0..<4 {
                pass_bts[i].backgroundColor = UIColor.clearColor()
            }
        }
    }
}
