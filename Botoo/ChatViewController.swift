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
import MobileCoreServices
import ContactsUI
import AVFoundation

class ChatViewController: UIViewController, KeyboardProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CNContactPickerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    private let bubbleColor = UIColor(red: 250.0/255, green: 212.0/255, blue: 40.0/255, alpha: 1)
    // 이미지픽커 선언
    var imagePicker = UIImagePickerController()
    var newMedia = Bool?()
    
    @IBOutlet var messageTableView: UITableView!
    
    private var SETTING = 0
    @IBOutlet var toolbarBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatInputTextField: UITextField!
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet var drawerContainer: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var toolbarDrawer: UIView!
    @IBOutlet var plusView: UIView!
    @IBOutlet var emoticonView: UIView!
    
    private var drawerIsOpen = false
    private var keyboardIsOpen = false
    private var plusIsOpen = false
    private var emoIsOpen = false
    
    private var bottomDrawerHeight = 0.0
    private var currentKeyboardHeight: CGFloat?
    
    private let userName = NSUserDefaults.standardUserDefaults().stringForKey("userName")!
    private var userSocketId = ""
    private let userEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")!
    private let userId = NSUserDefaults.standardUserDefaults().stringForKey("userId")!
    private let loverId = NSUserDefaults.standardUserDefaults().stringForKey("loverId")!
    private var chatMessages:[[String : AnyObject]] = []
    private var users = [String]()
    
    struct removeChats {
        static var isRemove = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        //messageTableView 초기화
        initMessageTableView()

        //디바이스 모델 체크 및 키보드 높이 설정
        checkDevice()
        
        //컨테이너 초기화 (unvisible)
        initContainers()
        
        //배경 설정
        initBackGround()
        
        currentKeyboardHeight = 0.0
        
        //키보드에 대한 노티피케이션 생성
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
        
        initSocket()
        getChatMessage()
        
    }
    
    func initMessageTableView() -> Void {
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        messageTableView.estimatedRowHeight = 73.0
        messageTableView.rowHeight = UITableViewAutomaticDimension
        
        let messageTableViewTapped = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.messageTableViewTapped))
        messageTableView.userInteractionEnabled = true
        messageTableView.addGestureRecognizer(messageTableViewTapped)
    }
    
    func getChatMessage() {
        
        ChatConstruct().getMessage(loverId, userId: userId, completionHandler: { (json, error) -> Void in
            if json != nil && json.count != 0 {
                let JsonData = json as! [[String: AnyObject]]
                
                for data in JsonData {
                    FileManager.sharedInstance.writeFile(data["type"]! as! String, text: data["message"]! as! String, sender: data["senderName"] as! String, date: data["date"] as! String)
                }
            }
            
            let messageList = FileManager.sharedInstance.readFile()
            
            if messageList == [] { return }
            
            dispatch_async(dispatch_get_main_queue()) {
                for var message in messageList {
                    if message != "" {
                        message.removeAtIndex(message.endIndex.predecessor())
                        let result = self.convertStringToDictionary(message)
                        self.chatMessages.append(result!)
                    }
                }
                
                self.messageTableView.reloadData()
            }
        })
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    override func viewWillAppear(animated: Bool) {
        // 배경 초기화
        initBackGround()
        
//        FileManager.sharedInstance.initFile()
    }
    
    override func viewDidAppear(animated: Bool) {
        SocketIOManager.sharedInstance.getChatMessage { (messageInfo) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.chatMessages.append(messageInfo)
                self.messageTableView.reloadData()
                self.scrollToBottom()
            })
        }
        self.scrollToBottom()
    }
    
    override func viewWillDisappear(animated: Bool) {
        //유저 소켓 연결 끊기
        exitSocket()
        
        //스레드 돌려 돌려~~ ㅠㅠ
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            if !removeChats.isRemove {
                FileManager.sharedInstance.initFile()
                // write file
                for messageInfo in self.chatMessages {
                    FileManager.sharedInstance.writeFile(messageInfo["type"]! as! String, text: messageInfo["message"]! as! String, sender: messageInfo["nickname"] as! String, date: messageInfo["date"] as! String)
                }
            } else {
                removeChats.isRemove = false
            }
        }
    }
    
    
    func initSocket() {
        // 유저 네임 서버로 보내기
        SocketIOManager.sharedInstance.connectToServerWithNickname(self.userId, nickname: self.userName, completionHandler: { (userList) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if userList != nil {
                    self.users.removeAll()
                    print("채팅 입장.")
                    print(userList)
                    
                    for data in userList {
                        self.users.append("\(data["clientId"]),\(data["isConnected"])")
                    }
//                    users[indexPath.row]["nickname"] as? String
//                    users[indexPath.row]["isConnected"] as! Bool
                }
            })
        })
    }
    
    func exitSocket() {
        SocketIOManager.sharedInstance.exitChatWithNickname(self.userName) { () -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("채팅을 나갑니다.")
            })
        }
    }
    
    func checkDevice() {
        let modelName = UIDevice.currentDevice().modelName
        
        switch modelName {
        case "iPhone 4", "iPhone 4s", "iPhone 5", "iPhone 5s", "iPhone 5c", "iPhone SE":
            self.bottomDrawerHeight = 224.0
            break
        case "iPhone 6", "iPhone 6s":
            self.bottomDrawerHeight = 225.0
            break
        case "iPhone 6 Plus", "iPhone 6s Plus":
            self.bottomDrawerHeight = 236.0
            break
        default:
            self.bottomDrawerHeight = 225.0
            break
        }
    }
    
    func initBackGround(){
        
        if ( !(NSUserDefaults.standardUserDefaults().boolForKey("ischatBgColor")) || !(NSUserDefaults.standardUserDefaults().boolForKey("ischatBgPic")) ){

            messageTableView.backgroundColor = UIColor(patternImage: UIImage(named: "chatBGdefault.png")!)
        }

        // color 설정
        if (NSUserDefaults.standardUserDefaults().boolForKey("ischatBgColor")){
            self.messageTableView.backgroundView = nil
            
            if (NSUserDefaults.standardUserDefaults().stringForKey("chatBgColor")=="white"){
                messageTableView.backgroundColor = UIColor.whiteColor()
            }
            if (NSUserDefaults.standardUserDefaults().stringForKey("chatBgColor")=="grey"){
                messageTableView.backgroundColor = UIColor.grayColor()
            }
            if (NSUserDefaults.standardUserDefaults().stringForKey("chatBgColor")=="lightgrey"){
                messageTableView.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.95, alpha:1.0)
            }
            if (NSUserDefaults.standardUserDefaults().stringForKey("chatBgColor")=="black"){
                messageTableView.backgroundColor = UIColor.blackColor()
            }
            if (NSUserDefaults.standardUserDefaults().stringForKey("chatBgColor")=="lightPink"){
                messageTableView.backgroundColor = UIColor(red:0.99, green:0.89, blue:0.93, alpha:1.0)
            }
            if (NSUserDefaults.standardUserDefaults().stringForKey("chatBgColor")=="lightBlue"){
                messageTableView.backgroundColor = UIColor(red:0.77, green:0.99, blue:1.00, alpha:1.0)
            }
            
            if (NSUserDefaults.standardUserDefaults().stringForKey("chatBgColor")=="lightPurple"){
                messageTableView.backgroundColor = UIColor(red:0.91, green:0.85, blue:1.00, alpha:1.0)
            }
            
            if (NSUserDefaults.standardUserDefaults().stringForKey("chatBgColor")=="lightYellow"){
                messageTableView.backgroundColor = UIColor(red:1.00, green:0.98, blue:0.85, alpha:1.0)
            }
            
        } else if (NSUserDefaults.standardUserDefaults().boolForKey("ischatBgPic")){
            
            let imgData = NSUserDefaults.standardUserDefaults().objectForKey("chatBgPic") as! NSData

            messageTableView.backgroundColor = UIColor(patternImage: UIImage(data: imgData)!)
            messageTableView.contentMode = .ScaleAspectFill

            let image = UIImage(data: imgData)!
            let imageView = UIImageView(frame: CGRectZero)
            
            imageView.contentMode = .ScaleAspectFill
            imageView.image = image
            
            self.messageTableView.backgroundView = imageView

            
        } else if (NSUserDefaults.standardUserDefaults().boolForKey("ischatBGdefalut")){
            
            messageTableView.backgroundColor = UIColor(patternImage: UIImage(named: "chatBGdefault.png")!)
            self.messageTableView.backgroundView = nil
        }
    }
    
    // 채팅창 닫기
    @IBAction func closeOnClick(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func initContainers() {
        drawerContainer.alpha = 0
        self.drawerContainer.transform = CGAffineTransformTranslate(self.drawerContainer.transform, self.drawerContainer.frame.width, 0);
        
        toolbarDrawer.alpha = 0
        plusView.alpha = 0
        emoticonView.alpha = 0
    }
    
    func keyboardWillShow(notification:NSNotification) {
        
        adjustingHeight(true, notification: notification)

        if drawerIsOpen {
            hideDrawer()
        }
        
        self.toolbarDrawer.hidden = true
    }
    
    func keyboardWillHide(notification:NSNotification) {
//        keyboardIsOpen = false
        adjustingHeight(false, notification: notification)
    }

    
    func adjustingHeight(show:Bool, notification:NSNotification) {
        
        keyboardIsOpen = show
        
        // 1 노티피케이션 정보 얻기
        var userInfo = notification.userInfo!
        // 2 키보드 사이즈 얻기
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        var changeInHeight = CGRectGetHeight(keyboardFrame)
        
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
        
        if (!emoIsOpen && !plusIsOpen) {
            // 3 애니메이션 설정
            let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
            
            UIView.animateWithDuration(animationDurarion, animations: { () -> Void in
//                self.toolbarBottomConstraint.constant += changeInHeight
                
                self.toolbar.transform = CGAffineTransformTranslate(self.toolbar.transform, 0, -changeInHeight)
            })
        } else {
            // 키보드가 텍스트 필드를 가리는지 확인
            if keyboardIsOpen {
                let allHeight = (self.toolbar.frame.origin.y + self.toolbar.frame.size.height + CGRectGetHeight(keyboardFrame))
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
        if emoIsOpen {
            adjustingHeightForEmo(emoIsOpen)
        }

        UIView.animateWithDuration(0.5) {
            self.drawerContainer.transform = CGAffineTransformTranslate(self.drawerContainer.transform, -self.drawerContainer.frame.width, 0);
        }
        
        drawerIsOpen = true
        
        
    }
    
    @IBAction func onClickPlus(sender: UIBarButtonItem) {
        adjustingHeightForPlus(plusIsOpen)

    }
    
    func adjustingHeightForPlus(show: Bool) {
        
        show ? (plusIsOpen = false) : (plusIsOpen = true)
        
        if drawerIsOpen {
            hideDrawer()
        }
        
        adjustHeightAnimation(show, container: self.plusView)
        
        if keyboardIsOpen {
            self.view.endEditing(true)
        }
        
        if plusIsOpen && emoIsOpen {
            emoIsOpen = false
            self.emoticonView.alpha = 0.0
        }
    }
    
    func adjustHeightAnimation(show: Bool, container: UIView) {
        
        self.toolbarDrawer.hidden = false
        
        var frame = self.toolbarDrawer.frame
        frame.origin.y = UIScreen.mainScreen().bounds.height - CGFloat(self.bottomDrawerHeight)
        frame.size.height = CGFloat(self.bottomDrawerHeight)
        self.toolbarDrawer.frame = frame;
        
        let containerHeight = self.toolbarDrawer.frame.height * (show ? 1 : -1)
        
        UIView.animateWithDuration(0.3, animations: {
            show ? (self.toolbarDrawer.alpha = 0.0) : (self.toolbarDrawer.alpha = 1.0)
            show ? (container.alpha = 0.0) : (container.alpha = 1.0)
            if !self.keyboardIsOpen {
                if show  {
                    let gap = self.toolbarDrawer.frame.origin.y - (self.toolbar.frame.origin.y + self.toolbar.frame.size.height)
                    self.deleteGap(gap, isUp: false)
                }
                
                if !(self.plusIsOpen && self.emoIsOpen) {
                    self.toolbar.transform = CGAffineTransformTranslate(self.toolbar.transform, 0, containerHeight)
                }
            }
            }, completion: { finish in
                if !show {
                    if !(self.plusIsOpen && self.emoIsOpen) {
                        let gap = self.toolbarDrawer.frame.origin.y - (self.toolbar.frame.origin.y + self.toolbar.frame.size.height)
                        self.deleteGap(gap, isUp: false)
                    }
                }
        })
    }
    
    @IBAction func onClickEmoticon(sender: UIButton) {
        adjustingHeightForEmo(emoIsOpen)
    }
    
    func adjustingHeightForEmo(show: Bool) {
        
        show ? (emoIsOpen = false) : (emoIsOpen = true)
        
        if drawerIsOpen {
            hideDrawer()
        }
        
        adjustHeightAnimation(show, container: self.emoticonView)
        
        if keyboardIsOpen {
            self.view.endEditing(true)
        }
        
        if plusIsOpen && emoIsOpen {
            plusIsOpen = false
            self.plusView.alpha = 0.0
        }
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
    
    
    //plus 버튼 클릭 구현
    
    @IBAction func onClickPlusPic(sender: UIButton) {
        pickPic()
    }
    
    @IBAction func onClickPlusVideo(sender: UIButton) {
        pickPic()
    }
    
    func pickPic() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        //Action 추가
        let firstAction = UIAlertAction(title: "사진 앨범에서 선택", style: .Default) { (alert: UIAlertAction!) -> Void in
            //사진 라이브러리 소스를 선택
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            //수정 가능 옵션
            self.imagePicker.allowsEditing = true
//            self.imagePicker.mediaTypes = [kUTTypeMovie as String]
            self.presentViewController(self.imagePicker, animated: false, completion: nil)
        }
        
        let secondAction = UIAlertAction(title: "취소", style: .Cancel) { (alert: UIAlertAction!) -> Void in
        }
        
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        
        presentViewController(alert, animated: true, completion:nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true) { (_) in
            let resiziedImage = self.resizeImage((info[UIImagePickerControllerOriginalImage] as? UIImage)!, newWidth: CGFloat(700))
            
            let Imagedata = UIImageJPEGRepresentation(resiziedImage, 0.5)
            let base64String = Imagedata!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
            
            SocketIOManager.sharedInstance.sendMessage("pic", message: base64String, withNickname: self.userName, to: NSUserDefaults.standardUserDefaults().stringForKey("loverName")!)
            
            dispatch_async(dispatch_get_main_queue()) {
                
                /**
                 테이블뷰에 추가
                 //내가 보낸 메세지는 소켓을 거치지 않고 클라이언트에서 처리
                 **/
                self.chatMessages.append(self.convertStringToDictionary("{\"type\":\"pic\",\"message\":\"\(base64String)\",\"nickname\":\"\(self.userName)\",\"date\":\"\(self.getCurrentDate_client())\"}")!)
                self.messageTableView.reloadData()
                
                //메세지 서버에 저장
                self.saveMessage(base64String, type: "pic")
                
                self.scrollToBottom()
            }
        }
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    @IBAction func onClickPlusCam(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            imagePicker.mediaTypes = NSArray(object: kUTTypeImage) as! [String]
            self.presentViewController(imagePicker, animated: true, completion: nil)
            newMedia = true 
        }
    }
    
    @IBAction func onClickPlusContact(sender: UIButton) {
        let peoplePicker = CNContactPickerViewController()
        
        peoplePicker.delegate = self
        
       // var store = CNContactStore()
       // let selectedContact:CNMutableContact?
        self.presentViewController(peoplePicker, animated: true, completion: nil)
    }
    
    func contactPickerDidCancel(picker: CNContactPickerViewController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        let MobNumVar = (contact.phoneNumbers[0].value as! CNPhoneNumber).valueForKey("digits") as! String
        let ContactString = "{\'givenName\':\'\(contact.givenName)\',\'familyName\':\'\(contact.familyName)\',\'MobNumVar\':\'\(MobNumVar)\'}"
        
        SocketIOManager.sharedInstance.sendMessage("contact", message: ContactString, withNickname: self.userName, to: NSUserDefaults.standardUserDefaults().stringForKey("loverName")!)
        
        
        dispatch_async(dispatch_get_main_queue()) {
            /**
             테이블뷰에 추가
             //내가 보낸 메세지는 소켓을 거치지 않고 클라이언트에서 처리
             **/
            self.chatMessages.append(self.convertStringToDictionary("{\"type\":\"contact\",\"message\":\"\(ContactString)\",\"nickname\":\"\(self.userName)\",\"date\":\"\(self.getCurrentDate_client())\"}")!)
            
            //메세지 서버에 저장
            self.saveMessage(ContactString, type: "contact")
            
            self.messageTableView.reloadData()
            self.scrollToBottom()
        }
    }
 

    // 전송 버튼
    @IBAction func sendButtonTapped(sender: AnyObject) {
        if chatInputTextField.text!.characters.count > 0 {
            let message = chatInputTextField.text!
            SocketIOManager.sharedInstance.sendMessage("text", message: message, withNickname: self.userName, to: NSUserDefaults.standardUserDefaults().stringForKey("loverName")!)
            
            chatInputTextField.text = ""
            chatInputTextField.resignFirstResponder()
            
            dispatch_async(dispatch_get_main_queue()) {
                /**
                    테이블뷰에 추가
                    //내가 보낸 메세지는 소켓을 거치지 않고 클라이언트에서 처리
                **/
                self.chatMessages.append(self.convertStringToDictionary("{\"type\":\"text\",\"message\":\"\(message)\",\"nickname\":\"\(self.userName)\",\"date\":\"\(self.getCurrentDate_client())\"}")!)
                
                //메세지 서버에 저장
                self.saveMessage(message, type: "text")
                
                self.messageTableView.reloadData()
                self.scrollToBottom()
            }
        }
    }
    
    func getCurrentDate_client() -> String {
        
        let format = NSDateFormatter()
        format.locale = NSLocale(localeIdentifier: "ko_kr")
        format.timeZone = NSTimeZone(name: "KST")
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        let date = format.stringFromDate(NSDate())
        
        return date[date.startIndex.advancedBy(11)...date.startIndex.advancedBy(15)]
    }
    
    func saveMessage(message: String, type: String) {
        if !self.findUser(self.users, find: self.loverId) {
            
            let messageInfo = [
                "senderId": self.userId as String,
                "receiverId": self.loverId as String,
                "message": message,
                "type": type
            ]
            
            ChatConstruct().saveMessage(messageInfo, completionHandler: { (json, error) -> Void in
                
            })
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatMessages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let message = self.chatMessages[indexPath.row]["message"] as? String
        let name = self.chatMessages[indexPath.row]["nickname"] as? String
        let date = self.chatMessages[indexPath.row]["date"] as? String
        let type = self.chatMessages[indexPath.row]["type"] as! String
        
        switch type {
        case "text":
            if self.chatMessages[indexPath.row]["nickname"] as? String == userName { // 내가 보낸 메세지
                var cell = tableView.dequeueReusableCellWithIdentifier("ChatTableViewCellm") as? ChatTableViewCellm
                
                if cell == nil {
                    tableView.registerNib(UINib(nibName: "UIChatTableViewCellm", bundle: nil), forCellReuseIdentifier: "ChatTableViewCellm")
                    cell = tableView.dequeueReusableCellWithIdentifier("ChatTableViewCellm") as? ChatTableViewCellm
                }
                
                cell?.messageBubble.text = message
                cell?.nameLabel.text = name
                cell?.dateLabel.text = date!
//                cell?.dateLabel.text = "00:00"
                
                cell?.messageBubble.backgroundColor = bubbleColor
                
                return cell!
                
            } else { // 상대방 메세지
                var cell = tableView.dequeueReusableCellWithIdentifier("ChatTableViewCell") as? ChatTableViewCell
                
                if cell == nil {
                    tableView.registerNib(UINib(nibName: "UIChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
                    cell = tableView.dequeueReusableCellWithIdentifier("ChatTableViewCell") as? ChatTableViewCell
                }
                
                cell?.messageBubble.text = message
                cell?.nameLabel.text = name
//                cell?.dateLabel.text = dateToString(date!)
                cell?.dateLabel.text = "00:00"
                
                cell?.messageBubble.backgroundColor = bubbleColor
                
                return cell!
            }
        case "contact":
            if self.chatMessages[indexPath.row]["nickname"] as? String == userName { // 내가 보낸 메세지
                
                var cell = tableView.dequeueReusableCellWithIdentifier("ChatContactTableViewCell") as? ChatContactTableViewCell
                
                if cell == nil {
                    tableView.registerNib(UINib(nibName: "UIChatContactCell", bundle: nil), forCellReuseIdentifier: "ChatContactTableViewCell")
                    cell = tableView.dequeueReusableCellWithIdentifier("ChatContactTableViewCell") as? ChatContactTableViewCell
                }
                
                let replacedMsg = message!.stringByReplacingOccurrencesOfString("\'", withString: "\"")
                
                let messageDic = convertStringToDictionary(replacedMsg)
                
                let givenName = messageDic!["givenName"]!
                let familyName = messageDic!["familyName"]!
                let MobNumVar = messageDic!["MobNumVar"]!
                
                cell?.nameLabel.text = name
                cell?.contactButton.setTitle("\(givenName) \(familyName)", forState: .Normal)
                cell?.setData(givenName as! String, fN: familyName as! String, pN: MobNumVar as! String)
                
                return cell!
                
            } else { // 상대방 메세지
                
                var cell = tableView.dequeueReusableCellWithIdentifier("ChatContactTableViewCellL") as? ChatContactTableViewCellL
                
                if cell == nil {
                    tableView.registerNib(UINib(nibName: "UIChatContactCell", bundle: nil), forCellReuseIdentifier: "ChatContactTableViewCellL")
                    cell = tableView.dequeueReusableCellWithIdentifier("ChatContactTableViewCellL") as? ChatContactTableViewCellL
                }
                
                let messageDic = convertStringToDictionary(message!)
                
                let givenName = messageDic!["givenName"]!
                let familyName = messageDic!["familyName"]!
                let MobNumVar = messageDic!["MobNumVar"]!
                
                cell?.nameLabel.text = name
                cell?.contactButton.setTitle("\(givenName) \(familyName)", forState: .Normal)
                cell?.setData(givenName as! String, fN: familyName as! String, pN: MobNumVar as! String)
                
                return cell!

                
            }
        case "pic":
            if self.chatMessages[indexPath.row]["nickname"] as? String == userName { // 내가 보낸 메세지
                var cell = tableView.dequeueReusableCellWithIdentifier("ChatPicTabelViewCell") as? ChatPicTabelViewCell
                
                if cell == nil {
                    tableView.registerNib(UINib(nibName: "UIChatPicCell", bundle: nil), forCellReuseIdentifier: "ChatPicTabelViewCell")
                    cell = tableView.dequeueReusableCellWithIdentifier("ChatPicTabelViewCell") as? ChatPicTabelViewCell
                }
                
                cell?.name.text = name
                cell?.date.text = date!
                
                dispatch_async(dispatch_get_main_queue()) {
                    //이미지 디코딩
                    let dataDecoded:NSData = NSData(base64EncodedString: message!, options: NSDataBase64DecodingOptions(rawValue: 0))!
                    let decodedimage:UIImage = UIImage(data: dataDecoded)!
                    cell?.pic.image = decodedimage
                    
                    //이미지 확대
                    let tap_2 = UITapGestureRecognizer(target:self, action: #selector(ChatViewController.picTapped(_:)))
                    cell?.pic.userInteractionEnabled = true
                    cell?.pic.addGestureRecognizer(tap_2)
                }
                
                return cell!

                
            } else { // 상대방 메세지
                var cell = tableView.dequeueReusableCellWithIdentifier("ChatPicTabelViewCellm") as? ChatPicTabelViewCellm
                
                if cell == nil {
                    tableView.registerNib(UINib(nibName: "UIChatPicCellm", bundle: nil), forCellReuseIdentifier: "ChatPicTabelViewCellm")
                    cell = tableView.dequeueReusableCellWithIdentifier("ChatPicTabelViewCellm") as? ChatPicTabelViewCellm
                }
                
                cell?.name.text = name
//                cell?.date.text = dateToString(date!)
                cell?.date.text = "00:00"
                
                dispatch_async(dispatch_get_main_queue()) {
                    //이미지 디코딩
                    let dataDecoded:NSData = NSData(base64EncodedString: message!, options: NSDataBase64DecodingOptions(rawValue: 0))!
                    let decodedimage:UIImage = UIImage(data: dataDecoded)!
                    cell?.pic.image = decodedimage
                    
                    //이미지 확대
                    let tap_2 = UITapGestureRecognizer(target:self, action: #selector(ChatViewController.picTapped(_:)))
                    cell?.pic.userInteractionEnabled = true
                    cell?.pic.addGestureRecognizer(tap_2)
                }
                
                return cell!

            }        default:
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndeerxPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func dateToString(dateString: String) -> String {
        var date = dateString
        date.replaceRange(date.startIndex.advancedBy(24)..<date.startIndex.advancedBy(24 + 15), with: "")
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "KST")
        dateFormatter.dateFormat = "EEE MMM dd yyyy HH:mm:ss"
        let Date = dateFormatter.dateFromString(date)
        
        print(date)
        
        // 날짜 년 월 일 로 포맷변환
        let cal = NSCalendar(calendarIdentifier:NSCalendarIdentifierGregorian)!
        let comp = cal.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate:Date!)
        let new_minute:String
        
        if (comp.minute < 10){
            new_minute = "0\(comp.minute)"
        } else {
            new_minute = String(comp.minute)
        }
        let dateToString:String = "\(comp.hour):\(new_minute)"
        
        return dateToString
    }
    
    func scrollToBottom() {
        let numberOfSections = self.messageTableView.numberOfSections
        let numberOfRows = self.messageTableView.numberOfRowsInSection(numberOfSections-1)
        
        if numberOfRows > 0 {
            let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
            self.messageTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        }
    }
    
    func findUser(users: [String]!, find: String!) -> Bool! {
        
        //리스트 정렬
        var usersTemp = users.sort()
        var usersTempMiddleId:[String]! = []
        let find = "Optional(\(find))"
        
        while usersTemp.count > 1 {
            
            usersTempMiddleId = usersTemp[usersTemp.count/2].componentsSeparatedByString(",")
            
            //가운데 요소와 비교
            if usersTempMiddleId[0] > find {
                usersTemp = Array(usersTemp[0 ..< usersTemp.count/2])
            } else if usersTempMiddleId[0] < find {
                usersTemp = Array(usersTemp[usersTemp.count/2 ..< usersTemp.count])
            } else if usersTempMiddleId[0] == find {
                print("FIND! : \(usersTempMiddleId[0])")
                if usersTempMiddleId[1] == "1" {
                    print("ONLINE")
                    return true
                } else {
                    print("OFFLINE")
                    return false
                }
            }
        }
        
        print("OFFLINE")
        return false
    }
    
    func messageTableViewTapped() {
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
    
    func picTapped(sender:UITapGestureRecognizer) {
        self.performSegueWithIdentifier("picZoomSeg", sender: sender.view)
        if let connectingViewController = self.storyboard?.instantiateViewControllerWithIdentifier("imageZoomViewController") {
            connectingViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            self.presentViewController(connectingViewController, animated: true, completion: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "picZoomSeg") {
            let svc = segue.destinationViewController as! imageZoomViewController
            svc.newImage = sender!.image
        }
    }
}