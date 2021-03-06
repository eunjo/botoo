//
//  AppDelegate.swift
//  Botoo
//
//  Created by 이은조 on 2016. 6. 27..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let userId = NSUserDefaults.standardUserDefaults().stringForKey("userId")

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        application.applicationIconBadgeNumber = 1
        
        return true
        
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // app 활성화시 connect
    func applicationDidBecomeActive(application: UIApplication) {
        SocketIOManager.sharedInstance.establishConnection()
        if !Reachability.isConnectedToNetwork() {
            self.window?.rootViewController!.presentViewController(Reachability.alert(), animated: true, completion: nil)
        }
    }
    
    // app 비활성화시 disconnect
    func applicationDidEnterBackground(application: UIApplication) {
        SocketIOManager.sharedInstance.closeConnection()
        print("offline")
        
        if userId != nil {
            MemberConstruct().setOnline(userId!, isOnline: false, completionHandler: { (json, error) -> Void in
                // user online
            })
        }
    }
}

