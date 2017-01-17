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
    
    func loadStatus(finished: @escaping (_ isSuccess: Bool) -> ()) {
        
        let sinceId = statusList.first?.id ?? 0
        let maxId = statusList.last?.id ?? 0
        
        NetworkManager.shared.statusList(sinceId: sinceId, maxId: maxId) { (list, isSuccess) in
            
            guard let array = NSArray.yy_modelArray(with: Status.classForCoder(), json: list ?? []) as? [Status] else {
                finished(false)
                return
            }
            
            // 下拉刷新
            self.statusList = array + self.statusList
            
            finished(true)
        }
        
    }
    
}
