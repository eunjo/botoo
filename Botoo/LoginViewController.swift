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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userEmailTextField.becomeFirstResponder()
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        let userEmail = userEmailTextField.text
        let userPW = userPWTextField.text
        
        var userEmailStored:String?
        var userPWStored:String?
        
        
        var isAlreadyExists:Bool?
        // URL Info 객체 생성
        var urlInfoForRegister:URLInfo = URLInfo()
        
        // Email 중복검사
        
        urlInfoForRegister.test = urlInfoForRegister.WEB_SERVER_IP+"/checkEmail?email="+userEmail!
        TestConstruct().testConnect(urlInfoForRegister, httpMethod: "GET", params: nil, completionHandler: { (json, error) -> Void in
            userEmailStored = String(json["email"])
            userPWStored = String(json["pw"])
            print(userEmailStored!)
            print(userPWStored!)
            isAlreadyExists = true
            print(isAlreadyExists)
        })
        
        sleep(1)
        print("if문 전")
        if (isAlreadyExists==true){
            print("if문 진입")
            
            if (userEmailStored! == "Optional("+userEmail!+")"){
                if (userPWStored! == "Optional("+userPW!+")"){
                    
                    // Log in is successful
                    print("if문 비교 성공")
                    
                    NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail")

                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }

            
        }
        print("if문 후")
        
        print("등록안된 이메일일때")
        var myAlert = UIAlertController(title:"Alert", message: "등록되지 않은 계정이거나 비밀번호가 틀립니다", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.Default, handler:nil)
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        return
        
        

    }
    
    //빈 공간 클릭 시 키보드 하이드
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
