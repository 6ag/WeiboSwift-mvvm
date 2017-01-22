//
//  StatusListViewModel.swift
//  WeiboSwift
//
//  Created by zhoujianfeng on 2017/1/17.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit
import YYModel

class StatusListViewModel {
    
    /// 微博视图模型数组
    lazy var statusList = [StatusViewModel]()
    
    /// 加载微博类别数据
    ///
    /// - Parameters:
    ///   - pullup: 是否是上拉加载
    ///   - finished: 完成回调
    func loadStatus(pullup: Bool, finished: @escaping (_ isSuccess: Bool, _ isShouldRefresh: Bool) -> ()) {
        
        print(pullup ? "上拉加载" : "下拉刷新")
        //  firstId - sinceId: 返回ID比since_id大的微博 更早的微博 下拉刷新最新数据
        let firstId = pullup ? 0 : statusList.first?.status.id ?? 0
        
        //  lastId - maxId: 返回ID小于或等于max_id的微博 更久的微博 上拉加载更久数据
        var lastId = !pullup ? 0 : statusList.last?.status.id ?? 0
        // 因为返回的id小于、或者等于lastId，所以需要减1
        lastId = lastId > 1 ? lastId - 1 : 0
        
        NetworkManager.shared.statusList(sinceId: firstId, maxId: lastId) { (list, isSuccess) in
            
            // 网络请求是否成功
            if !isSuccess {
                finished(false, false)
                return
            }
            
            // 微博视图模型
            var statusList = [StatusViewModel]()
            for dict in list ?? [] {
                guard let model = Status.yy_model(with: dict) else {
                    continue
                }
                statusList.append(StatusViewModel(model: model))
            }
            
            // 取出返回数据里最大id 去进行数据拼接
            let tempFirstId = statusList.first?.status.id ?? 0
            
            // 拼接数据
            if pullup && lastId > tempFirstId {
                self.statusList += statusList
            } else if !pullup && firstId < tempFirstId {
                self.statusList = statusList + self.statusList
            }
            
            // 有新数据才刷新
            statusList.count > 0 ? finished(true, true) : finished(true, false)
            
        }
        
    }
    
}
