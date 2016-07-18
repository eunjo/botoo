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
        
        
        
        let myEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
        
        MemberConstruct().updateLetter(title!, body: body!, sender: myEmail!, date: date, completionHandler: { (json, error) -> Void in
            print(json)

            })
        // 서버 구축 후 데이터 저장
        
        navigationController?.popViewControllerAnimated(true)
 
        
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


