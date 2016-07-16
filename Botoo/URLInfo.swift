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
    
    
    init() {
        test = WEB_SERVER_IP+"/"
        
        checkEmail = WEB_SERVER_IP + "/member/checkEmail"
        register = WEB_SERVER_IP + "/member/register"
    }
}