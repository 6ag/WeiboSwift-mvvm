//
//  NetworkManager.swift
//  WeiboSwift
//
//  Created by zhoujianfeng on 2017/1/17.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import Foundation
import AFNetworking

/// 请求方式
///
/// - get: get
/// - post: post
enum HttpMethod {
    case get
    case post
}

class NetworkManager: AFHTTPSessionManager {
    
    /// 请求对象单例
    static let shared: NetworkManager = {
        let manager = NetworkManager()
        manager.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return manager
    }()
    
    /// 微博账号对象
    lazy var userAccount = UserAccount()
    
    /// 是否已经登录
    var isLogin: Bool {
        return userAccount.access_token != nil
    }
    
    /// 公共请求方法
    ///
    /// - Parameters:
    ///   - method: 请求方式
    ///   - urlString: 接口url
    ///   - parameters: 参数
    ///   - finished: 完成回调
    func request(method: HttpMethod = .get, urlString: String, parameters: [String : Any]?, finished: @escaping (_ json: AnyObject?, _ isSuccess: Bool) -> ()) {
        
        // 成功回调
        let success = { (task: URLSessionDataTask, json: Any) -> () in
            finished(json as AnyObject?, true)
        }
        
        // 失败回调
        let failure = { (task: URLSessionDataTask?, error: Error) -> () in
            print("网络请求失败: " + error.localizedDescription)
            
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("token失效了 无访问权限")
                // 发出请求登录的通知
                NotificationCenter.default.post(name: NSNotification.Name(NEED_USER_LOGIN_NOTIFICATION), object: nil)
            }
            
            finished(nil, false)
        }
        
        print("parameters = \(parameters)")
        
        if method == .get {
            get(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        } else {
            post(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        
    }
    
    /// 公共请求方法 - 带token请求
    ///
    /// - Parameters:
    ///   - method: 请求方式
    ///   - urlString: 接口url
    ///   - parameters: 参数
    ///   - finished: 完成回调
    func tokenRequest(method: HttpMethod = .get, urlString: String, parameters: [String : Any]?, finished: @escaping (_ json: AnyObject?, _ isSuccess: Bool) -> ()) {
        
        guard let accessToken = userAccount.access_token else {
            print("登录过期，需要重新登录")
            // 发出请求登录的通知
            NotificationCenter.default.post(name: NSNotification.Name(NEED_USER_LOGIN_NOTIFICATION), object: nil)
            return
        }
        
        // 如果没有参数，则初始化参数
        var parameters = parameters
        if parameters == nil {
            parameters = [String : AnyObject]()
        }
        
        // 添加token
        parameters?["access_token"] = accessToken
        
        request(method: method, urlString: urlString, parameters: parameters, finished: finished)
    }
    
}
