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
    let generalOkAction = UIAlertAction(title:"확인", style:UIAlertActionStyle.Default, handler:nil)
    
    var threadIsAlive = 0
    
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
        
        var isAlreadyExists:Bool = false
        
        // Check for Empty Fields
    
        if (userEmail!.isEmpty || userName!.isEmpty || userPW!.isEmpty || PWrepeat!.isEmpty || gender==nil){
            
            // Display alert message
            displayRegisterAlert("All fields are required", okAction: generalOkAction)
            return
        }
        
        // Check if password match
        
        if (userPW != PWrepeat) {
            
            // Display alert message
            displayRegisterAlert("Passwords do not match", okAction: generalOkAction)
            return
        }
        
        
        // Email 중복검사
        MemberConstruct().checkEmail(userEmail!, completionHandler: { (json, error) -> Void in
            print("email 중복검사 :: \(json)")
            if json != nil {
                isAlreadyExists = true
            
                // UI 작업
                dispatch_async(dispatch_get_main_queue()) {
                    self.displayRegisterAlert("이미 가입된 이메일 주소입니다", okAction: self.generalOkAction)
                }
            }
            self.threadIsAlive = 1
        })
        
        if (isAlreadyExists){
            self.threadIsAlive = 1
            return
        }
        
        while (threadIsAlive == 0) {}
 
        let loginParams = [
            "email": userEmail! as String,
            "pw": userPW! as String,
            "name": userName! as String,
            "gender": gender! as String
        ]
        
        if (isAlreadyExists != true){
            MemberConstruct().register(loginParams, completionHandler: { (json, error) -> Void in
                print("가입 정보가 잘들어갔어욤 :: \(json)")
                dispatch_async(dispatch_get_main_queue()) {
                    self.displayRegisterAlert("가입되었습니다.",
                        okAction: UIAlertAction(title:"OK", style:UIAlertActionStyle.Default) { action in
                            self.dismissViewControllerAnimated(true, completion: nil)
                        })
                }
            })
        }

    }
    
    
    func displayRegisterAlert(userMessage: String, okAction: UIAlertAction){
        let myAlert = UIAlertController(title:"알림", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = okAction
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    
    //빈 공간 클릭 시 키보드 하이드
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
