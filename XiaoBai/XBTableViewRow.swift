//
//  XBTableViewRow.swift
//  XiaoBai
//
//  Created by wangyang on 15/11/28.
//  Copyright © 2015年 com.wy. All rights reserved.
//

import UIKit

enum XBInputType: Int {
    case Time = 0, Text, Category, Money
}

protocol XBTableViewRowDelegate {
    func labelDidTap(label: UILabel, type: XBInputType)
}



class XBTableViewRow: UITableViewCell {
    var delegate: XBTableViewRowDelegate?

    // 改变 labelWidths 会影响每个label的宽度
    var labelWidths = [CGFloat]() {
        didSet {
            updateLabelConstraints()
        }
    }

    var labels = [UILabel]()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }
    
    func loadView() {
        selectionStyle = .None
    }
    

    /**
     添加一个可以点击的 label，并添加对应的点击手势
     :param: selector 点击手势响应的方法
     
     :returns: label
     */
    func addLabel(selector: Selector) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(12)
        label.numberOfLines = 2
        
        contentView.addSubview(label)
        label.userInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: selector)
        label .addGestureRecognizer(tap)

        labels.append(label)

        return label
    }

    func updateLabelConstraints() {
        for var i = 0; i < labels.count; ++i {
            labels[i].snp_remakeConstraints { (make) -> Void in
                if i == 0 {
                    make.left.equalTo(0)
                } else {
                    make.left.equalTo(labels[i - 1].snp_right).offset(0)
                }
                make.top.equalTo(0)
                make.bottom.equalTo(0)
                make.width.equalTo(labelWidths[i])
            }
        }
    }

    func timeTapAction(gesture: UITapGestureRecognizer) {
        delegate?.labelDidTap(gesture.view! as! UILabel, type:.Time)
    }
    
    func textTapAction(gesture: UITapGestureRecognizer) {
        delegate?.labelDidTap(gesture.view! as! UILabel, type:.Text)
    }
    
    func categoryTapAction(gesture: UITapGestureRecognizer) {
        delegate?.labelDidTap(gesture.view! as! UILabel, type:.Category)
    }
    
    func moneyTapAction(gesture: UITapGestureRecognizer) {
        delegate?.labelDidTap(gesture.view! as! UILabel, type:.Money)
    }
    
    

}

