//
//  byebyeViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 7. 2..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class byebyeViewController: UIViewController {
    
    var threadIsAlive = 0
    var myEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func disconnectButtonTapped(sender: AnyObject) {
        
        if NSUserDefaults.standardUserDefaults().stringForKey("userConnectId") != "nil" {
            
            FileManager.sharedInstance.initFile()
            
            ChatViewController.removeChats.isRemove = true
            
            
            let loverEmailStored =  NSUserDefaults.standardUserDefaults().stringForKey("userLover")
            MemberConstruct().disconnect(myEmail!, loverEmail: loverEmailStored!, completionHandler: { (json, error) -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    self.navigationController?.popViewControllerAnimated(true)
                    NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "userLover")
                }
            })
        } else {
            let myAlert = UIAlertController(title:"알림", message: "짝이 없어요.", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title:"확인", style:UIAlertActionStyle.Default, handler:nil)
            
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
        }

        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "letterBadge")
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
