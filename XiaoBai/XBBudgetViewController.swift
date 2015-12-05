//
//  XBBudgetViewController.swift
//  XiaoBai
//
//  Created by wangyang on 15/11/28.
//  Copyright © 2015年 com.wy. All rights reserved.
//

import UIKit

class XBBudgetViewController: XBTableViewController, XBTableViewRowDelegate {

    var timeDrag = XBDragView()
    var descDrag = XBDragView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.redColor()
        
        tableView.registerClass(XBBudgetCell.classForCoder(), forCellReuseIdentifier: "defaultCell")
 必需有一个能管理 dragView 的东西，我只需要调用一个方法，就可以添加一个 dragView，约束自动添加，从缓存中取出 正确的位置
        timeDrag.backgroundColor = UIColor.redColor()
        view.addSubview(timeDrag)
        
        dragViews.append(timeDrag)
        
        descDrag.backgroundColor = UIColor.greenColor()
        view.addSubview(descDrag)
        
        dragViews.append(descDrag)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()

        timeDrag.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(0);
            make.left.equalTo(30)
            make.size.equalTo(CGSizeMake(40, 30))
        }
        
        descDrag.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(0);
            make.left.equalTo(100)
            make.size.equalTo(CGSizeMake(40, 30))
        }
        
    }

    // MARK: - UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("defaultCell", forIndexPath: indexPath) as! XBBudgetCell
        cell.timeLabelWidth = Float(timeDrag.center.x)
        cell.descLabelWidth = Float(descDrag.center.x - timeDrag.center.x)
        cell.typeLabelWidth = 30
        cell.moneyLabelWidth = 30
        cell.delegate = self
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func labelDidTap(label: UILabel, type: XBInputType) {
        print(type)
        label.text? = "wangyang"
    }

}
