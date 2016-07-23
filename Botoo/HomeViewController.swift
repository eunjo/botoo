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
    @IBOutlet weak var myStateMsg: UILabel!
    
    @IBOutlet var loverProPic: UIImageView!
    @IBOutlet var loverUserName: UILabel!
    @IBOutlet weak var loverStateMsg: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var fromDate: UILabel!
    
    let isLock = NSUserDefaults.standardUserDefaults().boolForKey("lock")
    
    var threadIsAlive = 0
    
    var userEmail:String?
    
    var userEmailStored:String?
    var userNameStored:String?
    var userGenderStored:String?
    var userMsgStored:String?
    var userProPicStored:String?
    var connectId:String?
    
    var loverEmailStored:String?
    var loverNameStored:String?
    var loverGenderStored:String?
    var loverMsgStored:String?
    var loverProPicStored:String?
    
    var firstDateStored:String?
    
    var isGot:Bool?
    
    struct getUserInfo {
        static var userInfo = UserInfo()
        static var checkLock = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
        
        // add tap Gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.onClickLoverPic(_:)))
        loverProPic.userInteractionEnabled = true
        loverProPic.addGestureRecognizer(tap)
        
        let tap_2 = UITapGestureRecognizer(target:self, action: #selector(HomeViewController.onClickMyPic(_:)))
        myProPic.userInteractionEnabled = true
        myProPic.addGestureRecognizer(tap_2)
        
        // 무한 루프 방지
        getUserInfo.checkLock = isLock
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        
        if (isUserLoggedIn) {
            
            userEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
            MemberConstruct().checkEmail(userEmail!, completionHandler: { (json, error) -> Void in
                if json != nil {
                    self.userNameStored = json["name"] as? String
                    self.userGenderStored = json["gender"] as? String
                    self.firstDateStored = json["date"] as? String
                    self.userMsgStored = json["msg"] as? String
                    self.userProPicStored = json["proPic"] as? String
                    self.loverEmailStored = json["lover"] as? String
                    self.connectId = json["connect_id"] as? String
                    self.isGot = true
                    
                    var loverTemp = "nil"
                    if json["lover"] as? String != nil {
                        loverTemp = json["lover"] as! String
                    }
                    
                    var connectIdTemp = "nil"
                    if json["connect_id"] as? String != nil {
                        connectIdTemp = json["connect_id"] as! String
                    }
                    
                    var proPicTemp = "nil"
                    if json["proPic"] as? String != nil {
                        proPicTemp = json["proPic"] as! String
                    }
                    
                    NSUserDefaults.standardUserDefaults().setObject(loverTemp, forKey: "userLover")
                    NSUserDefaults.standardUserDefaults().setObject(connectIdTemp, forKey: "userConnectId")
                    NSUserDefaults.standardUserDefaults().setObject(proPicTemp, forKey: "userProfile")
                    NSUserDefaults.standardUserDefaults().setObject(json["_id"] as? String, forKey: "userId")
                }
                
                self.threadIsAlive = 1
            })
            
            while self.threadIsAlive == 0 {}
            
            if loverEmailStored != nil {
                MemberConstruct().checkEmail(loverEmailStored!, completionHandler: { (json, error) -> Void in
                    if json != nil {
                        self.loverNameStored = json["name"] as? String
                        self.loverGenderStored = json["gender"] as? String
                        self.loverMsgStored = json["msg"] as? String
                        self.loverProPicStored = json["proPic"] as? String
                        
                        NSUserDefaults.standardUserDefaults().setObject(self.loverNameStored, forKey: "loverName")
                        
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            self.profileInit()
                        }
                    }
                })

            }
        }
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "myPicZoom") {
            let svc = segue.destinationViewController as! imageZoomViewController
            svc.newImage = myProPic.image
        }
        else if (segue.identifier == "loverPicZoom"){
            let svc = segue.destinationViewController as! imageZoomViewController
            svc.newImage = loverProPic.image
        }
    }

    
    func onClickLoverPic(sender:UITapGestureRecognizer) {
        if (loverEmailStored == nil) {
            if let connectingViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ConnectingViewController") {
                connectingViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
                self.presentViewController(connectingViewController, animated: true, completion: nil)
            }
        } else {
            
            self.performSegueWithIdentifier("loverPicZoom", sender: self.loverProPic)
            
            if let connectingViewController = self.storyboard?.instantiateViewControllerWithIdentifier("imageZoomViewController") {
                connectingViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
                self.presentViewController(connectingViewController, animated: true, completion: nil)
            }
            
        }
    }
    
    func onClickMyPic(sender:UITapGestureRecognizer){
        
        self.performSegueWithIdentifier("myPicZoom", sender: self.myProPic)
        
        if let connectingViewController = self.storyboard?.instantiateViewControllerWithIdentifier("imageZoomViewController") {
            connectingViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            self.presentViewController(connectingViewController, animated: true, completion: nil)
        }
        
    }
    
    func profileInit() {
        //circle image view 적용
        self.myProPic.layer.cornerRadius = self.myProPic.frame.size.width / 2
        self.myProPic.clipsToBounds = true
        self.loverProPic.layer.cornerRadius = self.loverProPic.frame.size.width / 2
        self.loverProPic.clipsToBounds = true
        
        // 내 프사 로드
        
        if (userProPicStored == nil){
            if (userGenderStored == "1") {
                myProPic.image = UIImage(named: "tp_default_female.png")
            }
            else {
                myProPic.image = UIImage(named: "tp_default_male.png")
            }
        }
 
        // 내 이름 로드
        myUserName.text = userNameStored
        
        
        // 내 상메 로드
        myStateMsg.text = userMsgStored
        myStateMsg.numberOfLines = 3;
        
        
        // 상대방 로드
        if (loverEmailStored == nil) {
            
            loverProPic.image = UIImage(named: "tp_default_grey.png")
            loverUserName.text = "연결하러 가기"
            
        } else {
            
            if (loverProPicStored == nil){
            
                if (loverGenderStored == "1") {
                    loverProPic.image = UIImage(named: "tp_default_female.png")
                }
                else {
                    loverProPic.image = UIImage(named: "tp_default_male.png")
                }
            }
            loverUserName.text = loverNameStored
            loverStateMsg.text = loverMsgStored
        }
        
        // 일수 계산
        if ((firstDateStored != "") && (firstDateStored != nil)){
            
            let currentDate = NSDate()
            let dateFormatter = NSDateFormatter()
            
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let firstDate = dateFormatter.dateFromString(firstDateStored!)
            
            
            // 날짜 년 월 일 로 포맷변환
            let cal = NSCalendar(calendarIdentifier:NSGregorianCalendar)!
            let comp = cal.components([.Year, .Month, .Day], fromDate:firstDate!)
            
            let dateToString:String = "\(comp.year)년 \(comp.month)월 \(comp.day)일부터"
            //
        
            fromDate.text = dateToString
            
            // 날짜 계산
            
            let calendar = NSCalendar.currentCalendar()
            
            let components = calendar.components([.Day], fromDate: firstDate!, toDate: currentDate, options: [])
            dateLabel.text = "\(components.day+1)일째"
            

        } else {
            fromDate.text = "며칠부터"
            dateLabel.text = "며칠째인가요?"
        }
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
            
            
        }
        
        profileInit()
        
    }

}

