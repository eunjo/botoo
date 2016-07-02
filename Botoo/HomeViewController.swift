//
//  ViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 6. 27..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var myProPic: UIImageView!
    @IBOutlet weak var myUserName: UILabel!
    
    @IBOutlet var loverProPic: UIImageView!
    @IBOutlet var loverUserName: UILabel!
    
    let isLock = NSUserDefaults.standardUserDefaults().boolForKey("lock")
    
    struct getUserInfo {
        static var userInfo = UserInfo()
        static var checkLock = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        profileInit()
        
        // add tap Gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.onClickLoverPic(_:)))
        loverProPic.userInteractionEnabled = true
        loverProPic.addGestureRecognizer(tap)
        
        // 무한 루프 방지
        getUserInfo.checkLock = isLock
    }
    
    func onClickLoverPic(sender:UITapGestureRecognizer) {
        if (getUserInfo.userInfo.lover == "" || getUserInfo.userInfo.lover == nil) {
            if let connectingViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ConnectingViewController") {
                connectingViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
                self.presentViewController(connectingViewController, animated: true, completion: nil)
            }
        }
    }
    
    func profileInit() {
        //circle image view 적용
        self.myProPic.layer.cornerRadius = self.myProPic.frame.size.width / 2
        self.myProPic.clipsToBounds = true
        self.loverProPic.layer.cornerRadius = self.loverProPic.frame.size.width / 2
        self.loverProPic.clipsToBounds = true
        
        // 내 프사 로드
        if (NSUserDefaults.standardUserDefaults().integerForKey("gender") == 1) {
            myProPic.image = UIImage(named: "default_female.png")
        }
        else {
            myProPic.image = UIImage(named: "default_male.png")
        }
        // 내 이름 로드
        myUserName.text = NSUserDefaults.standardUserDefaults().stringForKey("userName")
        
        
        // 상대방 로드
        if (getUserInfo.userInfo.lover == "" || getUserInfo.userInfo.lover == nil) {
            loverProPic.image = UIImage(named: "default_no_person.png")
            loverUserName.text = "연결하러 가기"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        
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

