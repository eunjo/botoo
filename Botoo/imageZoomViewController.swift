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
    var isZoomed:Bool = false
    
    var newImage: UIImage!
    var scrollImageView:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ImageForZoom.hidden = true
        
        // image 보여주기
        ImageForZoom.image = newImage
        
        //ImageScrollView.
        
        scrollView.maximumZoomScale = 5.0
        scrollView.minimumZoomScale = 0.5
        scrollView.delegate = self

        var rate:CGFloat = 1
        var yposition:CGFloat = 0
        
        // sizing
        if (newImage != nil){
            var width = newImage.size.width
            var height = newImage.size.height
            rate = height/width
            
            yposition = (ImageForZoom.bounds.height - (ImageForZoom.bounds.width*rate))/2
            
        }
        
        scrollImageView = UIImageView(frame: CGRect(x:0, y: yposition, width: ImageForZoom.bounds.width, height: ImageForZoom.bounds.width*rate))
        scrollImageView!.image = newImage
        
        //double tap
        var doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(doubleTapRecognizer)
        
        scrollView!.addSubview(scrollImageView!)

        
        
        if (isProPic == true){
            
            saveImage.hidden = true
        }
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return scrollImageView
    }
    
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        
        if (isZoomed == false){
                    // 1
        let pointInView = recognizer.locationInView(scrollImageView)
        
        // 2
        var newZoomScale = scrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
        
        // 3
        let scrollViewSize = scrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRectMake(x, y, w, h);
        
        // 4
        scrollView.zoomToRect(rectToZoomTo, animated: true)
            
        isZoomed = true
            
        } else {
            
            // 1
            let pointInView = recognizer.locationInView(scrollImageView)
            
            // 2
            var newZoomScale = scrollView.zoomScale / 1.5
            newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
            
            // 3
            let scrollViewSize = scrollView.bounds.size
            let w = scrollViewSize.width / newZoomScale
            let h = scrollViewSize.height / newZoomScale
            let x = pointInView.x - (w / 2.0)
            let y = pointInView.y - (h / 2.0)
            
            let rectToZoomTo = CGRectMake(x, y, w, h);
            
            // 4
            scrollView.zoomToRect(rectToZoomTo, animated: true)
            
            isZoomed = false

        }
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
