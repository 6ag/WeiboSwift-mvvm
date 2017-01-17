//
//  NetworkManagerExtension.swift
//  WeiboSwift
//
//  Created by zhoujianfeng on 2017/1/17.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import Foundation

// MARK: - 封装新浪微博的网络请求
extension NetworkManager {
    
    /// 加载微博数据字典数组
    ///
    /// - Parameters:
    ///   - sinceId: 返回ID比since_id大的微博 更早的微博
    ///   - maxId: 返回ID小于或等于max_id的微博 更久的微博
    ///   - finished: 完成
    func statusList(sinceId: Int64 = 0, maxId: Int64 = 0, finished: @escaping (_ list: [[String : AnyObject]]?, _ isSuccess: Bool) -> ()) {
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = [
            "since_id" : sinceId,
            "max_id" : maxId
        ]
        
        tokenRequest(urlString: urlString, parameters: params) { (json, isSuccess) in
            let list = json?["statuses"] as? [[String : AnyObject]]
            finished(list, isSuccess)
        }
    }
    
}
