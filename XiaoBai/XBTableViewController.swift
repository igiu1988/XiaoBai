//
//  XBTableViewController.swift
//  XiaoBai
//
//  Created by wangyang on 15/11/28.
//  Copyright © 2015年 com.wy. All rights reserved.
//

import UIKit

class XBTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    var tableView = UITableView()
    private var dragingView: XBDragView!
    private var headerView = UIView()
    把 dragViews 做到一个固定的 view 上，而不是一个 section Header
    var dragViews = [XBDragView]()
    // error
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.redColor()
        
        let pan = UIPanGestureRecognizer.init(target: self, action: "panAction:")
        pan.delegate = self
        view.addGestureRecognizer(pan)
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        view.addSubview(headerView)
        headerView.backgroundColor = UIColor.purpleColor()
        headerView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(40)
        }
        tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(headerView.snp_bottom)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        let point = touch.locationInView(view)

        for dragView in dragViews {
            if CGRectContainsPoint(dragView.frame, point) {
                dragingView = dragView
                dragingView.currentOrigin = dragingView.frame.origin
                return true
            }
        }
        
        return false        
    }
    
    func panAction(pan: UIPanGestureRecognizer) {
        let offset = pan.translationInView(view)
        
        dragingView.snp_updateConstraints { (make) -> Void in
            make.left.equalTo(dragingView.currentOrigin.x + offset.x)
        }
        
        tableView.reloadData()
//        print("\(pan.translationInView(view))")
    }
    
     // MARK: - Width
//     TODO: 下面这两个是 delegate
//     cellCanShrink -> Bool
//     cellCanExpand -> Bool
    
    
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        assert(false, "XBTableViewController 没有注册任何 cell，请在子类注册")
        let cell = tableView.dequeueReusableCellWithIdentifier("defaultCell", forIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

