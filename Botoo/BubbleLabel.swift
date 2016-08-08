
//
//  BubbleLabel.swift
//  Botoo
//
//  Created by 혜인 on 2016. 8. 3..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class BubbleLabel: UILabel {
    
    var topInset:       CGFloat = 8
    var rightInset:     CGFloat = 8
    var bottomInset:    CGFloat = 8
    var leftInset:      CGFloat = 8
    
    override func drawTextInRect(rect: CGRect) {
        var insets: UIEdgeInsets = UIEdgeInsets(top: self.topInset, left: self.leftInset, bottom: self.bottomInset, right: self.rightInset)
        
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
        self.setNeedsLayout()
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override func intrinsicContentSize() -> CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize()
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }

}