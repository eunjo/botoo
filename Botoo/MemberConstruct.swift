//
//  TestConstruct.swift
//  Botoo
//
//  Created by 혜인 on 2016. 7. 11..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import Foundation
import UIKit

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
                    completionHandler("success", nil)
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
            
            print(response)
            //statusCode가 200인건 성공적으로 json을 파싱했다는것임.
            if (statusCode == 200) {
                do{
                    completionHandler("success", nil)
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        
        
        //task 실행
        task.resume()
        return task
    }
    
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
    
    func saveProPic(userEmail: Dictionary<String,String>?, proPic: UIImage, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask? {
        //파라미터를 추가한 URL 생성
        let URL = NSURL(string: "\(urlInfo.saveProPic)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        request.URL = URL
        
        if (userEmail != nil){
            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(userEmail!, options: [])
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
    
    /*
    func setProPicDefault(myEmail:String, proPic:UIImage, completionHandler: (AnyObject!, NSError?) -> Void) -> NSURLSessionTask? {
        //파라미터를 추가한 URL 생성
        let postString = "myEmail=\(myEmail)"
        let URL = NSURL(string: "\(urlInfo.setProPicDefault)?\(postString)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "PUT"
        request.URL = URL
        
        var imageData = UIImageJPEGRepresentation(proPic, 1.0)
        var base64String = imageData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        var params = ["image":[ "content_type": "image/jpeg", "filename":"\(myEmail).jpg", "file_data": base64String]]
        
        request.HTTPBody = try! (NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions(rawValue: 0)))
        
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            print(response)
            //statusCode가 200인건 성공적으로 json을 파싱했다는것임.
            if (statusCode == 200) {
                do{
                    completionHandler("success", nil)
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        
        
        //task 실행
        task.resume()
        return task
    }
*/  
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

<<<<<<< HEAD
=======


>>>>>>> 3bd503eafc81f6943caa6bae8776933fca3d0199
}

