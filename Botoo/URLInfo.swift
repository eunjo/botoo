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
    public var test: String
    
    public var checkEmail: String
    public var register: String
    public var drop: String
    public var changeName: String
    public var connect: String
    
    
    init() {
        test = WEB_SERVER_IP+"/"
        
        checkEmail = WEB_SERVER_IP + "/member/checkEmail"
        register = WEB_SERVER_IP + "/member/register"
        drop = WEB_SERVER_IP + "/member/drop"
        changeName = WEB_SERVER_IP+"/member/changeName"
        connect = WEB_SERVER_IP + "/member/connect"
    }
}