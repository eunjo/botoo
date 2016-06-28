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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController!.selectedIndex = 0
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
