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
    }

    override func viewDidAppear(animated: Bool) {
        self.alert2()
    }
    
    func alert2() {

        let alert=UIAlertController(title: "Alert 2", message: "Two is awesome too", preferredStyle: UIAlertControllerStyle.Alert);
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil));
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {(action:UIAlertAction) in
            print("예쓰~~")
        }));
        
        self.presentViewController(alert, animated: true, completion: nil);
        print("나타난다");
        
    }
    
    func backButtonTapped(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    func searchButtonTapped(sender: AnyObject) {
        
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
    
        var isAlreadyConnected = false;
    
    func connectButtonTapped(sender: AnyObject) {
        
        let loverEmail = searchEmailTextField.text
        
        MemberConstruct().checkEmail(loverEmail!, completionHandler: { (json, error) -> Void in
            if json != nil {

                self.loverEmailStored = json["email"] as? String
                self.loverNameStored = json["name"] as? String
                self.loversLoverStored = json["lover"] as? String
                self.connectId = json["connect_id"] as? String
               
                
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
