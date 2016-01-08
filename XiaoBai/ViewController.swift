//
//  ViewController.swift
//  XiaoBai
//
//  Created by wangyang on 15/11/22.
//  Copyright © 2015年 com.wy. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .None;

        addChildViewControllers([XBBudgetViewController(), XBExpensesViewController(), XBIncomeViewController()])
        segment.selectedSegmentIndex = NSUserDefaults.standardUserDefaults().integerForKey(segmentIndex)
        segmentChange(nil)
        
    }
    

    @IBAction func segmentChange(sender: UISegmentedControl?) {
        switchToChildControllerAtIndex(UInt(segment.selectedSegmentIndex), completion:nil)
    }
    
    @IBAction func moreAction(sender: AnyObject) {
        
    }
    @IBAction func startAction(sender: AnyObject) {
        
    }
    
    @IBAction func endAction(sender: AnyObject) {
    }
}
