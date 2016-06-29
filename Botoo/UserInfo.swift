//
//  UserInfo.swift
//  Botoo
//
//  Created by 혜인 on 2016. 6. 29..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import Foundation

class UserInfo {
    var ver: String?
    var memberId: String?
    var email: String?
    var name: String?
    var gender: Int?
    var regId: String?
    var msg: String?
    var image: String?
    var lover: String?
    var lock: Bool?
    var lockPw: String?
    
    init(memberId: String, ver: String, email: String, name: String, gender: Int, regId: String, msg: String, image: String, lover: String, lock: Bool) {
        self.ver = ver
        self.email = email
        self.regId = regId
        self.memberId = memberId
        self.msg = msg
        self.image = image
        self.lover = lover
        self.name = name
        self.gender = gender
        self.lock = lock
    }
    
    init() {}
}