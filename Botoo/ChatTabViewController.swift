//
//  ChatViewController.swift
//  Botoo
//
//  Created by 혜인 on 2016. 6. 28..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class ChatTabViewController: UIViewController {

    var idx:Bool = true
    var idx2:Bool = true
    
    @IBOutlet weak var chatTabBarItem: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        if !Reachability.isConnectedToNetwork() {
            self.presentViewController(Reachability.alert(), animated: true, completion: nil)
        } else {
            self.tabBarController!.selectedIndex = 0
            
            if NSUserDefaults.standardUserDefaults().stringForKey("userLover") == "nil" {
                if idx2 {
                    if let connectingViewController =   self.storyboard?.instantiateViewControllerWithIdentifier("ConnectingViewController") {
                        connectingViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
                        self.parentViewController!.presentViewController(connectingViewController, animated: true, completion: nil)
                    }
                    idx2 = false
                } else {
                    idx2 = true
                }
            } else {
                if idx {
                    let chatNavViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ChatNavViewController")
                    chatNavViewController!.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
                    self.parentViewController!.presentViewController(chatNavViewController!, animated: true, completion: nil)
                    idx = false
                } else {
                    idx = true
                }
            }
        }
    }
}
