//
//  imageZoomViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 7. 4..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit


class imageZoomViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ImageForZoom: UIImageView!
    
    @IBOutlet weak var saveImage: UIButton!
    
    var isProPic:Bool?
    
    var newImage: UIImage!
    var scrollImageView:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ImageForZoom.hidden = true
        
        // image 보여주기
        ImageForZoom.image = newImage
        
        //ImageScrollView.
        scrollImageView = UIImageView(frame: ImageForZoom.bounds)
        scrollImageView!.image = newImage
        
        scrollView!.addSubview(scrollImageView!)

        
        
        if (isProPic == true){
            
            saveImage.hidden = true
        }
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return scrollImageView
    }
    
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func imageZoom(sender: UIPinchGestureRecognizer) {
        
        self.ImageForZoom.transform = CGAffineTransformScale(self.ImageForZoom.transform, sender.scale, sender.scale)
        sender.scale = 1.0
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        UIImageWriteToSavedPhotosAlbum(ImageForZoom.image!, nil, nil, nil);
        
        let myAlert = UIAlertController(title:"알림", message: "사진이 저장되었습니다.", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title:"확인", style:UIAlertActionStyle.Default, handler:nil)
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
}
