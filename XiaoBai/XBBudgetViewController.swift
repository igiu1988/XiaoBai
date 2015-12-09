//
//  XBBudgetViewController.swift
//  XiaoBai
//
//  Created by wangyang on 15/11/28.
//  Copyright © 2015年 com.wy. All rights reserved.
//

import UIKit

class XBBudgetViewController: XBTableViewController, XBTableViewRowDelegate {
    let headerTitles = ["日期", "描述", "类别", "总额"];

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.redColor()
        
        tableView.registerClass(XBBudgetCell.classForCoder(), forCellReuseIdentifier: "defaultCell")

        self.headerView.setSegmentTitles(headerTitles)
    }


    // MARK: - UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("defaultCell", forIndexPath: indexPath) as! XBBudgetCell
        cell.labelWidths = headerView.persistenceRowWidths
        cell.delegate = self
        return cell
    }

    // TODO: 使用持久化存储取得行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    
    
    override func requirePersistenceRowLefts() -> [CGFloat] {
        return [50.0, 180.0, 230.0, 280.0];
    }

}
