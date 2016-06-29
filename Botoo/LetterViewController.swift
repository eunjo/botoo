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
    
    var letterList:[String] = ["test"]
    
    //var letters = [letterTableViewCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.letterTable.delegate = self
        self.letterTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return letterList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! letterTableViewCell
        cell.titleLabel?.text = letterList[indexPath.row]
        cell.writerImage.image = UIImage(named: "default_female.png")
        
        /*
        if (NSUserDefaults.standardUserDefaults().integerForKey("gender")==1){
            cell.writerImage.image = UIImage(named:"default_female.png")
        }else {
            cell.writerImage.image = UIImage(named:"default_male.png")
        }
        */
        
        /*
        if (letterList[indexPath.row==0]){
            cell.writerImage.image = UIImage(named:"default_female.png")
        }
        else {
            cell.writerImage.image = UIImage(named:"default_male.png")
        }
        */
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            letterList.removeAtIndex(indexPath.row)
            letterTable.reloadData()
            
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
    
    /*
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            if let profileViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") {
                profileViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                //navigationController 의 하위 뷰로 전환
                self.navigationController?.pushViewController(profileViewController, animated: true)
            }
            break
        case 1:
            break
        default:
            break
        }
        
    }
    */

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
