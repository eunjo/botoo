//
//  TestConstruct.swift
//  Botoo
//
//  Created by 혜인 on 2016. 7. 11..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import Foundation

class TestConstruct: TestProtocol {
    
    let session = NSURLSession.sharedSession()
    let urlInfo = URLInfo()
    let request = NSMutableURLRequest()
    
    func testConnect(urlInfo:URLInfo, httpMethod:String, params:Dictionary<String,String>?, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask? {
        
        //파라미터를 추가한 URL 생성
        let URL = NSURL(string: "\(urlInfo.test)")
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = httpMethod
        request.URL = URL
        
        if (params != nil){
            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params!, options: [])
        }
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            //statusCode가 200인건 성공적으로 json을 파싱했다는것임.
            if (statusCode == 200) {
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    //핸들러를 이용하여 json을 return 한다.
                    completionHandler(json, nil)
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        
        //task 실행
        task.resume()
        return task
    }
}