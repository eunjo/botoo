//
//  imageZoomViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 7. 4..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class imageZoomViewController: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var ImageForZoom: UIImageView!
  
    @IBOutlet weak var saveImage: UIButton!

    
    var newImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        
        // image 보여주기
        ImageForZoom.image = newImage
       self.ImageForZoom.contentMode = UIViewContentMode.ScaleAspectFit
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
       

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
