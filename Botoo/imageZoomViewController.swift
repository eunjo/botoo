//
//  imageZoomViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 7. 4..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class imageZoomViewController: UIViewController {

    @IBOutlet weak var ImageForZoom: UIImageView!
    
    var newImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // image 보여주기
        ImageForZoom.image = newImage

    }

    @IBAction func closeButtonTapped(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func imageZoom(sender: UIPinchGestureRecognizer) {
        
        self.view.transform = CGAffineTransformScale(self.view.transform, sender.scale, sender.scale)
        sender.scale = 1
    }
}
