//
//  ComposeTypeView.swift
//  WeiboSwift
//
//  Created by zhoujianfeng on 2017/1/24.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit

class ComposeTypeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        prepareUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 准备UI
    private func prepareUI() {
        backgroundColor = UIColor.orange
    }
    
    /// 显示当前视图
    func show() {
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        vc.view.addSubview(self)
    }

}
