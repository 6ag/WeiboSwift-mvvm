//
//  OAuthViewController.swift
//  WeiboSwift
//
//  Created by 周剑峰 on 2017/1/17.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
    }
    
    /// 隐藏授权页面
    @objc fileprivate func back() {
        dismiss(animated: true, completion: nil)
    }

}

// MARK: - 界面设置
extension OAuthViewController {
    
    /// 准备UI
    fileprivate func prepareUI() {
        
        title = "微博授权"
        view.backgroundColor = UIColor.cz_random()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", target: self, action: #selector(back))
        
    }
}
