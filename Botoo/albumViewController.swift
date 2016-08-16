//
//  albumViewController.swift
//  Botoo
//
//  Created by 이은조 on 2016. 7. 4..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class albumViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    var picCollectionList:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        
        dispatch_async(dispatch_get_main_queue()) {
            
            let messageList = FileManager.sharedInstance.readFile()
            
            if messageList == [] { return }
            
            var startCount = 0
            var endCount = startCount+10
            
            var messageListTemp = messageList
            
            if endCount < messageList.count {
                messageListTemp = Array(messageList[startCount ..< endCount]) //10개 씩 읽어오기
            }
            
            for var message in messageListTemp {
                if message != "" {
                    message.removeAtIndex(message.endIndex.predecessor())
                    
                    let result = self.convertStringToDictionary(message)
                    
                    if result!["type"] as! String == "pic" {
                        print("pic message")
                        self.picCollectionList.append(result!["message"] as! String)
                    }
                }
            }
            
            startCount = startCount + 10
            self.collectionView.reloadData()
        }
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
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.picCollectionList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.blackColor()
        return cell
    }
}
