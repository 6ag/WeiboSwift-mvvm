//
//  BundleExtension.swift
//  WeiboSwift
//
//  Created by 周剑峰 on 2017/1/15.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import Foundation

extension Bundle {
    
    /// 获取默认命名空间
    var namespace: String {
        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
}
