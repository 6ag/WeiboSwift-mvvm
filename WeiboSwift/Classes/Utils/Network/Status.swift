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
    
    /// 微博作者
    var user: User?
    
    /// 转发数
    var reposts_count: Int = 0
    
    /// 评论数
    var comments_count: Int = 0
    
    /// 表态数
    var attitudes_count: Int = 0
    
    /// 配图模型数组
    var pic_urls: [StatusPicture]?
    
    override var description: String {
        return yy_modelDescription()
    }
    
    class func modelContainerPropertyGenericClass() -> [String : AnyObject] {
        return ["pic_urls" : StatusPicture.classForCoder()]
    }
    
}
