//
//  LetterViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 6. 29..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class LetterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var letterTable: UITableView!
    
    @IBOutlet weak var editItem: UIBarButtonItem!
    @IBOutlet weak var addItem: UIBarButtonItem!
    

    
    var letterList:[letterTableVO] = []

    var userId =  NSUserDefaults.standardUserDefaults().stringForKey("userId")

    var isReadCount:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.letterTable.delegate = self
        self.letterTable.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        NSUserDefaults.standardUserDefaults().setObject(self.isReadCount, forKey: "letterBadge")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        if !Reachability.isConnectedToNetwork() {
            self.presentViewController(Reachability.alert(), animated: true, completion: nil)
        } else {
            if (NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")){
                self.userId =  NSUserDefaults.standardUserDefaults().stringForKey("userId")!
            }
            if NSUserDefaults.standardUserDefaults().stringForKey("userConnectId") != "nil" {
                LetterConstruct().callLetter(NSUserDefaults.standardUserDefaults().stringForKey("userConnectId")!,
                                             completionHandler: { (json, error) -> Void in
                                                
                                                if json == nil || json.count == 0 {
                                                    
                                                } else {
                                                    let JsonData = json as! [[String: AnyObject]]
                                                    
                                                    self.isReadCount = 0
                                                    self.letterList = []
                                                    for data in JsonData {
                                                        self.letterList.append(letterTableVO(writerId: data["senderId"] as! String, title: data["title"] as! String, writerImage: data["sender"] as! String, letterId: data["_id"] as! String, date: data["date"] as! String, body: data["body"] as! String, isRead: Int(data["isRead"] as! String)!))
                                                        
                                                        if(Int(data["isRead"] as! String) == 0 && self.userId != data["senderId"] as! String){
                                                            self.isReadCount += 1
                                                            NSUserDefaults.standardUserDefaults().setObject(self.isReadCount, forKey: "letterBadge")
                                                        }
                                                    }
                                                    
                                                    dispatch_async(dispatch_get_main_queue()) {
                                                        
                                                        self.letterTable.reloadData()
                                                    }
                                                }
                })
            }
            
            // write 한 편지 reload
            if LetterrWriteViewController.getNewLetterInfo.letterInfo != nil {
                self.letterList.append(LetterrWriteViewController.getNewLetterInfo.letterInfo!)
                LetterrWriteViewController.getNewLetterInfo.letterInfo = nil
                self.letterTable.reloadData()
            }

        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return letterList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("LetterTableViewCell", forIndexPath: indexPath)
        (cell.viewWithTag(100) as! UILabel).text = letterList[indexPath.row].title
        (cell.viewWithTag(200) as! UILabel).text = letterList[indexPath.row].date
        
        if letterList[indexPath.row].writerImage == "1" {
            (cell.viewWithTag(101) as! UIImageView).image = UIImage(named: "default_female.png")
        } else {
            (cell.viewWithTag(101) as! UIImageView).image = UIImage(named: "default_male.png")
        }
        
        if letterList[indexPath.row].isRead == 0 { // 안 읽은 경우
            (cell.viewWithTag(300) as! UIImageView).hidden = false
        }
        
        if letterList[indexPath.row].isRead == 1 || letterList[indexPath.row].writerId == userId { // 읽었거나 내가 쓴 경우
            (cell.viewWithTag(300) as! UIImageView).hidden = true
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            let connect_ID = NSUserDefaults.standardUserDefaults().stringForKey("userConnectId")
            let letter_ID = letterList[indexPath.row].letterId
            
            LetterConstruct().deleteLetter(connect_ID!, letterID: letter_ID, completionHandler: { (json, error) -> Void in
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.letterList.removeAtIndex(indexPath.row)
                    self.letterTable.reloadData()
                }
            })
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if letterList[indexPath.row].writerId != NSUserDefaults.standardUserDefaults().stringForKey("userId")! { // 내가 쓴 경우 X
            //letter 읽음 처리
            LetterConstruct().updateLetter( NSUserDefaults.standardUserDefaults().stringForKey("userConnectId")!, letterID: letterList[indexPath.row].letterId, isRead: "1", completionHandler: { (json, error) -> Void in
                
                           })
        }
        
        if let letterDetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("letterDetail") as? LetterDetailViewController {
            letterDetailViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            letterDetailViewController.letterBody = self.letterList[indexPath.row].body
            self.navigationController?.pushViewController(letterDetailViewController, animated: true)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    // Edit 모드 / Done 모드 전환
    
    @IBAction func editItemTapped(sender: UIBarButtonItem) {
        
        if letterTable.editing {
            
            sender.title = "Edit"
            letterTable.setEditing(false, animated: true)
        }
        else {
            
            sender.title = "Done"
            letterTable.setEditing(true, animated: true)
        }
    }
    

    @IBAction func addItemTapped(sender: AnyObject) {
        
        if let profileViewController = self.storyboard?.instantiateViewControllerWithIdentifier("letterWriteViewController") {
            profileViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            //navigationController 의 하위 뷰로 전환
            self.navigationController?.pushViewController(profileViewController, animated: true)
            }
        }
    }

