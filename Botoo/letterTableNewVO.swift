//
//  letterTableNewVO.swift
//  Botoo
//
//  Created by 혜인 on 2016. 7. 20..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import Foundation

class letterTableNewVO {
    
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