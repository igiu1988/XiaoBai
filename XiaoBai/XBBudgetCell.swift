//
//  XBBudgetCell.swift
//  XiaoBai
//
//  Created by wangyang on 15/11/29.
//  Copyright © 2015年 com.wy. All rights reserved.
//

import UIKit

class XBBudgetCell: XBTableViewRow {

    var timeLabel: UILabel!
    var descLabel: UILabel!
    var typeLabel: UILabel!
    var moneyLabel: UILabel!
    
    var timeLabelWidth: Float? {
        didSet {
            timeLabel.snp_remakeConstraints { (make) -> Void in
                make.left.equalTo(0)
                make.top.equalTo(0)
                make.bottom.equalTo(0)
                make.width.equalTo(timeLabelWidth!)
            }
        }
    }
    
    var descLabelWidth: Float? {
        didSet {
            descLabel.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(timeLabel.snp_right).offset(0).priority(1000)
                make.top.equalTo(0)
                make.bottom.equalTo(0)
                make.width.equalTo(descLabelWidth!)
            }
        }
    }
    
    var typeLabelWidth: Float? {
        didSet {
            typeLabel.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(descLabel.snp_right).offset(0).priority(1000)
                make.top.equalTo(0)
                make.bottom.equalTo(0)
                make.width.equalTo(typeLabelWidth!)
            }
        }
    }
    
    var moneyLabelWidth: Float? {
        didSet {
            moneyLabel.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(typeLabel.snp_right).offset(0).priority(1000)
                make.top.equalTo(0)
                make.bottom.equalTo(0)
                make.width.equalTo(moneyLabelWidth!)
            }
        }
    }
    
    override func loadView() {
        timeLabel = addLabel("timeTapAction:")
        descLabel = addLabel("textTapAction:")
        typeLabel = addLabel("categoryTapAction:")
        moneyLabel = addLabel("moneyTapAction:")

        timeLabel.text = "aaa"
        timeLabel.backgroundColor = UIColor.greenColor()
        descLabel.text = "aaca"
        descLabel.backgroundColor = UIColor.yellowColor()

        typeLabel.text = "aada"
        typeLabel.backgroundColor = UIColor.redColor()

        moneyLabel.text = "aaga"
        moneyLabel.backgroundColor = UIColor.grayColor()

    }
    
    

}
