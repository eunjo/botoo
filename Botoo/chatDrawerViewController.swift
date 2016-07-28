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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(chatDrawerViewController.onClickAlbum(_:)))
        albumCollectionView.userInteractionEnabled = true
        albumCollectionView.addGestureRecognizer(tap)
        
        let tap_2 = UITapGestureRecognizer(target: self, action: #selector(chatDrawerViewController.onClickSetting(_:)))
        settingView.userInteractionEnabled = true
        settingView.addGestureRecognizer(tap_2)
        
        let tap_3 = UITapGestureRecognizer(target: self, action: #selector(chatDrawerViewController.onClickRemove(_:)))
        removeFile.userInteractionEnabled = true
        removeFile.addGestureRecognizer(tap_3)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var albumCollectionView: UIView!

    func onClickAlbum(sender: UITapGestureRecognizer){
        
        /*
        if let connectingViewController = self.storyboard?.instantiateViewControllerWithIdentifier("albumViewController") {
            connectingViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            self.presentViewController(connectingViewController, animated: true, completion: nil)
        }
        */
        
        let viewController: UIViewController?
        
        viewController = self.storyboard?.instantiateViewControllerWithIdentifier("albumViewController")
        
        if(viewController != nil) {
            viewController!.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            //navigationController 의 하위 뷰로 전환
            self.navigationController?.pushViewController(viewController!, animated: true)
        }

        
        
    }
    
    @IBOutlet weak var settingView: UIView!
    
    func onClickSetting(sender: UITapGestureRecognizer){
        
        let viewController: UIViewController?
        
        viewController = self.storyboard?.instantiateViewControllerWithIdentifier("chatTabSettingViewController")
        
        if(viewController != nil) {
            viewController!.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            //navigationController 의 하위 뷰로 전환
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
        
    }
    
    @IBOutlet weak var removeFile: UILabel!
    
    func onClickRemove(sender: UITapGestureRecognizer){
        
        let myAlert = UIAlertController(title:"Alert", message: "대화내용을 모두 삭제합니다.", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.Default, handler:nil)
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
        FileManager.sharedInstance.initFile()
        
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
