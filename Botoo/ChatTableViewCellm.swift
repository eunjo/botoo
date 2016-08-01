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
        

    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setSize(bubbleWidth:CGFloat, bubbleHeight:CGFloat){
        
        messageBubble.sizeToFit()
        
        let myImage = UIImage(named: "chatBubble.png")
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: bubbleWidth+30, height: bubbleHeight+15))
        myImageView.image = myImage
        messageBubble.tag = 1000
 
        view.subviews.forEach({
            if $0.tag != 1000{
                $0.removeFromSuperview()
            }
        
        })
        
        print("\(bubbleWidth) \(bubbleHeight)")
        
        view.addSubview(myImageView)
        view.addSubview(messageBubble)

    }
    

}
