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
    
    public var setOnline: String
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
    public var setProPicDefault: String
    public var deleteLetter: String
    public var updateLetter: String
    public var sendAlert: String
    public var acceptAlert: String
    public var saveMessage: String
    public var getMessage: String
    public var countMessage: String

    init() {
        setOnline = WEB_SERVER_IP + "/member/setOnline"
        acceptAlert = WEB_SERVER_IP + "/member/acceptAlert"
        sendAlert = WEB_SERVER_IP + "/member/sendAlert"
        updateDate = WEB_SERVER_IP + "/member/updateDate"
        changeMsg = WEB_SERVER_IP + "/member/changeMsg"
        checkEmail = WEB_SERVER_IP + "/member/checkEmail"
        register = WEB_SERVER_IP + "/member/register"
        drop = WEB_SERVER_IP + "/member/drop"
        changeName = WEB_SERVER_IP + "/member/changeName"
        connect = WEB_SERVER_IP + "/member/connect"
        disconnect = WEB_SERVER_IP + "/member/disconnect"
        writeLetter = WEB_SERVER_IP + "/letter/writeLetter"
        callLetter = WEB_SERVER_IP + "/letter/callLetter"
        saveProPic = WEB_SERVER_IP + "/member/saveProPic"
        setProPicDefault = WEB_SERVER_IP + "/member/setProPicDefault"
        deleteLetter = WEB_SERVER_IP + "/letter/deleteLetter"
        updateLetter = WEB_SERVER_IP + "/letter/updateLetter"
        saveMessage = WEB_SERVER_IP + "/chat/saveMessage"
        getMessage = WEB_SERVER_IP + "/chat/getMessage"
        countMessage = WEB_SERVER_IP + "/chat/countMessage"
    }
}