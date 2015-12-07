//
//  AppDelegate.swift
//  XiaoBai
//
//  Created by wangyang on 15/11/22.
//  Copyright © 2015年 com.wy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        storeSegmentIndex()
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        
    }

    
    func storeSegmentIndex() {
        let navigation = window!.rootViewController as! UINavigationController
        
        let controller = navigation.viewControllers.first as! ViewController
        NSUserDefaults.standardUserDefaults().setInteger(Int(controller.segment.selectedSegmentIndex), forKey: segmentIndex)
        NSUserDefaults.standardUserDefaults().synchronize()
    }

}

