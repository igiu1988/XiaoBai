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

//    override func updateConstraints() {
//
//        /* TODO:
//        第一个timeLabel的left必须满足，宽必须满足；长按弹出具体时间
//        第二个描述，宽度大于等于某个数值, 但是也可能是小于等于某个数值。
//        第三个类别宽必须满足
//        最后的moneyLabel的right必须满足；宽必须满足
//        */
//
//        timeLabel.snp_remakeConstraints { (make) -> Void in
//            make.left.equalTo(0)
//            make.top.equalTo(0)
//            make.bottom.equalTo(0)
//            make.width.equalTo(labelWidths[0])
//        }
//
//        descLabel.snp_remakeConstraints { (make) -> Void in
//            make.left.equalTo(timeLabel.snp_right).offset(0)
//
//            make.top.equalTo(0)
//            make.bottom.equalTo(0)
//            //            make.width.equalTo(labelWidths[1])
//            make.right.equalTo(typeLabel.snp_left).offset(0)
//        }
//
//        typeLabel.snp_remakeConstraints { (make) -> Void in
//            make.right.equalTo(moneyLabel.snp_left).offset(0)
//            make.top.equalTo(0)
//            make.bottom.equalTo(0)
//            make.width.equalTo(labelWidths[2])
//
//        }
//
//        moneyLabel.snp_remakeConstraints { (make) -> Void in
//            make.top.equalTo(0)
//            make.bottom.equalTo(0)
//            make.right.equalTo(0)
//            make.width.equalTo(labelWidths[3])
//            
//        }
//
//        super.updateConstraints()
//    }



}
