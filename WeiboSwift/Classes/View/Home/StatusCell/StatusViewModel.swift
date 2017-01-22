//
//  StatusViewModel.swift
//  WeiboSwift
//
//  Created by zhoujianfeng on 2017/1/21.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import Foundation

class StatusViewModel: CustomStringConvertible {
    
    /// 微博模型
    var status: Status
    
    /// 会员等级图标 - 内存换cpu
    var memberIcon: UIImage?
    
    /// 认证图标
    var vipIcon: UIImage?
    
    /// 转发文字
    var retweetString: String?
    
    /// 评论文字
    var commentString: String?
    
    /// 点赞文字
    var likeString: String?
    
    /// 配图区域尺寸
    var pictureViewSize = CGSize()
    
    init(model: Status) {
        self.status = model
        
        guard let user = model.user else {
            return
        }
        
        // 会员等级图标 会员等级  0-6
        if user.mbrank > 0 && user.mbrank < 7 {
            let imageName = "common_icon_membership_level\(user.mbrank)"
            memberIcon = UIImage(named: imageName)
        } else {
            let imageName = "common_icon_membership_expired"
            memberIcon = UIImage(named: imageName)
        }
        
        // -1没有认证 0认证用户 2，3，5企业认证 220达人
        switch user.verified_type {
        case 0:
            vipIcon = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        case 220:
            vipIcon = UIImage(named: "avatar_grassroot")
        default:
            break
        }
        
        // 转换字符串
        retweetString = countToString(count: model.reposts_count, defaultString: "转发")
        commentString = countToString(count: model.comments_count, defaultString: "评论")
        likeString = countToString(count: model.attitudes_count, defaultString: "赞")
        
        // 计算配图区域尺寸
        pictureViewSize = calcPictureViewSize(count: model.pic_urls?.count ?? 0)
        
    }
    
    /// 计算配图区域尺寸
    ///
    /// - Parameter count: 配图数量
    /// - Returns: 尺寸
    private func calcPictureViewSize(count: Int) -> CGSize {
        
    }
    
    /// 数量转字符串 0显示默认字符串 小于10000显示具体数字 大于10000显示x.xx万
    ///
    /// - Parameters:
    ///   - count: 数量
    ///   - defaultString: 默认字符串
    /// - Returns: 转换后的字符串
    private func countToString(count: Int, defaultString: String) -> String {
        if count == 0 {
            return defaultString
        } else if count < 10000 {
            return count.description
        }
        return String(format: "%.02f 万", CGFloat(count) / 10000)
    }
    
    var description: String {
        return status.description
    }
    
}
