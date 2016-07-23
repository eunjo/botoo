//
//  LetterConstruct.swift
//  Botoo
//
//  Created by 혜인 on 2016. 7. 23..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import Foundation

class LetterConstruct: LetterProtocol {
    
    let session = NSURLSession.sharedSession()
    let urlInfo = URLInfo()
    let request = NSMutableURLRequest()
    
    func writeLetter(letterInfo: Dictionary<String,String>?, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask? {
        //파라미터를 추가한 URL 생성
        
        let URL = NSURL(string: "\(urlInfo.writeLetter)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        request.URL = URL
        
        if (letterInfo != nil){
            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(letterInfo!, options: [])
        }
        
        let task = session.dataTaskWithRequest(request) {
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
    
    func callLetter(connectID: String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask? {
        let postString = "connectID=\(connectID)"
        let URL = NSURL(string: "\(urlInfo.callLetter)?\(postString)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
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
    
    func deleteLetter(connectID: String, letterID: String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask? {
        let postString = "connectID=\(connectID)&letterID=\(letterID)"
        let URL = NSURL(string: "\(urlInfo.deleteLetter)?\(postString)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "DELETE"
        request.URL = URL
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            print(response)
            
            //statusCode가 200인건 성공적으로 json을 파싱했다는것임.
            if (statusCode == 200) {
                completionHandler(NSString(data: data!, encoding: NSUTF8StringEncoding)!, nil)
            }
        }
        
        //task 실행
        task.resume()
        return task
    }
    
    func updateLetter(connectID: String, letterID: String, isRead: String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask? {
        let postString = "connect_id=\(connectID)&letterId=\(letterID)&isRead=\(isRead)"
        let URL = NSURL(string: "\(urlInfo.updateLetter)?\(postString)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "PUT"
        request.URL = URL
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            print(response)
            
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
}