//
//  LoginViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 6. 28..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, KeyboardProtocol {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPWTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userEmailTextField.becomeFirstResponder()
        //키보드에 대한 노티피케이션 생성
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
    }

    func keyboardWillHide(notification: NSNotification) {
    }
    
    func keyboardWillShow(notification: NSNotification) {
        adjustingHeight(true, notification: notification)
    }
    
    func adjustingHeight(show: Bool, notification: NSNotification) {
        // 1 노티피케이션 정보 얻기
        var userInfo = notification.userInfo!
        // 2 키보드 사이즈 얻기
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        NSUserDefaults.standardUserDefaults().setObject(keyboardFrame.height, forKey: "keyboardFrame")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        let userEmail = userEmailTextField.text
        let userPW = userPWTextField.text
        
        let userEmailStored = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
        let userPWStored = NSUserDefaults.standardUserDefaults().stringForKey("userPW")
        
        if (userEmailStored == userEmail){
            
            if (userPWStored == userPW){
                
                // Log in is successful
                
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
                NSUserDefaults.standardUserDefaults().synchronize()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
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
