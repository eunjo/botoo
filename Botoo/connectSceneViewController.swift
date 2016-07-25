//
//  connectSceneViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 7. 2..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class connectSceneViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var connectButton: UIButton!
    
    @IBOutlet weak var searchEmailTextField: UITextField!
    @IBOutlet weak var searchResult: UILabel!
    
    var isGot:Bool = false
    
    var loverEmailStored:String?
    var loverGenderStored:String?
    var loverNameStored:String?
    var loversLoverStored:String?
    var connectId:String?
    
    var threadIsAlive = 0
    let generalOkAction = UIAlertAction(title:"확인", style:UIAlertActionStyle.Default, handler:nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    @IBAction func searchButtonTapped(sender: AnyObject) {
        
        let loverEmail = searchEmailTextField.text
        
        if NSUserDefaults.standardUserDefaults().stringForKey("userEmail")==loverEmail{
            
            searchResult.text = "자기 자신입니다"
            connectButton.enabled = false
            return
        } else {
            MemberConstruct().checkEmail(loverEmail!, completionHandler: { (json, error) -> Void in
                if json != nil {
                    self.isGot = true
                    
                    self.loverEmailStored = json["email"] as? String
                    self.loverNameStored = json["name"] as? String
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.searchResult.text = self.loverNameStored
                        self.connectButton.enabled = true
                    }
                } else {
                    dispatch_async(dispatch_get_main_queue()) {
                        print("등록안된 이메일일때")
                        self.searchResult.text = "존재하지 않는 사용자입니다"
                        self.connectButton.enabled = false
                        return
                    }
                }
            })
        }
    }
    
    var isAlreadyConnected:Bool = false
    
    @IBAction func connectButtonTapped(sender: AnyObject) {
        
        let loverEmail = searchEmailTextField.text
        
        MemberConstruct().checkEmail(loverEmail!, completionHandler: { (json, error) -> Void in
            if json != nil {

                self.loverEmailStored = json["email"] as? String
                self.loverNameStored = json["name"] as? String
                self.loversLoverStored = json["lover"] as? String
                self.connectId = json["connect_id"] as? String
                
                // create the alert
                let myAlert = UIAlertController(title: "UIAlertController", message: "연결을 수락하시겠습니까?", preferredStyle: UIAlertControllerStyle.Alert)
                
                // add the actions (buttons)
                myAlert.addAction(UIAlertAction(title: "연결", style: UIAlertActionStyle.Default, handler: nil))
                myAlert.addAction(UIAlertAction(title: "거부", style: UIAlertActionStyle.Cancel, handler: nil))
                
                // show the alert
                self.presentViewController(myAlert, animated: true, completion: nil)

                
                if (self.loversLoverStored != nil){
                    self.isAlreadyConnected = true
                    dispatch_async(dispatch_get_main_queue()) {
                        self.displayRegisterAlert("이 분은 이미 연인이에요", okAction: self.generalOkAction)
                    }

                }
            }
            self.threadIsAlive = 1

        })
        
        while (threadIsAlive == 0) {}
        
        if (isAlreadyConnected != true) {
            
            print("연결시도")
            
            let myEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
            
            MemberConstruct().connect(myEmail!, loverEmail: loverEmailStored!, completionHandler: { (json, error) -> Void in
                
                    dispatch_async(dispatch_get_main_queue()) {
                    
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                
                NSUserDefaults.standardUserDefaults().setObject(self.loverEmailStored, forKey: "userLover")
                NSUserDefaults.standardUserDefaults().setObject(self.connectId, forKey: "userConnectId")
            })
        }
    }

    func displayRegisterAlert(userMessage: String, okAction: UIAlertAction){
        let myAlert = UIAlertController(title:"알림", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = okAction
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    
        
    
}
