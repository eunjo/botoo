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
        let userProfile = NSUserDefaults.standardUserDefaults().stringForKey("userProfile")
        let connect_id = NSUserDefaults.standardUserDefaults().stringForKey("userConnectId")
        
        
        let letterParams = [
            "sender": userProfile! as String,
            "title": title! as String,
            "body": body! as String,
            "date": date as String,
            "connect_id": connect_id! as String
        ]
        
        MemberConstruct().writeLetter(letterParams, completionHandler: { (json, error) -> Void in
            print(json)

        })
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("?")
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


