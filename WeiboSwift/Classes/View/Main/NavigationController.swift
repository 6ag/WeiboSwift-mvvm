//
//  NavigationViewController.swift
//  WeiboSwift
//
//  Created by 周剑峰 on 2017/1/16.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 隐藏系统的导航栏
        navigationBar.isHidden = true
        
    }
    
}

extension NavigationController {
    
    /// 拦截系统push操作
    ///
    /// - Parameters:
    ///   - viewController: 即将进入的界面
    ///   - animated: 是否有push动画
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count > 0 {
            
            // 隐藏底部tabBar
            viewController.hidesBottomBarWhenPushed = true
            
            // 设置导航栏返回按钮
            if let vc = viewController as? BaseViewController {
                var title = "返回"
                if childViewControllers.count == 1 {
                    title = childViewControllers.first?.title ?? "返回"
                }
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(back), isBack: true)
            }
            
        }
        
        super.pushViewController(viewController, animated: animated)
        
    }
    
    /// 返回上一级界面
    @objc private func back() {
        popViewController(animated: true)
    }
    
}
