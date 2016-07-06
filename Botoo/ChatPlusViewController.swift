//
//  ChatPlusViewController.swift
//  Botoo
//
//  Created by 혜인 on 2016. 7. 4..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit
import MobileCoreServices

class ChatPlusViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        
        
    }
    
    @IBAction func sendPicButtonTapped(sender: AnyObject){
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        //Action 추가
        let firstAction = UIAlertAction(title: "사진 앨범에서 선택", style: .Default) { (alert: UIAlertAction!) -> Void in
            //사진 라이브러리 소스를 선택
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            //수정 가능 옵션
            self.imagePicker.allowsEditing = true
            self.imagePicker.mediaTypes = [kUTTypeImage as String]
            self.presentViewController(self.imagePicker, animated: false, completion: nil)
        }
        
        let secondAction = UIAlertAction(title: "취소", style: .Cancel) { (alert: UIAlertAction!) -> Void in
        }
        
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        
        presentViewController(alert, animated: true, completion:nil)
        
        
    }

    @IBAction func sendVideoButtonTapped(sender: AnyObject) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        //Action 추가
        let firstAction = UIAlertAction(title: "사진 앨범에서 선택", style: .Default) { (alert: UIAlertAction!) -> Void in
            //사진 라이브러리 소스를 선택
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            //수정 가능 옵션
            self.imagePicker.allowsEditing = true
            self.imagePicker.mediaTypes = [kUTTypeMovie as String]
            self.presentViewController(self.imagePicker, animated: false, completion: nil)
        }
        
        let secondAction = UIAlertAction(title: "취소", style: .Cancel) { (alert: UIAlertAction!) -> Void in
        }
        
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        
        presentViewController(alert, animated: true, completion:nil)

        
        
    }

    @IBAction func sendCamPicButtonTapped(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
        
    }

    
    @IBAction func contactsButtonTapped(sender: AnyObject) {
        
        // http://stackoverflow.com/questions/24752627/accessing-ios-address-book-with-swift-array-count-of-zero 참고
    
    
    }
    
    @IBAction func sendLocationButtonTapped(sender: AnyObject) {
        
        
    }

    @IBAction func sendRecButtonTapped(sender: AnyObject) {
        
        
    }
    
    
    
    
}
