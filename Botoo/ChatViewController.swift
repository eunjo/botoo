//
//  ChatViewController.swift
//  Botoo
//
//  Created by 혜인 on 2016. 6. 28..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet var toolbarBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatInputTextField: UITextField!
    @IBOutlet var drawerContainer: UIView!
    @IBOutlet var drawerLeadingConstraint: NSLayoutConstraint!
    
    private var drawerIsOpen = false
    private var keyboardIsOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        drawerContainer.alpha = 0
        self.drawerContainer.transform = CGAffineTransformTranslate(self.drawerContainer.transform, self.drawerContainer.frame.width, 0);
        //키보드에 대한 노티피케이션 생성
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    @IBAction func closeOnClick(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func keyboardWillShow(notification:NSNotification) {
        adjustingHeight(true, notification: notification)
        
        if drawerIsOpen {
            hideDrawer()
        }
    }
    
    func keyboardWillHide(notification:NSNotification) {
        adjustingHeight(false, notification: notification)
    }

    
    func adjustingHeight(show:Bool, notification:NSNotification) {
        /** 
         
         텍스트 자동 완성 시 keyboardWillShow 호출 - 해결하기
         
         **/
        keyboardIsOpen = show
        // 1 노티피케이션 정보 얻기
        var userInfo = notification.userInfo!
        // 2 키보드 사이즈 얻기
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        // 3 애니메이션 설정
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        // 4
        let changeInHeight = CGRectGetHeight(keyboardFrame) * (show ? 1 : -1)
        //5
        UIView.animateWithDuration(animationDurarion, animations: { () -> Void in
            self.toolbarBottomConstraint.constant += changeInHeight
        })
    }
    
    //빈 공간 클릭 시 키보드 하이드
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        if drawerIsOpen {
            hideDrawer()
        }
    }
    
    @IBAction func swipeLeft(sender: UISwipeGestureRecognizer) {
        if !drawerIsOpen {
            openDrawer()
        }
    }
    
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        if drawerIsOpen {
            hideDrawer()
        }
    }
    
    @IBAction func onClickDrawer(sender: UIBarButtonItem) {
        drawerIsOpen ? hideDrawer() : openDrawer()
    }
    
    func hideDrawer() {
        UIView.animateWithDuration(0.7) {
            self.drawerContainer.transform = CGAffineTransformTranslate(self.drawerContainer.transform, self.drawerContainer.frame.width, 0);
        }
        drawerIsOpen = false
    }
    
    func openDrawer() {
        drawerContainer.alpha = 1
        if keyboardIsOpen {
            self.view.endEditing(true)
        }

        UIView.animateWithDuration(0.7) {
            self.drawerContainer.transform = CGAffineTransformTranslate(self.drawerContainer.transform, -self.drawerContainer.frame.width, 0);
        }
        drawerIsOpen = true
    }
    
    @IBAction func onClickPlus(sender: UIBarButtonItem) {
    }
    
}
