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
    
    var gNforStore:String?
    var fNforStore:String?
    var pNforStore:String?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNum: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if (contact != nil){
            
            let gN = (contact?.givenName)!
            let fN = (contact?.familyName)!
            
            let pN = (contact?.phoneNumbers[0].value as! CNPhoneNumber).valueForKey("digits") as! String
            
            name.text = "\(gN) \(fN)"
            phoneNum.text = "\(pN)"
            
            gNforStore = gN
            fNforStore = fN
            pNforStore = pN
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closeButtonTapped(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        
        let myAlert = UIAlertController(title:"\(gNforStore!) \(fNforStore!)", message: "연락처를 저장하시겠습니까?", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title:"확인", style:UIAlertActionStyle.Default, handler: {
            
                action in
            
            self.OK(self.gNforStore!, fN: self.fNforStore!, pN: self.pNforStore!)
        })
        
        myAlert.addAction(okAction)
        myAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(myAlert, animated: true, completion: nil)


    }
    
    func OK(gN:String, fN:String, pN:String){
        
        let store = CNContactStore()
        let contact:CNMutableContact = CNMutableContact()
        contact.givenName = gN
        contact.familyName = fN
        let phone = CNLabeledValue(label: CNLabelWork, value:CNPhoneNumber(stringValue: pN as! String))
        contact.phoneNumbers = [phone]
        
        let request = CNSaveRequest()
        request.addContact(contact, toContainerWithIdentifier: nil)
        
        do{
            try store.executeSaveRequest(request)
            print("Successfully added the contact")
        } catch let err{
            print("Failed to save the contact. \(err)")
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
