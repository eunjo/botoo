//
//  connectSceneViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 7. 2..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class connectSceneViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var searchEmailTextField: UITextField!
    @IBOutlet weak var searchResult: UILabel!
    
    var isGot:Bool?
    
    var loverEmailStored:String?
    var loverGenderStored:String?
    var loverNameStored:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    @IBAction func searchButtonTapped(sender: AnyObject) {
        
        let loverEmail:String = searchEmailTextField.text!
        
        // URL Info 객체 생성
        var urlInfoForRegister:URLInfo = URLInfo()
        
        // 유저 정보 받아오기
        urlInfoForRegister.test = urlInfoForRegister.WEB_SERVER_IP+"/checkEmail?email="+loverEmail
        TestConstruct().testConnect(urlInfoForRegister, httpMethod: "GET", params: nil, completionHandler: { (json, error) -> Void in
            self.isGot = true
            self.loverEmailStored = String(json["email"])
            self.loverNameStored = String(json["name"])
            
            self.loverEmailStored = self.loverEmailStored!.stringByReplacingOccurrencesOfString("Optional(", withString: "")
            self.loverEmailStored = self.loverEmailStored!.stringByReplacingOccurrencesOfString(")", withString: "")
            
            self.loverNameStored = self.loverNameStored!.stringByReplacingOccurrencesOfString("Optional(", withString: "")
            self.loverNameStored = self.loverNameStored!.stringByReplacingOccurrencesOfString(")", withString: "")
            
        })
        
        sleep(1)
        searchResult.text = loverNameStored
        
        print("등록안된 이메일일때")
        searchResult.text = "존재하지 않는 사용자입니다"
        return
        
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
