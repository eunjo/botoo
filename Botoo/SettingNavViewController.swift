//
//  SettingNavViewController.swift
//  Botoo
//
//  Created by 혜인 on 2016. 6. 29..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class SettingNavViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //네비게이션바 바 색상
        self.navigationBar.barTintColor = UIColor(red: 252.0/255, green: 228.0/255, blue: 236.0/255, alpha: 1)
        
        //네비게이션바 틴트 색상
        // Status bar white font
        //        self.navigationBar.barStyle = UIBarStyle.Black
        self.navigationBar.tintColor = UIColor.blackColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        if !Reachability.isConnectedToNetwork() {
            self.presentViewController(Reachability.alert(), animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}