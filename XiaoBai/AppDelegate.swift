//
//  AppDelegate.swift
//  XiaoBai
//
//  Created by wangyang on 15/11/22.
//  Copyright © 2015年 com.wy. All rights reserved.
//

import UIKit
import CoreMotion



@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, RollPhoneDetectorDelegate{

    var window: UIWindow?
    let detector = RollPhoneDetector()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        detector.delegate = self;
        
        return true
        
    }

    func applicationWillResignActive(application: UIApplication) {
        storeSegmentIndex()
        detector.stopMotionUpdate()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        detector.startMotionUpdate()
    }
    
    func didRollPhone() {
        let alert = UIAlertController(title: "alert", message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil))
        self.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }

    func storeSegmentIndex() {
        let navigation = window!.rootViewController as! UINavigationController

        let controller = navigation.viewControllers.first as! ViewController
        NSUserDefaults.standardUserDefaults().setInteger(Int(controller.segment.selectedSegmentIndex), forKey: segmentIndex)
        NSUserDefaults.standardUserDefaults().synchronize()
    }

}