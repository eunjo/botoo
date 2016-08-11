//
//  ChatContactTableViewCell.swift
//  Botoo
//
//  Created by 이은조 on 2016. 8. 9..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit
import Contacts


class ChatContactTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactButton: UIButton!
    
    var givenName:String?
    var familyName:String?
    var phoneNum:String?
    
    var childView = contactDetailViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func contactButtonTapped(sender: AnyObject) {

        
        let Contact = CNMutableContact()
        
        Contact.givenName = self.givenName!
        Contact.familyName = self.familyName!
        let phone = CNLabeledValue(label: CNLabelWork, value:CNPhoneNumber(stringValue: self.phoneNum!))
        Contact.phoneNumbers = [phone]
        
        self.childView.contact = Contact
    
        dispatch_sync(dispatch_get_main_queue(), {
//            if let delegate = UIApplication.sharedApplication().delegate {
//                delegate.window!!.rootViewController?.presentViewController(self.childView, animated: true, completion: { () -> Void in
//                    // optional completion code
//                })
//            }
            
            if let connectingViewController = self.childView.storyboard?.instantiateViewControllerWithIdentifier("contactDetail") {
                connectingViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
                self.childView.presentViewController(connectingViewController, animated: true, completion: nil)
            }
        })
    
    }
    
    func setData(gN:String, fN:String, pN:String){
     
        self.givenName = gN
        self.familyName = fN
        self.phoneNum = pN
    }
    
    
}
