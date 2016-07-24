//
//  LetterNavViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 6. 29..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class LetterNavViewController: UINavigationController {


    @IBOutlet weak var letterTabBarItem: UITabBarItem!

    var isReadCount:Int = 0
    var idx:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar.barTintColor = UIColor(red: 252.0/255, green: 228.0/255, blue: 236.0/255, alpha: 1)
        self.navigationBar.tintColor = UIColor.blackColor()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().stringForKey("userLover") == "nil" {
            self.tabBarController!.selectedIndex = 0
            if idx {
                if let connectingViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ConnectingViewController") {
                    connectingViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
                    self.parentViewController!.presentViewController(connectingViewController, animated: true, completion: nil)
                }
                idx = false
            } else {
                idx = true
            }
        }
        self.tabBarItem.badgeValue = nil

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetBadge(isReadCount:Int){
        
        if (isReadCount==0){
            self.tabBarItem.badgeValue = nil
        } else {
            self.tabBarItem.badgeValue = String(isReadCount)
        }

    }

}
