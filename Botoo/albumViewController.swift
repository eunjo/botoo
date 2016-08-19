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
    var loadCount = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //한 번에 불러올 개수
        let cellHeight = self.view.frame.size.width / CGFloat(3.0) //width == height
        loadCount = Int(self.view.frame.size.height / cellHeight) * 3 //한 화면에 보여지는 줄 * 한 줄 당 개수
    }
    
    override func viewWillAppear(animated: Bool) {
        
        dispatch_async(dispatch_get_main_queue()) {
            
            let messageList = FileManager.sharedInstance.readFile()
            
            if messageList == [] { return }
            
            var startCount = 0
            let endCount = startCount + self.loadCount
            
            var messageListTemp = messageList
            
            if endCount < messageList.count {
                messageListTemp = Array(messageList[startCount ..< endCount])
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
            
            startCount = startCount + self.loadCount
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! PhotoCollectionViewCell
        
        let cellSize = self.view.frame.size.width / CGFloat(3.0)
        cell.frame.size.height = cellSize
        cell.frame.size.width = cellSize
        
//        cell.photoImageView.frame.size.height = cellSize
//        cell.photoImageView.frame.size.width = cellSize
        
        //이미지 디코딩
        let dataDecoded:NSData = NSData(base64EncodedString: self.picCollectionList[indexPath.row], options: NSDataBase64DecodingOptions(rawValue: 0))!
        let decodedimage:UIImage = UIImage(data: dataDecoded)!
        cell.photoImageView.image = decodedimage
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "detail") {

            let svc = segue.destinationViewController as! imageZoomViewController
            svc.newImage = (sender as! PhotoCollectionViewCell).photoImageView.image
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
            
            self.performSegueWithIdentifier("detail", sender: cell)
            if let connectingViewController = self.storyboard?.instantiateViewControllerWithIdentifier("imageZoomViewController") {
                connectingViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
                self.presentViewController(connectingViewController, animated: true, completion: nil)
            }
        }
    }
    

    
}
