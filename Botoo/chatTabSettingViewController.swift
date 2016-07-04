//
//  chatTabSettingViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 7. 4..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class chatTabSettingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var colorBGset: UILabel!
    @IBOutlet weak var picBGset: UILabel!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(chatTabSettingViewController.colorBGsetting(_:)))
        colorBGset.userInteractionEnabled = true
        colorBGset.addGestureRecognizer(tap)
        
        let tap_2 = UITapGestureRecognizer(target: self, action: #selector(chatTabSettingViewController.picBGsetting(_:)))
        picBGset.userInteractionEnabled = true
        picBGset.addGestureRecognizer(tap_2)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func colorBGsetting(sender:UITapGestureRecognizer){
        
        if let connectingViewController = self.storyboard?.instantiateViewControllerWithIdentifier("colorBGset") {
            connectingViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            self.presentViewController(connectingViewController, animated: true, completion: nil)
        }
        
        
    }
    
    func picBGsetting(sender:UITapGestureRecognizer){
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        //Action 추가
        let firstAction = UIAlertAction(title: "사진 앨범에서 선택", style: .Default) { (alert: UIAlertAction!) -> Void in
            //사진 라이브러리 소스를 선택
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            //수정 가능 옵션
            self.imagePicker.allowsEditing = true
            //델리게이트 지정
            self.presentViewController(self.imagePicker, animated: false, completion: nil)
        }
        
        let secondAction = UIAlertAction(title: "기본 이미지로 변경", style: .Default) { (alert: UIAlertAction!) -> Void in
            NSUserDefaults.standardUserDefaults().setObject(true, forKey: "ischatBgColor")
            NSUserDefaults.standardUserDefaults().setObject("white", forKey: "chatBgColor")
        }
        
        let thirdAction = UIAlertAction(title: "취소", style: .Cancel) { (alert: UIAlertAction!) -> Void in
            
        }
        
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        alert.addAction(thirdAction)
        
        presentViewController(alert, animated: true, completion:nil)
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image = UIImage() //Change to be from UIPicker
        let data = UIImagePNGRepresentation(image)
        NSUserDefaults.standardUserDefaults().setObject(true, forKey: "ischatBgPic")
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "chatBgPic")

        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
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
