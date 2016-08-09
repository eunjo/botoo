//
//  LetterrWriteViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 6. 29..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class LetterrWriteViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var letterText: UITextView!
    
    struct getNewLetterInfo {
        static var letterInfo: letterTableVO?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        letterText!.layer.cornerRadius = 8.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButtonTapped(sender: AnyObject) {
        
        let title = titleTextField.text
        let body = letterText.text
        
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date:String = dateFormatter.stringFromDate(currentDate)
        var userProfile = NSUserDefaults.standardUserDefaults().stringForKey("userProfile")
        let connect_id = NSUserDefaults.standardUserDefaults().stringForKey("userConnectId")
        let user_id = NSUserDefaults.standardUserDefaults().stringForKey("userId")
        
        if userProfile == "nil" {
            userProfile = "nil\(NSUserDefaults.standardUserDefaults().stringForKey("userGender")!)"
        }
        
        let letterParams = [
            "sender_id": user_id! as String,
            "sender": userProfile! as String,
            "title": title! as String,
            "body": body! as String,
            "date": date as String,
            "connect_id": connect_id! as String
        ]
        
        LetterConstruct().writeLetter(letterParams, completionHandler: { (json, error) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                LetterrWriteViewController.getNewLetterInfo.letterInfo = letterTableVO(writerId: letterParams["sender_id"]!, title: letterParams["title"]!, writerImage: letterParams["sender"]!, letterId: json["_id"] as! String, date: letterParams["date"]!, body: letterParams["body"]!, isRead: 0)
                // create a corresponding local notification
                let notification = UILocalNotification()
                notification.alertBody = "New letter" // text that will be displayed in the notification
                notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
                notification.fireDate = NSDate(timeIntervalSinceNow: 1)// todo item due date (when notification will be fired)
                notification.soundName = UILocalNotificationDefaultSoundName // play default sound
                UIApplication.sharedApplication().scheduleLocalNotification(notification)

                self.navigationController?.popViewControllerAnimated(true)
            }
        })
        
           }
}


