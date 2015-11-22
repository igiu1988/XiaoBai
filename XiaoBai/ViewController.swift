//
//  ViewController.swift
//  XiaoBai
//
//  Created by wangyang on 15/11/22.
//  Copyright © 2015年 com.wy. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel.init()
        label.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(label)
        label.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(15)
            make.left.equalTo(self.view).offset(15)
        }
        
        
        let note = XBNote.init()
        note.date = NSDate.init()
        print(note.date)
        label.text = note.date.description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

