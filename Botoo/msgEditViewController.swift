//
//  msgEditViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 7. 2..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class msgEditViewController: UIViewController {

    @IBOutlet weak var msgLabel: UITextField!
    var msg: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // right bar item 추가
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .Plain, target: self, action: #selector(addTapped))
    }
    
    override func viewWillAppear(animated: Bool) {
        if msg != nil {
            msgLabel.text = msg
        }
    }
    
    func addTapped(){
        let myId = NSUserDefaults.standardUserDefaults().stringForKey("userId")
        
        if msgLabel.text != msg {
            MemberConstruct().changeMsg(myId!, userMsg: msgLabel.text!,  completionHandler: { (json, error) -> Void in
                print("success")
            })
        }

        
        
        HomeViewController.getUserInfo.userInfo.msg = msgLabel.text
        NSUserDefaults.standardUserDefaults().setObject(msgLabel.text, forKey: "stateMSG")
        
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
