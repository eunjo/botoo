//
//  TestProtocol.swift
//  Botoo
//
//  Created by 혜인 on 2016. 7. 11..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import Foundation

protocol TestProtocol {
    func testConnect(urlInfo:URLInfo, httpMethod:String, params:Dictionary<String,String>?, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask?
}