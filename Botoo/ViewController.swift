//
//  ViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 6. 27..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        
        if (!isUserLoggedIn){
            self.performSegueWithIdentifier("toLoginView", sender: self)
        }
    }

}

