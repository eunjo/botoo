//
//  ChatPicTabelViewCellm.swift
//  Botoo
//
//  Created by 혜인 on 2016. 8. 12..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class ChatPicTabelViewCellm: UITableViewCell {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var pic: UIImageView!
    @IBOutlet var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
