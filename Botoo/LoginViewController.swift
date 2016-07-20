//
//  LoginViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 6. 28..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPWTextField: UITextField!
    
    var threadIsAlive = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userEmailTextField.becomeFirstResponder()
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        let userEmail = userEmailTextField.text
        let userPW = userPWTextField.text
        
        var userEmailStored:String?
        var userPWStored:String?
        var userNameStored:String?
        var userIdStored: String?
        var userLoverStored: String?
        var userConnectId: String?
        
        var isAlreadyExists:Bool = false
        
        MemberConstruct().checkEmail(userEmail!, completionHandler: { (json, error) -> Void in
            if json != nil {
                userEmailStored = json["email"] as? String
                userPWStored = json["pw"] as? String
                userNameStored = json["name"] as? String
                userIdStored = json["_id"] as? String

                if json["lover"] as? String == nil {
                    userLoverStored = "nil"
                } else {
                    userLoverStored = json["lover"] as? String
                }
                
                if json["connect_id"] as? String == nil {
                    userConnectId = "nil"
                } else {
                    userConnectId = json["connect_id"] as? String
                }

            
                isAlreadyExists = true
            
                // UI 작업
                dispatch_async(dispatch_get_main_queue()) {
                
                    // 여기까지 왔다는 것 == 이메일이 존재함.
                    if (userPWStored! == userPW!) {
                        // Log in is successful
                        
                        
                        NSUserDefaults.standardUserDefaults().setObject(userEmailStored, forKey: "userEmail")
                        NSUserDefaults.standardUserDefaults().setObject(userIdStored, forKey: "userId")
                        NSUserDefaults.standardUserDefaults().setObject(userNameStored, forKey: "userName")
                        NSUserDefaults.standardUserDefaults().setObject(userLoverStored, forKey: "userLover")
                        NSUserDefaults.standardUserDefaults().setObject(userConnectId, forKey: "userConnectId")
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
                        NSUserDefaults.standardUserDefaults().synchronize()
                    
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                }
            }
            
            self.threadIsAlive = 1
        })
        
        while self.threadIsAlive == 0 {}
        
        if isAlreadyExists == false {
            
            print("등록안된 이메일일때")
            let myAlert = UIAlertController(title:"Alert", message: "등록되지 않은 계정이거나 비밀번호가 틀립니다", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.Default, handler:nil)
            
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
            return
        }
    }
    
    //빈 공간 클릭 시 키보드 하이드
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
