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
    
    var gender:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func genderSelect(sender: AnyObject) {
        
        if (genderSegment.selectedSegmentIndex == 0){
            gender = 0
        }
        if (genderSegment.selectedSegmentIndex == 1){
            gender = 1
        }
    }
    
    @IBAction func registerButtonTapped(sender: AnyObject) {
        
        let userEmail = userEmailTextField.text
        let userName = userNameTextField.text
        let userPW = userPWTextField.text
        let PWrepeat = PWrepeatTextField.text
        
        // Check for Empty Fields
    
        if (userEmail!.isEmpty || userName!.isEmpty || userPW!.isEmpty || PWrepeat!.isEmpty){
            
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
        
        
        
        // Store data for 자동로그인
        
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
