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
    
    var loverEmailStored:String?
    
    var myEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        MemberConstruct().checkEmail(myEmail!, completionHandler: { (json, error) -> Void in
            self.loverEmailStored = json["lover"] as? String
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func disconnectButtonTapped(sender: AnyObject) {
        
        MemberConstruct().disconnect(myEmail!, loverEmail: loverEmailStored!, completionHandler: { (json, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                    
                    self.navigationController?.popViewControllerAnimated(true)
            }
        })

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
