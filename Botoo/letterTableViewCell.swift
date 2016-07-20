//
//  letterTableViewCell.swift
//  Botoo
//
//  Created by 이은조 on 2016. 6. 29..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class letterTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var writerImage: UIImageView!
    
    var gender:Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
