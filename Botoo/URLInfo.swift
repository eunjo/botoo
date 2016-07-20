//
//  URLInfo.swift
//  Botoo
//
//  Created by 혜인 on 2016. 7. 11..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import Foundation

public class URLInfo {
    public let WEB_SERVER_IP = "http://ec2-52-42-42-59.us-west-2.compute.amazonaws.com"
    
    public var checkEmail: String
    public var register: String
    public var drop: String
    public var changeName: String
    public var connect: String
    public var changeMsg: String
    public var updateDate: String
    public var disconnect: String
    public var writeLetter: String
    public var callLetter: String
    public var saveProPic: String

    init() {
        updateDate = WEB_SERVER_IP + "/member/updateDate"
        changeMsg = WEB_SERVER_IP + "/member/changeMsg"
        checkEmail = WEB_SERVER_IP + "/member/checkEmail"
        register = WEB_SERVER_IP + "/member/register"
        drop = WEB_SERVER_IP + "/member/drop"
        changeName = WEB_SERVER_IP + "/member/changeName"
        connect = WEB_SERVER_IP + "/member/connect"
        disconnect = WEB_SERVER_IP + "/member/disconnect"
        writeLetter = WEB_SERVER_IP + "/member/writeLetter"
        callLetter = WEB_SERVER_IP + "/member/callLetter"
        saveProPic = WEB_SERVER_IP + "/member/saveProPic"
    }
}