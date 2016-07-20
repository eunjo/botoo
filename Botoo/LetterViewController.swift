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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.letterTable.delegate = self
        self.letterTable.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().stringForKey("userConnectId") != "nil" {
            MemberConstruct().callLetter(NSUserDefaults.standardUserDefaults().stringForKey("userConnectId")!,
                                         completionHandler: { (json, error) -> Void in
                                            let JsonData = json as! [[String: AnyObject]]
                                            
                                            self.letterList = []
                                            for data in JsonData {
                                                self.letterList.append(letterTableVO(title: data["title"] as! String, writerImage: data["sender"] as! String, letterId: data["_id"] as! String, date: data["date"] as! String, body: data["body"] as! String))
                                            }
            })
        }
        
        // write 한 편지 reload
        if LetterrWriteViewController.getNewLetterInfo.letterInfo != nil {
            self.letterList.append(LetterrWriteViewController.getNewLetterInfo.letterInfo!)
            LetterrWriteViewController.getNewLetterInfo.letterInfo = nil
        }
        
        self.letterTable.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return letterList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("LetterTableViewCell", forIndexPath: indexPath)
        (cell.viewWithTag(100) as! UILabel).text = letterList[indexPath.row].title
        
        if letterList[indexPath.row].writerImage == "nil" {
            (cell.viewWithTag(101) as! UIImageView).image = UIImage(named: "default_female.png")
        } else {
            // image 적용
        }
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            letterList.removeAtIndex(indexPath.row)
            letterTable.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
