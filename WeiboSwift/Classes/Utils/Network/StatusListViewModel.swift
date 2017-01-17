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
    
    /// 微博模型数组
    lazy var statusList = [Status]()
    
    /// 加载微博类别数据
    ///
    /// - Parameters:
    ///   - pullup: 是否是上拉加载
    ///   - finished: 完成回调
    func loadStatus(pullup: Bool, finished: @escaping (_ isSuccess: Bool, _ isShouldRefresh: Bool) -> ()) {
        
        //  firstId - sinceId: 返回ID比since_id大的微博 更早的微博 下拉刷新最新数据
        let firstId = !pullup ? 0 : statusList.first?.id ?? 0
        
        //  lastId - maxId: 返回ID小于或等于max_id的微博 更久的微博 上拉加载更久数据
        let lastId = pullup ? 0 : statusList.last?.id ?? 0
        
        NetworkManager.shared.statusList(sinceId: firstId, maxId: lastId) { (list, isSuccess) in
            
            guard let array = NSArray.yy_modelArray(with: Status.classForCoder(), json: list ?? []) as? [Status] else {
                finished(false, false)
                return
            }
            
            // 取出返回数据里最大id 去进行数据拼接
            let tempFirstId = array.first?.id ?? 0
            print("firstId = \(firstId) lastId = \(lastId) tempFirstId = \(tempFirstId)")
            
            if pullup && lastId > tempFirstId {
                self.statusList += array
            } else if firstId < tempFirstId {
                self.statusList = array + self.statusList
            }
            
            if array.count > 0 {
                finished(true, true)
            } else {
                finished(true, false)
            }
            
        }
        
    }
    
}
