//
//  SettingViewController.swift
//  Botoo
//
//  Created by 혜인 on 2016. 6. 29..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var setting_tv: UITableView!
    private let items = ["계정관리", "이별하기", "암호설정", "알림설정", "버전정보", "이용약관"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting_tv.delegate = self
        setting_tv.dataSource = self
        setting_tv.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 8))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SettingTableViewCell") as
            UITableViewCell!
        cell.textLabel?.text = items[indexPath.row]
        
        //버전정보는 accessory .none 설정
        if(indexPath.row == 4) {
            cell.accessoryType = UITableViewCellAccessoryType.None
            cell.detailTextLabel?.text = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString")?.description
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var viewController: UIViewController?
        
        switch indexPath.row {
        case 0:
            viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController")
            break
        case 1:
            break
        case 2:
            viewController = self.storyboard?.instantiateViewControllerWithIdentifier("LockSetViewController")
            break
        default:
            break
        }
        
        if(viewController != nil) {
            viewController!.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            //navigationController 의 하위 뷰로 전환
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
        
    }
}
