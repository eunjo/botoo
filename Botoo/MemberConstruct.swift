//
//  TestConstruct.swift
//  Botoo
//
//  Created by 혜인 on 2016. 7. 11..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import Foundation

class MemberConstruct: MemberProtocol {
    
    let session = NSURLSession.sharedSession()
    let urlInfo = URLInfo()
    let request = NSMutableURLRequest()
    
    func checkEmail(userEmail: String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask? {
        //파라미터를 추가한 URL 생성
        let postString = "email=\(userEmail)"
        let URL = NSURL(string: "\(urlInfo.checkEmail)?\(postString)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
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
//                    print("Error with Json: \(error)")
                    
                    // 이메일이 없는 경우 (0bytes 가 넘어오는 경우 nil 을 보내버림)
                    completionHandler(nil, nil)
                }
            }
        }
        
        //task 실행
        task.resume()
        return task
    }
    
    func register(userInfo: Dictionary<String,String>?, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask? {
        //파라미터를 추가한 URL 생성
        let URL = NSURL(string: "\(urlInfo.register)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        request.URL = URL
        
        if (userInfo != nil){
            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(userInfo!, options: [])
        }
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            print(response)
            //statusCode가 200인건 성공적으로 json을 파싱했다는것임.
            if (statusCode == 200) {
                do{
                    print(data)
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
    
    func drop(userId: String, loverEmail: String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask? {
        //파라미터를 추가한 URL 생성
        let postString = "id=\(userId)&loverEmail=\(loverEmail)"
        let URL = NSURL(string: "\(urlInfo.drop)?\(postString)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
        let task = session.dataTaskWithRequest(NSMutableURLRequest(URL: URL!)) {
            (data, response, error) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            print(response)
            //statusCode가 200인건 성공적으로 json을 파싱했다는것임.
            if (statusCode == 200) {
                    // 받아오는 데이터가 json 형식이 아닌 경우
                    completionHandler(NSString(data: data!, encoding: NSUTF8StringEncoding)!, nil)
            }
        }
        
        //task 실행
        task.resume()
        return task
    }
    
    func changeName(userID: String, userName: String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask? {
        let postString = "id=\(userID)&name=\(userName)"
        let URL = NSURL(string: "\(urlInfo.changeName)?\(postString)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
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
    
    func changeMsg(userID: String, userMsg: String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask? {
        
        let postString = "id=\(userID)&msg=\(userMsg)"
        let URL = NSURL(string: "\(urlInfo.changeMsg)?\(postString)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
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

    
    func connect(myEmail:String, loverEmail:String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask? {
        //파라미터를 추가한 URL 생성
        let postString = "myEmail=\(myEmail)&loverEmail=\(loverEmail)"
        let URL = NSURL(string: "\(urlInfo.connect)?\(postString)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
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
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    print(json)
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


func updateDate(userID: String, loverID: String, userDate: String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask? {
    let postString = "id=\(userID)&userlover=\(loverID)&date=\(userDate)"
    let URL = NSURL(string: "\(urlInfo.updateDate)?\(postString)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
    
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
    
    func disconnect(myEmail:String, loverEmail:String, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask? {
        //파라미터를 추가한 URL 생성
        let postString = "myEmail=\(myEmail)&loverEmail=\(loverEmail)"
        let URL = NSURL(string: "\(urlInfo.disconnect)?\(postString)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "PUT"
        request.URL = URL
        
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

    

}

