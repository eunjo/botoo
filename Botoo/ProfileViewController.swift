//
//  profileViewController.swift
//  Botoo
//
//  Created by 혜인 on 2016. 6. 29..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit


class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var profile_v_profile: UIView!
    @IBOutlet var profile_lb_email: UILabel!
    @IBOutlet var profile_lb_msg: UILabel!
    @IBOutlet var profile_lb_name: UILabel!
    @IBOutlet var profile_bt_profile: UIButton!
    @IBOutlet var profile_v_secondCenterY: UIView!
    @IBOutlet var profile_v_firstCenterY: UIView!
    @IBOutlet var profile_iv_profile: UIImageView!
    
    private var lineViews = [UIView]()
    private let tapGesture = UITapGestureRecognizer()
    private var userGender: String?
    
    var userEmailStored:String?
    var userGenderStored:String?
    var userNameStored:String?
    
    var isGot:Bool?
    
    var userEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")!
    var threadIsAlive = 0
    
    override func viewDidLoad(){
        setViewBorder()
        //circle image view 적용
        self.profile_iv_profile.layer.cornerRadius = self.profile_iv_profile.frame.size.width / 2
        self.profile_iv_profile.clipsToBounds = true
        
        // 상메 수정용
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.gotoMsgEdit(_:)))
        profile_lb_msg.userInteractionEnabled = true
        profile_lb_msg.addGestureRecognizer(tap)
        
        let tap_2 = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.gotoNameEdit(_:)))
        profile_lb_name.userInteractionEnabled = true
        profile_lb_name.addGestureRecognizer(tap_2)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        MemberConstruct().checkEmail(userEmail, completionHandler: { (json, error) -> Void in

            self.userEmailStored = json["email"] as? String
            self.userGenderStored = json["gender"] as? String
            self.userNameStored = json["name"] as? String
            
            self.isGot = true
            
        })
        
        while(isGot==nil){
            
        }
        
        initProfile()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initProfile() {
        profile_lb_name.text = userNameStored
        profile_lb_email.text = userEmailStored
        userGender = userGenderStored
        
        /*
        if (HomeViewController.getUserInfo.userInfo.msg != "") {
            profile_lb_msg.text = HomeViewController.getUserInfo.userInfo.msg
        }
        */
        if (NSUserDefaults.standardUserDefaults().stringForKey("stateMSG") != "") {
            profile_lb_msg.text = NSUserDefaults.standardUserDefaults().stringForKey("stateMSG")
        }
        
        initProfileImage()
    }
    
    func initProfileImage() {
        if (userGender == "0") {
            self.profile_iv_profile.image = UIImage(named: "default_male")
        } else if (userGender == "1") {
            self.profile_iv_profile.image = UIImage(named: "default_female")
        }
    }
    
    func setViewBorder() {
        let gray = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1)
        profile_v_firstCenterY.layer.borderColor = gray.CGColor
        profile_v_secondCenterY.layer.borderColor = gray.CGColor
        
        lineViews.append(UIView(frame: CGRectMake(0, 0, self.view.frame.width, 0.5)))
        lineViews.append(UIView(frame: CGRectMake(0, profile_v_profile.frame.height, self.view.frame.width, 0.5)))
        lineViews.append(profile_v_firstCenterY)
        lineViews.append(profile_v_secondCenterY)
        
        for i in lineViews {
            i.layer.borderWidth = 0.5
            i.layer.borderColor = gray.CGColor
            self.profile_v_profile.addSubview(i)
        }
    }
    
    @IBAction func onClickProfile(sender: AnyObject) {
        //ActionScheet AlterController 생성
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        //Action 추가
        let firstAction = UIAlertAction(title: "사진 앨범에서 선택", style: .Default) { (alert: UIAlertAction!) -> Void in
            //이미지 피커 컨트롤러 인스턴스 생성
            let picker = UIImagePickerController()
            //사진 라이브러리 소스를 선택
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            //수정 가능 옵션
            picker.allowsEditing = true
            //델리게이트 지정
            picker.delegate = self
            //화면에 표시
            self.presentViewController(picker, animated: false, completion: nil)
        }
        
        let secondAction = UIAlertAction(title: "기본 이미지로 변경", style: .Default) { (alert: UIAlertAction!) -> Void in
            self.initProfileImage()
        }
        
        let thirdAction = UIAlertAction(title: "취소", style: .Cancel) { (alert: UIAlertAction!) -> Void in
            
        }
        
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        alert.addAction(thirdAction)
        
        presentViewController(alert, animated: true, completion:nil)
    }
    
    @IBAction func onClickDrop(sender: UIButton) {
        
        MemberConstruct().drop(NSUserDefaults.standardUserDefaults().stringForKey("userId")!,
                               completionHandler: { (json, error) -> Void in
            self.threadIsAlive = 1
        })
        
        while self.threadIsAlive == 0 {}
        
        print("탈퇴 success")
    }
    
    
    @IBAction func onClickLogout(sender: UIButton) {
        
       //        let homeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController")
//        homeViewController!.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
//        self.parentViewController!.presentViewController(homeViewController!, animated: true, completion: nil)
        
        let myAlert = UIAlertController(title:"Alert", message: "정말 로그아웃 하시겠습니까?", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.Default){ action in
            //Logout 구현
            HomeViewController.getUserInfo.userInfo = UserInfo()
            
            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "gender")
            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "userEmail")
            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "userName")
            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "userPW")
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "lock")
            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "stateMSG")
            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "lockPw")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            self.tabBarController!.selectedIndex = 0
        }
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil) 
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(false) { (_) in
            self.profile_iv_profile.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
    }
    
    
    func gotoMsgEdit(sender:UITapGestureRecognizer){
        
        var viewController: UIViewController?
        
        viewController = self.storyboard?.instantiateViewControllerWithIdentifier("msgEditViewController")
        
        if(viewController != nil) {
            viewController!.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            //navigationController 의 하위 뷰로 전환
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
    }
    
    func gotoNameEdit(sender:UITapGestureRecognizer){
        
        var viewController: UIViewController?
        
        viewController = self.storyboard?.instantiateViewControllerWithIdentifier("nameEditViewController")
        
        if(viewController != nil) {
            viewController!.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            //navigationController 의 하위 뷰로 전환
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
    }
    
    
}
