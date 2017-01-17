//
//  Status.swift
//  WeiboSwift
//
//  Created by zhoujianfeng on 2017/1/17.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit
import YYModel

class Status: NSObject {
    
    var id: Int64 = 0
    
    /// 微博信息内容
    var text: String?
    
    override var description: String {
        return yy_modelDescription()
    }
    
}
