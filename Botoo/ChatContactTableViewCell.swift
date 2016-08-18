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


    
}
