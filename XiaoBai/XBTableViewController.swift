//
//  XBTableViewController.swift
//  XiaoBai
//
//  Created by wangyang on 15/11/28.
//  Copyright © 2015年 com.wy. All rights reserved.
//

import UIKit

class XBTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableHeaderViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource  {
    var tableView = UITableView()
    var headerView : TableHeaderView!

    var inputLabel: UILabel!
    var inputType: XBInputType!
    // TODO: 通过改变 controller becomeFirstResponsder 来弹出不同的 inputView, inputAccessoryView
    private var categoryPicker = UIPickerView(frame: CGRectMake(0, 0, 0, 200))
    
    private var _inputView: UIView!
    // TODO:  通过 inputType 判断 getter 应该返回哪个 view
    override var inputView: UIView? {
        get {
            // TODO:  通过 inputType 判断 getter 应该返回哪个 view
            return  _inputView
        }
        
        set {
            _inputView = newValue;
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.redColor()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .OnDrag
        view.addSubview(tableView)
        
        headerView = TableHeaderView(delegate: self)
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
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
    }

    // MARK: - TableHeaderViewDelegate
    // controller只改变当前invisible的cell，
    func rowWidthsChanged(rowWidth: [CGFloat]) {
        for cell in tableView.visibleCells as! [XBTableViewRow] {
            cell.labelWidths = rowWidth
        }
    }
    
    // 在子类中重写该方法返回适当的数据
    func requirePersistenceRowLefts() -> [CGFloat] {
        return [0.0];
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
    
    // MARK: - Action
    func labelDidTap(label: UILabel, type: XBInputType) {
        inputType = type
        inputLabel = label
        
        switch type {
        case .Time:
            
            label.text? = "time"
        case .Text:
            label.text? = "text"
        case .Category:
            showCategoryPickerView()
            label.text? = "category"
        case .Money:
            label.text? = "money"
        }
    }
    
    // MARK: - Input Accessory View
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    
    func showTimePickerView() {
        
    }
    
    func showCategoryPickerView() {
        inputView = categoryPicker
        becomeFirstResponder()
    }
    
    func showTextInputView() {

    }
    
    func showMoneyInputView() {
        
    }
    
    // MARK: - CategoryPicker
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ["零花", "存款", "有借有还", "手机费"][row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let title = ["零花", "存款", "有借有还", "手机费"][row]
        inputLabel.text = title
    }
}

