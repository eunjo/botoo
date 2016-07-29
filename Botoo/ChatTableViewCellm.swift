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
    @IBOutlet var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let myImage = UIImage(named: "chatBubble.png")
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: messageBubble.frame.width, height: messageBubble.frame.height))
        myImageView.image = myImage
        view.addSubview(myImageView)
        
    //    messageBubble.backgroundColor = UIColor(patternImage: UIImage(named: "chatBubble.png")!)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
