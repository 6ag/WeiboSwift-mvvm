//
//  NetworkManagerExtension.swift
//  WeiboSwift
//
//  Created by zhoujianfeng on 2017/1/17.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import Foundation
import YYModel

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
    
    /// 加载用户信息
    ///
    /// - Parameter finished: 完成回调
    func loadUserInfo(finished: @escaping (_ dict: [String : AnyObject]?) -> ()) {
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        tokenRequest(urlString: urlString, parameters: nil) { (json, isSuccess) in
            finished(json as? [String : AnyObject])
        }
    }
    
    /// 加载账号信息
    ///
    /// - Parameters:
    ///   - code: 授权码
    ///   - finished: 完成回调
    func loadAccessToken(code: String, finished: @escaping (_ isSuccess: Bool) -> ()) {
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = [
            "client_id" : WB_APP_KEY,
            "client_secret" : WB_APP_SECRET,
            "grant_type" : "authorization_code",
            "code" : code,
            "redirect_uri" : WB_REDIRECT_URI
        ]
        
        request(method: .post, urlString: urlString, parameters: params) { (json, isSuccess) in
            
            guard let json = json as? [String : AnyObject] else {
                finished(isSuccess)
                return
            }
            
            self.userAccount.yy_modelSet(with: json)
            
            // 加载用户信息
            self.loadUserInfo(finished: { (dict) in
                self.userAccount.yy_modelSet(with: dict ?? [:])
                self.userAccount.saveAccount()
                finished(isSuccess)
            })
            
        }
        
    }
    
}
