//
//  contactDetailViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 8. 11..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit
import ContactsUI
import Contacts

class contactDetailViewController: UIViewController {
    
    var contact:CNMutableContact?

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNum: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let gN = (contact?.givenName)
        let fN = (contact?.familyName)
        let pN:String? = (contact?.phoneNumbers[0].value as! CNPhoneNumber).valueForKey("digits") as! String
        
        name.text = "\(gN!) \(fN!)"
        phoneNum.text = "\(pN)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closeButtonTapped(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addButtonTapped(sender: AnyObject) {
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
