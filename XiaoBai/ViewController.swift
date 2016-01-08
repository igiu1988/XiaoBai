//
//  ViewController.swift
//  XiaoBai
//
//  Created by wangyang on 15/11/22.
//  Copyright © 2015年 com.wy. All rights reserved.
//

import UIKit
import SnapKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    var duration: Float = 0.0
    
    let motionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .None;

        addChildViewControllers([XBBudgetViewController(), XBExpensesViewController(), XBIncomeViewController()])
        segment.selectedSegmentIndex = NSUserDefaults.standardUserDefaults().integerForKey(segmentIndex)
        segmentChange(nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "flip", name: UIDeviceOrientationDidChangeNotification, object: nil)
        UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
        
        
        motionManager.deviceMotionUpdateInterval = NSTimeInterval(1.0/2.0)
//        motionManager.accelerometerUpdateInterval = NSTimeInterval(1.0/50.0)

        
    }
    
    func flip() {
        let orientation = UIDevice.currentDevice().orientation
        if orientation == .FaceDown {
            print("faceDown")
        }
    }

    @IBAction func segmentChange(sender: UISegmentedControl?) {
        switchToChildControllerAtIndex(UInt(segment.selectedSegmentIndex), completion:nil)
    }
    
    @IBAction func moreAction(sender: AnyObject) {
        
    }
    @IBAction func startAction(sender: AnyObject) {
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) { (deviceMotion : CMDeviceMotion?, error: NSError?) -> Void in
            let userAcceleration = deviceMotion?.userAcceleration
            let rotationRate = deviceMotion?.rotationRate
            
            //            let totalAcceleration = sqrt(userAcceleration?.x * userAcceleration?.x +
            //                userAcceleration?.y * userAcceleration?.y + userAcceleration?.z * userAcceleration?.z)
            
//            print("x=\(userAcceleration?.x) y=\(userAcceleration?.y) z=\(userAcceleration?.z)")
            print("x=\(rotationRate?.x) y=\(rotationRate?.y) z=\(rotationRate?.z)")
        }
    }
    
    @IBAction func endAction(sender: AnyObject) {
        motionManager.stopDeviceMotionUpdates()
    }
}rotationRate
