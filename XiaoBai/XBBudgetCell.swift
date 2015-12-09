//
//  XBBudgetCell.swift
//  XiaoBai
//
//  Created by wangyang on 15/11/29.
//  Copyright © 2015年 com.wy. All rights reserved.
//

import UIKit


/// cell 只公开对应的宽度调节属性。改变属性，立即调节宽度
class XBBudgetCell: XBTableViewRow {

    private var timeLabel: UILabel!
    private var descLabel: UILabel!
    private var typeLabel: UILabel!
    private  var moneyLabel: UILabel!

    override func loadView() {

        // TODO: 能不能 addLabel 时把约束也做好，并且把 每个row的width直接添加到labelWidths中
        timeLabel = addLabel("timeTapAction:")
        descLabel = addLabel("textTapAction:")
        typeLabel = addLabel("categoryTapAction:")
        moneyLabel = addLabel("moneyTapAction:")
        moneyLabel.textAlignment = .Right
        
        timeLabel.text = "15-12-1"
        timeLabel.backgroundColor = UIColor.greenColor()
        descLabel.text = "早晨买了四块巧克力，给家里及自己"
        descLabel.backgroundColor = UIColor.yellowColor()

        typeLabel.text = "生存必备及零花"
        typeLabel.backgroundColor = UIColor.redColor()

        moneyLabel.text = "￥114.00"
        moneyLabel.backgroundColor = UIColor.grayColor()

    }

}
