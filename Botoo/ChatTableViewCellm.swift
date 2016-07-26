//
//  ChatTableViewCell.swift
//  Botoo
//
//  Created by 혜인 on 2016. 7. 25..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class ChatTableViewCellm: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageBubble: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let buttonImageNormal = UIImage(named: "chatBubble.png")!
        messageBubble.backgroundColor = UIColor(patternImage: buttonImageNormal.resizableImageWithCapInsets(UIEdgeInsetsMake(2, 2, 7, 7)))
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
