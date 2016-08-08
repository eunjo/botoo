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
    
    @IBOutlet weak var num1: UIImageView!
    @IBOutlet weak var num2: UIImageView!
    @IBOutlet weak var num3: UIImageView!
    @IBOutlet weak var num4: UIImageView!
    
    
    let backView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
    var progressView:ProgressView?
    
    let isLock = NSUserDefaults.standardUserDefaults().boolForKey("lock")
    
    var threadIsAlive = 0
    
    var userEmail:String?
    
    var userEmailStored:String?
    var userProPicStored:String?
    var connectId:String?
    
    var loverEmailStored:String?
    var loverNameStored:String?
    var loverGenderStored:String?
    var loverMsgStored:String?
    var loverProPicStored:String?
    var alert:String?
    
    var firstDateStored:String?
    
    var isGot:Bool?
    
    struct getUserInfo {
        static var userInfo = UserInfo()
        static var checkLock = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //circle image view 적용
        self.myProPic.layer.cornerRadius = self.myProPic.frame.size.width / 2
        self.myProPic.clipsToBounds = true
        self.loverProPic.layer.cornerRadius = self.loverProPic.frame.size.width / 2
        self.loverProPic.clipsToBounds = true
        
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
        
        initProgress()
        initProfile()
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
    
    func initProfile() {
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        
        if (isUserLoggedIn) {
            
            userEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
            MemberConstruct().checkEmail(userEmail!, completionHandler: { (json, error) -> Void in
                if json != nil {
                    self.firstDateStored = json["date"] as? String
                    self.userProPicStored = json["proPic"] as? String
                    self.loverEmailStored = json["lover"] as? String
                    self.connectId = json["connect_id"] as? String
                    self.isGot = true
                    
                    if self.loverEmailStored != nil {
                        self.getLover()
                    } else {
                        dispatch_async(dispatch_get_main_queue()) {
                            self.loverProPic.image = UIImage(named: "tp_default_grey.png")
                            self.loverUserName.text = "연결하러 가기"
                            self.loverStateMsg.text = ""
                        }
                    }
                    
                    self.alert = json["alert"] as? String
                    
                    if  self.alert != nil {
                        self.alert2()
                    }
                    
                    
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
                    NSUserDefaults.standardUserDefaults().setObject(json["name"] as? String, forKey: "userName")
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        // 내 프사 로드
                        if (self.userProPicStored == nil){
                            if (json["gender"] as? String == "1") {
                                self.myProPic.image = UIImage(named: "tp_default_female.png")
                            }
                            else {
                                self.myProPic.image = UIImage(named: "tp_default_male.png")
                            }
                        } else {
                            let dataDecoded:NSData = NSData(base64EncodedString: (json["image_base64String"] as? String)!, options: NSDataBase64DecodingOptions(rawValue: 0))!
                            let decodedimage:UIImage = UIImage(data: dataDecoded)!
                            
                            self.myProPic.image = decodedimage
                        }
                        
                        // 내 이름 로드
                        self.myUserName.text = json["name"] as? String
                        
                        // 내 상메 로드
                        self.myStateMsg.text = json["msg"] as? String
                        self.myStateMsg.numberOfLines = 3;
                        
                        self.progressView?.removeFromSuperview()
                        self.backView.removeFromSuperview()
                        self.progressView = nil
                    }
                }
            })
        }
    }
    
    func initProgress() {
        self.progressView = ProgressView(frame: CGRect(x: self.view.frame.width/2 - 60.0, y: self.view.frame.height/2 - 60.0, width: 120.0, height: 120.0))
        self.progressView!.animateProgressView()
        self.backView.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
        
        self.backView.addSubview(progressView!)
        self.view.addSubview(backView)
    }
    
    func getLover() {
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
        // 상대방 로드
        if (loverProPicStored == nil) {
            if (loverGenderStored == "1") {
                loverProPic.image = UIImage(named: "tp_default_female.png")
            }
            else {
                loverProPic.image = UIImage(named: "tp_default_male.png")
            }
        }
            loverUserName.text = loverNameStored
            loverStateMsg.text = loverMsgStored
        
        // 일수 계산
        if ((firstDateStored != "") && (firstDateStored != nil)){
            
            let currentDate = NSDate()
            let dateFormatter = NSDateFormatter()
            
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let firstDate = dateFormatter.dateFromString(firstDateStored!)
            
            
            // 날짜 년 월 일 로 포맷변환
            let cal = NSCalendar(calendarIdentifier:NSGregorianCalendar)!
            let comp = cal.components([.Year, .Month, .Day], fromDate:firstDate!)
            
            let dateString :String = "\(comp.year)년 \(comp.month)월 \(comp.day)일부터"
            //
        
            fromDate.text = ""
            
            // 날짜 계산
            
            let calendar = NSCalendar.currentCalendar()
            
            let components = calendar.components([.Day], fromDate: firstDate!, toDate: currentDate, options: [])
            //dateLabel.text = "\(components.day+1)일째"
            dateLabel.text = ""
            
            let date_num:Int = components.day+1
            let thousand:Int = date_num/1000
            let hundred:Int = (date_num-(thousand*1000))/100
            let ten:Int = (date_num-(thousand*1000)-(hundred*100))/10
            let one:Int = date_num-(thousand*1000)-(hundred*100)-(ten*10)
            
            num1.image = UIImage(named: "\(thousand).png")
            num2.image = UIImage(named: "\(hundred).png")
            num3.image = UIImage(named: "\(ten).png")
            num4.image = UIImage(named: "\(one).png")
            
            if (date_num < 1000) {
                num1.image = nil
            }
            if (date_num < 100){
                num2.image = nil
            }
            if (date_num < 10){
                num3.image = nil
            }


        } else {
            fromDate.text = ""
            dateLabel.text = ""
        }
    }
    
    func alert2() {
        
        let alert=UIAlertController(title: "연결 신청", message: "수락하시겠습니까?", preferredStyle: .ActionSheet);
        
        alert.addAction(UIAlertAction(title: "네", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            //thread
            let myEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
            
            MemberConstruct().connect(myEmail!, loverEmail: self.alert!, completionHandler: { (json, error) -> Void in
                NSUserDefaults.standardUserDefaults().setObject(self.alert, forKey: "userLover")
            })

        
            MemberConstruct().acceptAlert(myEmail!, loverEmail: self.loverEmailStored!, completionHandler: { (json, error) -> Void in
              //  print(json)
            })
            
        }))
        
        alert.addAction(UIAlertAction(title: "아니오", style: UIAlertActionStyle.Cancel, handler: { (action)-> Void in
            
        let myEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
            
            MemberConstruct().acceptAlert(myEmail!, loverEmail:self.alert!, completionHandler: { (json, error) -> Void in
            })
        }))
        self.presentViewController(alert, animated: true, completion: nil);
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
            _ = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
            
            
        }
        
        profileInit()
        
    }
}