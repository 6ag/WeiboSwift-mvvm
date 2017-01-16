//
//  UIBarButtonItemExtension.swift
//  WeiboSwift
//
//  Created by zhoujianfeng on 2017/1/16.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 创建UIBarButtonItem
    ///
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: fontSize 默认16
    ///   - target: target
    ///   - action: action
    convenience init(title: String, target: AnyObject?, action: Selector, fontSize: CGFloat = 16, isBack: Bool = false) {
        let button = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        if isBack {
            let normalImageName = "navigationbar_back_withtext"
            button.setImage(UIImage(named: normalImageName), for: .normal)
            button.setImage(UIImage(named: normalImageName + "_highlighted"), for: .highlighted)
            button.sizeToFit()
        }
        button.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: button)
    }
    
}
