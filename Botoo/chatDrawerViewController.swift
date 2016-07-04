//
//  chatDrawerViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 7. 4..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class chatDrawerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(chatDrawerViewController.onClickAlbum))
        albumCollectionView.userInteractionEnabled = true
        albumCollectionView.addGestureRecognizer(tap)
        
        let tap_2 = UITapGestureRecognizer(target: self, action: #selector(chatDrawerViewController.onClickSetting))
        settingView.userInteractionEnabled = true
        settingView.addGestureRecognizer(tap_2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var albumCollectionView: UIView!

    func onClickAlbum(){
        
        if let connectingViewController = self.storyboard?.instantiateViewControllerWithIdentifier("albumViewController") {
            connectingViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            self.presentViewController(connectingViewController, animated: true, completion: nil)
        }

        
        
    }
    
    @IBOutlet weak var settingView: UIView!
    
    func onClickSetting(){
        
        let viewController: UIViewController?
        
        viewController = self.storyboard?.instantiateViewControllerWithIdentifier("chatTabSettingViewController")
        
        if(viewController != nil) {
            viewController!.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            //navigationController 의 하위 뷰로 전환
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
        
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
