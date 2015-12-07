//
//  TableHeaderView.swift
//  XiaoBai
//
//  Created by wangyang on 15/12/5.
//  Copyright © 2015年 com.wy. All rights reserved.
//

import UIKit


protocol TableHeaderViewDelegate : NSObjectProtocol {
    func rowWidthsChanged(rowWidth: [CGFloat]);
}
// 因为每个controller有不同的lefts，widths，所以这部分要在controller中实现。如何实现呢。。这个有点不会了，要暴露出一个协议。requirePersistenceRowWidths，有了宽度，就可以计算出对应的left
// TODO: 在这里添加一个segmentControl，拖动d时，相关的segment宽度发生变化
class TableHeaderView: UIView, UIGestureRecognizerDelegate {
    private var dragingIndex: Int!
    var dragViews = [XBDragView]()
    var segment: UISegmentedControl!

    weak var delegate: TableHeaderViewDelegate?

    let dragViewSize = CGSizeMake(40, 30)
    // TODO: persistenceLefts应该从一个持久化的类中取出
    private var persistenceLefts: [CGFloat] = [50.0, 110.0, 180.0, 230.0]
    private var preLefts: [CGFloat]!

    // TODO: persistenceRowWidths应该从一个持久化的类中取出
    var persistenceRowWidths: [CGFloat] = [CGFloat]()
    private var preRowWidths: [CGFloat]!


    override init(frame: CGRect) {
        super.init(frame: frame)

        let pan = UIPanGestureRecognizer.init(target: self, action: "panAction:")
        pan.delegate = self
        self.addGestureRecognizer(pan)

        preLefts = persistenceLefts;

        var preCenter: CGFloat?
        let halfWidth = dragViewSize.width / 2
        for x in persistenceLefts{
            if preCenter == nil {
                persistenceRowWidths.append(x + halfWidth)
            }else{
                persistenceRowWidths.append(x + halfWidth - preCenter!)
            }
            preCenter = x + halfWidth
        }

        preRowWidths = persistenceRowWidths
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
    }

    func setSegmentTitles(titles: [String]) {

        segment = UISegmentedControl(items: titles)
        insertSubview(segment, atIndex: 0)
        segment.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(UIEdgeInsetsZero)
        }

        addDragView(titles.count)
        updateDragViewConstraints()
    }

    /// 当移动d时，persistenceLefts需要改变
    func addDragView(count: Int) {
        for var i = 0; i < count; ++i {
            let drag = addDragView()
            drag.tag = i
        }
    }

    func updateDragViewConstraints() {
        for var i = 0; i < dragViews.count; ++i {
            dragViews[i].snp_remakeConstraints { (make) -> Void in

                make.left.equalTo(persistenceLefts[i])
                make.top.equalTo(0);
                make.size.equalTo(dragViewSize)
            }
        }
    }


    func updateSegmentWidth() {
        for var i = 0; i < persistenceRowWidths.count; ++i {
            segment.setWidth(persistenceRowWidths[i], forSegmentAtIndex: i)
        }
    }

    /**
     只改变segment的宽，放在最后的layoutSubviews，提前调用没有效果
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        updateSegmentWidth()
    }

    func addDragView() -> XBDragView{
        let drag = XBDragView()
        drag.backgroundColor = UIColor.redColor()
        addSubview(drag)
        dragViews.append(drag)
        return drag
    }


    // pan手势开始时，取得当前被拖动的d的坐标：dragingIndex
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        let point = touch.locationInView(self)
        for dragView in dragViews {
            if CGRectContainsPoint(dragView.frame, point) {
                dragingIndex = dragView.tag
                return true
            }
        }
        return false
    }

    // pan手势的响应方法。在这里控制了改变时要进行的坐标变换，结束时坐标的保存
    func panAction(pan: UIPanGestureRecognizer) {

        // 移动时改变被移动的d的坐标
        let offset = pan.translationInView(self)
        // TODO: 根据 dragingIndex 得到对应的drag view，如果dragview小于某一个
        // TODO: 大于某一个值
        
        // 根据 preLefts 数组，调节d及后面的d的坐标
        for var i = dragingIndex; i < dragViews.count; ++i! {

            persistenceLefts[i] = preLefts[i]  + offset.x

        }

        // 只调节当前拖动的drag view的宽
        persistenceRowWidths[dragingIndex] = preRowWidths[dragingIndex] + offset.x


        // 在移动dragview时，sdk会走layoutSubviews，在那里会重新设置segment的宽
        updateDragViewConstraints()
        delegate?.rowWidthsChanged(persistenceRowWidths)

        // 结束时要保证preLefts是最新的
        if pan.state == .Ended {
            preLefts = persistenceLefts
            preRowWidths = persistenceRowWidths
        }

    }
}
