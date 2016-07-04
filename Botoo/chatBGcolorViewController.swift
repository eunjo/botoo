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
        
        let lightPinkTap = UITapGestureRecognizer(target: self, action: #selector(chatBGcolorViewController.lightPinkTapped(_:)))
        lightPink.userInteractionEnabled = true
        lightPink.addGestureRecognizer(lightPinkTap)
        
        let lightgreyTap = UITapGestureRecognizer(target: self, action: #selector(chatBGcolorViewController.lightgreyTapped(_:)))
        lightgrey.userInteractionEnabled = true
        lightgrey.addGestureRecognizer(lightgreyTap)
        
        let greyTap = UITapGestureRecognizer(target: self, action: #selector(chatBGcolorViewController.greyTapped(_:)))
        grey.userInteractionEnabled = true
        grey.addGestureRecognizer(greyTap)
        
        let blackTap = UITapGestureRecognizer(target: self, action: #selector(chatBGcolorViewController.blackTapped(_:)))
        black.userInteractionEnabled = true
        black.addGestureRecognizer(blackTap)
        
        let lightBlueTap = UITapGestureRecognizer(target: self, action: #selector(chatBGcolorViewController.lightBlueTapped(_:)))
        lightBlue.userInteractionEnabled = true
        lightBlue.addGestureRecognizer(lightBlueTap)
        
        let lightPurpleTap = UITapGestureRecognizer(target: self, action: #selector(chatBGcolorViewController.lightPurpleTapped(_:)))
        lightPurple.userInteractionEnabled = true
        lightPurple.addGestureRecognizer(lightPurpleTap)
        
        let lightYellowTap = UITapGestureRecognizer(target: self, action: #selector(chatBGcolorViewController.lightYellowTapped(_:)))
        lightYellow.userInteractionEnabled = true
        lightYellow.addGestureRecognizer(lightYellowTap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBOutlet weak var white: UIView!
    func whiteTapped(sender: UITapGestureRecognizer){
    
        NSUserDefaults.standardUserDefaults().setObject(true, forKey: "ischatBgColor")
        NSUserDefaults.standardUserDefaults().setObject(false, forKey: "ischatBgPic")
    NSUserDefaults.standardUserDefaults().setObject("white", forKey: "chatBgColor")
        NSUserDefaults.standardUserDefaults().synchronize()
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBOutlet weak var lightPink: UIView!
    func lightPinkTapped(sender: UITapGestureRecognizer){
        
        NSUserDefaults.standardUserDefaults().setObject(true, forKey: "ischatBgColor")
        NSUserDefaults.standardUserDefaults().setObject(false, forKey: "ischatBgPic")
    NSUserDefaults.standardUserDefaults().setObject("lightPink", forKey: "chatBgColor")
        NSUserDefaults.standardUserDefaults().synchronize()
        navigationController?.popViewControllerAnimated(true)
    }

    @IBOutlet weak var black: UIView!
    func blackTapped(sender: UITapGestureRecognizer){
    
        NSUserDefaults.standardUserDefaults().setObject(true, forKey: "ischatBgColor")
        NSUserDefaults.standardUserDefaults().setObject(false, forKey: "ischatBgPic")
    NSUserDefaults.standardUserDefaults().setObject("black", forKey: "chatBgColor")
        NSUserDefaults.standardUserDefaults().synchronize()
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBOutlet weak var lightgrey: UIView!
    func lightgreyTapped(sender: UITapGestureRecognizer){
        
        NSUserDefaults.standardUserDefaults().setObject(true, forKey: "ischatBgColor")
        NSUserDefaults.standardUserDefaults().setObject(false, forKey: "ischatBgPic")
    NSUserDefaults.standardUserDefaults().setObject("lightgrey", forKey: "chatBgColor")
        NSUserDefaults.standardUserDefaults().synchronize()
        navigationController?.popViewControllerAnimated(true)

    }
    
    @IBOutlet weak var grey: UIView!
    func greyTapped(sender: UITapGestureRecognizer){
        
        NSUserDefaults.standardUserDefaults().setObject(true, forKey: "ischatBgColor")
        NSUserDefaults.standardUserDefaults().setObject(false, forKey: "ischatBgPic")
    NSUserDefaults.standardUserDefaults().setObject("grey", forKey: "chatBgColor")
        NSUserDefaults.standardUserDefaults().synchronize()
        navigationController?.popViewControllerAnimated(true)
    }

    @IBOutlet weak var lightBlue: UIView!
    func lightBlueTapped(sender: UITapGestureRecognizer){
        
        NSUserDefaults.standardUserDefaults().setObject(true, forKey: "ischatBgColor")
        NSUserDefaults.standardUserDefaults().setObject(false, forKey: "ischatBgPic")
        NSUserDefaults.standardUserDefaults().setObject("lightBlue", forKey: "chatBgColor")
        NSUserDefaults.standardUserDefaults().synchronize()
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBOutlet weak var lightPurple: UIView!
    func lightPurpleTapped(sender: UITapGestureRecognizer){
        
        NSUserDefaults.standardUserDefaults().setObject(true, forKey: "ischatBgColor")
        NSUserDefaults.standardUserDefaults().setObject(false, forKey: "ischatBgPic")
        NSUserDefaults.standardUserDefaults().setObject("lightPurple", forKey: "chatBgColor")
        NSUserDefaults.standardUserDefaults().synchronize()
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBOutlet weak var lightYellow: UIView!
    func lightYellowTapped(sender: UITapGestureRecognizer){
        
        NSUserDefaults.standardUserDefaults().setObject(true, forKey: "ischatBgColor")
        NSUserDefaults.standardUserDefaults().setObject(false, forKey: "ischatBgPic")
        NSUserDefaults.standardUserDefaults().setObject("lightYellow", forKey: "chatBgColor")
        NSUserDefaults.standardUserDefaults().synchronize()
        navigationController?.popViewControllerAnimated(true)
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
