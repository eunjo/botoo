//
//  ChatViewController.swift
//  Botoo
//
//  Created by 혜인 on 2016. 6. 28..
//  Copyright © 2016년 dolphins. All rights reserved.
//

//
//
// 키보드 관련 - http://hidavidbae.blogspot.kr/2013/12/ios-keyboard.html
//
//

import UIKit

class ChatViewController: UIViewController, KeyboardProtocol {
    
    
    @IBOutlet weak var bgPic: UIImageView!
    
    private var SETTING = 0
    @IBOutlet var toolbarBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatInputTextField: UITextField!
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet var drawerContainer: UIView!
    @IBOutlet var drawerLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var plusContainer: UIView!
    @IBOutlet var emotiContainer: UIView!
    
    private var drawerIsOpen = false
    private var keyboardIsOpen = false
    private var plusIsOpen = false
    private var emoIsOpen = false
    
    private var keyboardHeight = NSUserDefaults.standardUserDefaults().floatForKey("keyboardFrame")
    private var currentKeyboardHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //컨테이너 초기화 (unvisible)
        initContainers()
        
        // 배경 설정 //
        bgPic.layer.zPosition = -1;
        initBackGround()
        
        
        currentKeyboardHeight = 0.0
        
        //키보드에 대한 노티피케이션 생성
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {

        // 배경 초기화
        initBackGround()
    }
    
    func initBackGround(){
        
        // color 설정
        if (NSUserDefaults.standardUserDefaults().boolForKey("ischatBgColor")){
            if (NSUserDefaults.standardUserDefaults().stringForKey("chatBgColor")=="white"){
                self.view.backgroundColor = UIColor.whiteColor()
                bgPic.hidden = true
            }
            if (NSUserDefaults.standardUserDefaults().stringForKey("chatBgColor")=="grey"){
                self.view.backgroundColor = UIColor.grayColor()
                bgPic.hidden = true
            }
            if (NSUserDefaults.standardUserDefaults().stringForKey("chatBgColor")=="lightgrey"){
                self.view.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.95, alpha:1.0)
                bgPic.hidden = true
            }
            if (NSUserDefaults.standardUserDefaults().stringForKey("chatBgColor")=="black"){
                self.view.backgroundColor = UIColor.blackColor()
                bgPic.hidden = true
            }
            if (NSUserDefaults.standardUserDefaults().stringForKey("chatBgColor")=="lightPink"){
                self.view.backgroundColor = UIColor(red:0.99, green:0.89, blue:0.93, alpha:1.0)
                bgPic.hidden = true
            }
            if (NSUserDefaults.standardUserDefaults().stringForKey("chatBgColor")=="lightBlue"){
                self.view.backgroundColor = UIColor(red:0.77, green:0.99, blue:1.00, alpha:1.0)
                bgPic.hidden = true
            }
            
            if (NSUserDefaults.standardUserDefaults().stringForKey("chatBgColor")=="lightPurple"){
                self.view.backgroundColor = UIColor(red:0.91, green:0.85, blue:1.00, alpha:1.0)
                bgPic.hidden = true
            }
            
            if (NSUserDefaults.standardUserDefaults().stringForKey("chatBgColor")=="lightYellow"){
                self.view.backgroundColor = UIColor(red:1.00, green:0.98, blue:0.85, alpha:1.0)
                bgPic.hidden = true
            }
            
        } else if (NSUserDefaults.standardUserDefaults().boolForKey("ischatBgPic")){
            
            let imgData = NSUserDefaults.standardUserDefaults().objectForKey("chatBgPic") as! NSData
            bgPic.image = UIImage(data: imgData)
            bgPic.hidden = false
            
        }
    }
    
    // 채팅창 닫기
    @IBAction func closeOnClick(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func initContainers() {
        drawerContainer.alpha = 0
        self.drawerContainer.transform = CGAffineTransformTranslate(self.drawerContainer.transform, self.drawerContainer.frame.width, 0);
        
        plusContainer.alpha = 0
        self.plusContainer.transform = CGAffineTransformTranslate(self.plusContainer.transform, 0, self.plusContainer.frame.height)
        
        emotiContainer.alpha = 0
        self.emotiContainer.transform = CGAffineTransformTranslate(self.emotiContainer.transform, 0, self.emotiContainer.frame.height)
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
        keyboardIsOpen = show
        
        // 1 노티피케이션 정보 얻기
        var userInfo = notification.userInfo!
        // 2 키보드 사이즈 얻기
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        var changeInHeight = CGRectGetHeight(keyboardFrame)
        
        if (keyboardHeight != Float(CGRectGetHeight(keyboardFrame))) {
            if (keyboardHeight > Float(CGRectGetHeight(keyboardFrame))) {
                keyboardHeight = Float(CGRectGetHeight(keyboardFrame))
            }
        }
        
        if currentKeyboardHeight > 0.0 && currentKeyboardHeight != CGRectGetHeight(keyboardFrame) {
            switch max(currentKeyboardHeight!, CGRectGetHeight(keyboardFrame)) {
                case currentKeyboardHeight!: //자동완성이 내려갈 때
                    changeInHeight = -(currentKeyboardHeight! - CGRectGetHeight(keyboardFrame))
                    break
            case CGRectGetHeight(keyboardFrame): // 올라갈 때
                changeInHeight = CGRectGetHeight(keyboardFrame) - currentKeyboardHeight!
                    break
                default:
                    break
            }
        }
        
        changeInHeight =  changeInHeight * (show ? 1 : -1)
        
        if !plusIsOpen {
            // 3 애니메이션 설정
            let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
            
            UIView.animateWithDuration(animationDurarion, animations: { () -> Void in
                self.toolbarBottomConstraint.constant += changeInHeight
            })
        } else {
            // 키보드가 텍스트 필드를 가리는지 확인
            let allHeight = (self.toolbar.frame.origin.y + self.toolbar.frame.size.height + CGRectGetHeight(keyboardFrame))
            if (self.view.frame.height < allHeight) {
                let gap = (allHeight - self.view.frame.height)
                
                self.deleteGap(gap, isUp: true)
            }
        }
        
        currentKeyboardHeight = CGRectGetHeight(keyboardFrame)
    }
    
    //빈 공간 클릭 시 키보드 하이드
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        if drawerIsOpen {
            hideDrawer()
        }
        
        if plusIsOpen {
            adjustingHeightForPlus(plusIsOpen)
        }
        
        if emoIsOpen {
            adjustingHeightForEmo(emoIsOpen)
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
        
        if plusIsOpen {
            adjustingHeightForPlus(plusIsOpen)
        }
        if (emoIsOpen) {
            adjustingHeightForEmo(emoIsOpen)
        }

        UIView.animateWithDuration(0.7) {
            self.drawerContainer.transform = CGAffineTransformTranslate(self.drawerContainer.transform, -self.drawerContainer.frame.width, 0);
        }
        drawerIsOpen = true
        
        
    }
    
    @IBAction func onClickPlus(sender: UIBarButtonItem) {
   
        adjustingHeightForPlus(plusIsOpen)

    }
    
    func adjustingHeightForPlus(show: Bool) {
        
        if keyboardIsOpen {
            self.view.endEditing(true)
        }
        
        if emoIsOpen {
            adjustingHeightForEmo(emoIsOpen)
        }
        
        show ? (plusIsOpen = false) : (plusIsOpen = true)
        //뷰 사이즈 조절
        self.plusContainer.frame = CGRectMake(0, self.toolbar.frame.origin.y + self.toolbar.frame.size.height, self.plusContainer.frame.size.width, CGFloat(keyboardHeight))
        
        plusContainer.alpha = 1
        
        if drawerIsOpen {
            hideDrawer()
        }
        
        adjustHeightAnimation(show, container: self.plusContainer)
    }
    
    func adjustHeightAnimation(show: Bool, container: UIView) {
        let containerHeight = container.frame.height * (show ? 1 : -1)
        
        let gap = container.frame.origin.y - (self.toolbar.frame.origin.y + self.toolbar.frame.size.height)
        self.deleteGap(gap, isUp: false)
        
        UIView.animateWithDuration(0.5, animations: {
            container.transform = CGAffineTransformTranslate(container.transform, 0, containerHeight)
            if !self.keyboardIsOpen {
                self.toolbar.transform = CGAffineTransformTranslate(self.toolbar.transform, 0, containerHeight)
            }
            }, completion: { finish in
                let gap = container.frame.origin.y - (self.toolbar.frame.origin.y + self.toolbar.frame.size.height)
                self.deleteGap(gap, isUp: false)
                
        })
    }
    
    @IBAction func onClickEmoticon(sender: UIButton) {
        adjustingHeightForEmo(emoIsOpen)
    }
    
    func adjustingHeightForEmo(show: Bool) {
        if keyboardIsOpen {
            self.view.endEditing(true)
        }
        
        if plusIsOpen {
            adjustingHeightForPlus(plusIsOpen)
        }
        
        show ? (emoIsOpen = false) : (emoIsOpen = true)
        //뷰 사이즈 조절
        self.emotiContainer.frame = CGRectMake(0, self.toolbar.frame.origin.y + self.toolbar.frame.size.height, self.emotiContainer.frame.size.width, CGFloat(keyboardHeight))
        
        emotiContainer.alpha = 1
        
        if drawerIsOpen {
            hideDrawer()
        }
        
        adjustHeightAnimation(show, container: self.emotiContainer)
    }
    
    
    func deleteGap(gap: CGFloat, isUp: Bool) {
        if gap != 0.0 {
            UIView.animateWithDuration(0.1,
                    animations: {
                        //위 애니메이션이 완료된 후의 애니메이션
                        //갭 제거하기
                        self.toolbar.transform = CGAffineTransformTranslate(self.toolbar.transform, 0,
                            isUp ? -gap : gap)
                        self.view.layoutIfNeeded()
                }
            )
        }
    }
}
