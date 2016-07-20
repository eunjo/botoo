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
    
    init(title: String, writerImage: String, letterId: String, date: String, body: String) {
        self.title = title
        self.writerImage = writerImage
        self.body = body
        self.date = date
        self.letterId = letterId
    }
    
    init() {}
}
