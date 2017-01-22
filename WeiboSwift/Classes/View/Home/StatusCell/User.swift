//
//  User.swift
//  WeiboSwift
//
//  Created by zhoujianfeng on 2017/1/21.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit

class User: NSObject {

    var id: Int64 = 0
    
    /// 昵称
    var screen_name: String?
    
    /// 头像
    var profile_image_url: String?
    
    /// 认证类型  -1没有认证 0认证用户 2，3，5企业认证 220达人
    var verified_type: Int = 0
    
    /// 会员等级  1-6
    var mbrank: Int = 0
    
    override var description: String {
        return yy_modelDescription()
    }
    
    
}
