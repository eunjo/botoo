//
//  chatBGcolorViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 7. 4..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class chatBGcolorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let whiteTap = UITapGestureRecognizer(target: self, action: #selector(chatBGcolorViewController.whiteTapped(_:)))
        white.userInteractionEnabled = true
        white.addGestureRecognizer(whiteTap)
        
        let lightgreyTap = UITapGestureRecognizer(target: self, action: #selector(chatBGcolorViewController.lightgreyTapped(_:)))
        lightgrey.userInteractionEnabled = true
        lightgrey.addGestureRecognizer(lightgreyTap)
        
        let greyTap = UITapGestureRecognizer(target: self, action: #selector(chatBGcolorViewController.greyTapped(_:)))
        grey.userInteractionEnabled = true
        grey.addGestureRecognizer(greyTap)
        
        let blackTap = UITapGestureRecognizer(target: self, action: #selector(chatBGcolorViewController.blackTapped(_:)))
        black.userInteractionEnabled = true
        black.addGestureRecognizer(blackTap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBOutlet weak var white: UIView!
    func whiteTapped(sender: UITapGestureRecognizer){
    
    NSUserDefaults.standardUserDefaults().setObject(true, forKey: "ischatBgColor")
        NSUserDefaults.standardUserDefaults().setObject("white", forKey: "chatBgColor")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    @IBOutlet weak var black: UIView!
    func blackTapped(sender: UITapGestureRecognizer){
    
    NSUserDefaults.standardUserDefaults().setObject(true, forKey: "ischatBgColor")
        NSUserDefaults.standardUserDefaults().setObject("black", forKey: "chatBgColor")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var lightgrey: UIView!
    func lightgreyTapped(sender: UITapGestureRecognizer){
        
        NSUserDefaults.standardUserDefaults().setObject(true, forKey: "ischatBgColor")
        NSUserDefaults.standardUserDefaults().setObject("lightgrey", forKey: "chatBgColor")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var grey: UIView!
    func greyTapped(sender: UITapGestureRecognizer){
        
        NSUserDefaults.standardUserDefaults().setObject(true, forKey: "ischatBgColor")
        NSUserDefaults.standardUserDefaults().setObject("grey", forKey: "chatBgColor")
        self.dismissViewControllerAnimated(true, completion: nil)
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
