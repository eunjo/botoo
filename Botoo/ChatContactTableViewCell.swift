//
//  ChatContactTableViewCell.swift
//  Botoo
//
//  Created by 이은조 on 2016. 8. 9..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ChatContactTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactButton: UIButton!
    
    var givenName:String?
    var familyName:String?
    var phoneNum:String?
    
    var childView = contactDetailViewController()
    var parentView = ChatViewController()
    
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

            
            let alertController = UIAlertController(title: "알림", message: "이 연락처를 저장하시겠습니까?", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title:"확인", style:UIAlertActionStyle.Default, handler: { action in
                
                self.OkAction()
            
            })
            
            alertController.addAction(okAction)
            
            let pushedViewControllers = (self.window?.rootViewController as! UINavigationController).viewControllers
            let presentedViewController = pushedViewControllers[pushedViewControllers.count - 1]
            
            presentedViewController.presentViewController(alertController, animated: true, completion: nil)
            
        })
    
    }
    
    func setData(gN:String, fN:String, pN:String){
     
        self.givenName = gN
        self.familyName = fN
        self.phoneNum = pN
    }
    
    func OkAction(){
        
        let newContact = CNMutableContact()
        
        newContact.givenName = self.givenName!
        newContact.familyName = self.familyName!
        
        let store = CNContactStore()
        let request = CNSaveRequest()
        request.addContact(newContact, toContainerWithIdentifier: nil)
        do{
            try store.executeSaveRequest(request)
            print("Successfully stored the contact")
        } catch let err{
            print("Failed to save the contact. \(err)")
        }

    }
    
    
}
