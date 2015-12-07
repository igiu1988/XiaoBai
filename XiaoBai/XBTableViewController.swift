//
//  XBTableViewController.swift
//  XiaoBai
//
//  Created by wangyang on 15/11/28.
//  Copyright © 2015年 com.wy. All rights reserved.
//

import UIKit

class XBTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableHeaderViewDelegate  {
    var tableView = UITableView()
    var headerView = TableHeaderView(frame: CGRectZero)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.redColor()

        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        view.addSubview(headerView)
        headerView.delegate = self
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

    // controller只改变当前invisible的cell，
    func rowWidthsChanged(rowWidth: [CGFloat]) {
        for cell in tableView.visibleCells as! [XBTableViewRow] {
            cell.labelWidths = rowWidth
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        assert(false, "XBTableViewController 没有注册任何 cell，请在子类注册")
        let cell = tableView.dequeueReusableCellWithIdentifier("defaultCell", forIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30;
    }
}

