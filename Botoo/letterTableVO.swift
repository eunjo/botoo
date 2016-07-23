//
//  letterTableViewCell.swift
//  Botoo
//
//  Created by 이은조 on 2016. 6. 29..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class letterTableVO {
    
    var title = ""
    var writerImage = ""
    var letterId = ""
    var date = ""
    var body = ""
    var writerId = ""
    
    var isRead = 0 // false
    
    init(writerId: String, title: String, writerImage: String, letterId: String, date: String, body: String, isRead: Int) {
        self.writerId = writerId
        self.title = title
        self.writerImage = writerImage
        self.body = body
        self.date = date
        self.letterId = letterId
        self.isRead = isRead
    }
    
    init() {}
}
