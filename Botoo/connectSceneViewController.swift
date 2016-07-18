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
    
    var threadIsAlive = 0
    
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
        
        MemberConstruct().checkEmail(loverEmail!, completionHandler: { (json, error) -> Void in
            if json != nil {
                self.isGot = true
                
                self.loverEmailStored = json["email"] as? String
                self.loverNameStored = json["name"] as? String
                
                self.connectButton.enabled = true
            }
            self.threadIsAlive = 1
        })
        
        while self.threadIsAlive == 0 {}
        
        searchResult.text = loverNameStored
        
        if !isGot {
            print("등록안된 이메일일때")
            searchResult.text = "존재하지 않는 사용자입니다"
            connectButton.enabled = false
            return
        }
    }
    
    
    
    @IBAction func connectButtonTapped(sender: AnyObject) {
        
        let myEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
        
        MemberConstruct().connect(myEmail!, loverEmail: loverEmailStored!, completionHandler: { (json, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
 
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        })

    }

}
