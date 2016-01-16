//
//  RollPhoneDetector.swift
//  XiaoBai
//
//  Created by wangyang on 16/1/10.
//  Copyright © 2016年 com.wy. All rights reserved.
//

import Foundation
import CoreMotion
protocol RollPhoneDetectorDelegate {
    func didRollPhone()
}

// 检测手机是做出了先 face down，再 face up 这样一套动作
class RollPhoneDetector {
    let motionManager = CMMotionManager()
    
    // 用来重置检测
    var timer :NSTimer?
    var delegate: RollPhoneDetectorDelegate?

    
    var alreadyFaceDown = false
    var faceDownJustNow = false
    
    
    func startMotionUpdate() {
        motionManager.deviceMotionUpdateInterval = NSTimeInterval(1.0/5.0)
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) { [unowned self] (deviceMotion : CMDeviceMotion?, error: NSError?) ->  Void in

            let roll = fabs(deviceMotion!.attitude.roll)

            // 从 face up 到 face down
            let isFaceDown = roll >= 2.6
            if isFaceDown {
                self.faceDownAction()
            }
            
            // 从 face down 到 face up
            let isFaceUp = roll <= 0.25 && roll >= 0.025
            if isFaceUp  {
                self.faceUpAction()
            }
            
        }
    }
    
    func stopMotionUpdate() {
        motionManager.stopDeviceMotionUpdates()
    }
    
    // 这个方法也是检测到一次 down 之后，只有重置后才会再次触发
    func faceDownAction() {
    
        if !alreadyFaceDown {
            alreadyFaceDown = true
            faceDownJustNow = true
            print("faceDownAction")
            
            // 超过这个时间，取消动作检测。如果检测到了翻转，这个 timer 还需要取消
            timer = NSTimer.scheduledTimerWithTimeInterval(0.7, target: self, selector: "cancelDetect", userInfo: nil, repeats: false)
        }
        
    }
    
    func faceUpAction() {
        alreadyFaceDown = false
        if self.faceDownJustNow {
            delegate?.didRollPhone()
            
            // 保证只执行一次 faceUpAction
            faceDownJustNow = false
            
            // 检测到 faceUp，取消之后的检测
            self.timer?.invalidate()
        }
    }
    
    @objc func cancelDetect() {
        faceDownJustNow = false
    }
    
}