//
//  RegisterPageViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 6. 28..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPWTextField: UITextField!
    @IBOutlet weak var PWrepeatTextField: UITextField!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    
    var gender:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        genderSegment.selectedSegmentIndex = 0
    }

    @IBAction func genderSelect(sender: AnyObject) {
        
        if (genderSegment.selectedSegmentIndex == 0){
            gender = "0"
        }
        if (genderSegment.selectedSegmentIndex == 1){
            gender = "1"
        }
    }
    
    @IBAction func onClickHaveAcc(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func registerButtonTapped(sender: AnyObject) {
        
        let userEmail = userEmailTextField.text
        let userName = userNameTextField.text
        let userPW = userPWTextField.text
        let PWrepeat = PWrepeatTextField.text
        
        var isAlreadyExists:Bool?
        
        // Check for Empty Fields
    
        if (userEmail!.isEmpty || userName!.isEmpty || userPW!.isEmpty || PWrepeat!.isEmpty || gender==nil){
            
            // Display alert message
            displayRegisterAlert("All fields are required")
            return
        }
        
        // Check if password match
        
        if (userPW != PWrepeat) {
            
            // Display alert message
            displayRegisterAlert("Passwords do not match")
            return
        }
        

        
        // URL Info 객체 생성
        var urlInfoForRegister:URLInfo = URLInfo()

        // Email 중복검사

        urlInfoForRegister.test = urlInfoForRegister.WEB_SERVER_IP+"/checkEmail?email="+userEmail!
        TestConstruct().testConnect(urlInfoForRegister, httpMethod: "GET", params: nil, completionHandler: { (json, error) -> Void in
            print("email 중복검사 :: \(json)")
            isAlreadyExists = true
            print(isAlreadyExists)
        })
        /*
        while(isAlreadyExists==nil){
        }
        */
        
        sleep(1)
        print("if문 전")
        if (isAlreadyExists==true){
            print("if문 진입")
            displayRegisterAlert("이미 가입된 이메일 주소입니다")
            return
        }
        print("if문 후")
 
        
        
        

        // Store data
        urlInfoForRegister.test = urlInfoForRegister.WEB_SERVER_IP+"/member"
        
        let loginParams = [
            "email": userEmail! as String,
            "pw": userPW! as String,
            "name": userName! as String,
            "gender": gender! as String
        ]
        
        TestConstruct().testConnect(urlInfoForRegister, httpMethod: "POST", params: loginParams as! Dictionary<String,String>, completionHandler: { (json, error) -> Void in
            print("가입 정보가 잘들어갔어욤 :: \(json)")
            
            
        })
        
        
        NSUserDefaults.standardUserDefaults().setObject(gender, forKey: "gender")
        NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail")
        NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "userName")
        NSUserDefaults.standardUserDefaults().setObject(userPW, forKey: "userPW")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        // Display alert message with confirmation
        let myAlert = UIAlertController(title:"Alert", message: "Registration is successful", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.Default){ action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
        
    }
    
    
    func displayRegisterAlert(userMessage: String){
        
        var myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.Default, handler:nil)
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
        
        
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
