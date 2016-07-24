//
//  alarmSetViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 7. 2..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class alarmSetViewController: UIViewController {

    
    @IBOutlet weak var pushAlarm_sc: UISwitch!
    @IBOutlet weak var pushAlarmPreview_sc: UISwitch!

    @IBOutlet weak var vivAlarm_sc: UISwitch!
    @IBOutlet weak var soundAlarm_Sc: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func pushAlarm_Sc(sender: UISwitch) {
        
        if (sender.on == true){
            
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isPushAlarmOn")
            
        }
        else {
        
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isPushAlarmOn")
            
        }
        
    }
    
    @IBAction func pushAlarmPreview_Sc(sender: UISwitch) {
        
        if (sender.on==true){
            
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isPushAlarmPreviewOn")
            
        }
        else {
            
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isPushAlarmPreviewOn")
            
        }
        
    }

    @IBAction func vivAlarm_Sc(sender: UISwitch) {
        
        if (sender.on==true){
            
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isVibAlarmOn")
            
        }
        else {
            
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isVibAlarmOn")
            
        }
        
    }
    
    @IBAction func soundAlarm_Sc(sender: UISwitch) {
        
        if sender.on {
            
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isSoundAlarmOn")
            
        }
        else {
            
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isSoundAlarmOn")
            
        }
        
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
