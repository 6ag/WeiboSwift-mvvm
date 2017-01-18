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
    
    func loadAccessToken(code: String) {
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = [
            "client_id" : WB_APP_KEY,
            "client_secret" : WB_APP_SECRET,
            "grant_type" : "authorization_code",
            "code" : code,
            "redirect_uri" : WB_REDIRECT_URI
        ]
        
        
        
    }
    
}
