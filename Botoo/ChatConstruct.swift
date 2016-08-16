//
//  ChatConstruct.swift
//  Botoo
//
//  Created by 혜인 on 2016. 8. 11..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import Foundation

class ChatConstruct: ChatProtocol {
    
    let session = NSURLSession.sharedSession()
    let urlInfo = URLInfo()
    let request = NSMutableURLRequest()
    
    func saveMessage(messageInfo: Dictionary<String,String>?, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask? {
        
        let URL = NSURL(string: "\(urlInfo.saveMessage)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        request.URL = URL
        
        if (messageInfo != nil){
            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(messageInfo!, options: [])
        }
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            //statusCode가 200인건 성공적으로 json을 파싱했다는것임.
            if (statusCode == 200) {
                do{
                    completionHandler(NSString(data: data!, encoding: NSUTF8StringEncoding)!, nil)
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        
        
        //task 실행
        task.resume()
        return task
    }
    
    func getMessage(senderId: String, userId: String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask? {
        let postString = "receiverId=\(userId)&senderId=\(senderId)"
        let URL = NSURL(string: "\(urlInfo.getMessage)?\(postString)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
        let task = session.dataTaskWithRequest(NSMutableURLRequest(URL: URL!)) {
            (data, response, error) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            //statusCode가 200인건 성공적으로 json을 파싱했다는것임.
            if (statusCode == 200) {
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
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
    
    func countMessage(userId: String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask? {
        let postString = "receiverId=\(userId)"
        let URL = NSURL(string: "\(urlInfo.countMessage)?\(postString)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
        let task = session.dataTaskWithRequest(NSMutableURLRequest(URL: URL!)) {
            (data, response, error) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            //statusCode가 200인건 성공적으로 json을 파싱했다는것임.
            if (statusCode == 200) {
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
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