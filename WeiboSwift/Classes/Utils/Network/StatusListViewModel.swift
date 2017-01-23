//
//  StatusListViewModel.swift
//  WeiboSwift
//
//  Created by zhoujianfeng on 2017/1/17.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit
import YYModel
import SDWebImage

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
            var tempStatusList = [StatusViewModel]()
            for dict in list ?? [] {
                guard let model = Status.yy_model(with: dict) else {
                    continue
                }
                tempStatusList.append(StatusViewModel(model: model))
            }
            
            // 取出返回数据里最大id 去进行数据拼接
            let tempFirstId = tempStatusList.first?.status.id ?? 0
            
            // 拼接数据
            if pullup && lastId > tempFirstId {
                self.statusList += tempStatusList
            } else if !pullup && firstId < tempFirstId {
                self.statusList = tempStatusList + self.statusList
            }
            
            // 有新数据才刷新
            if tempStatusList.count > 0 {
                self.cacheSingleImage(list: tempStatusList, finished: finished)
            } else {
                finished(true, false)
            }
        }
        
    }
    
    /// 缓存单张图片
    ///
    /// - Parameter list: 本次下载的视图模型数组
    private func cacheSingleImage(list: [StatusViewModel], finished: @escaping (_ isSuccess: Bool, _ isShouldRefresh: Bool) -> ()) {
        
        // 创建一个调度组
        let group = DispatchGroup()
        
        // 记录数据长度
        var length = 0
        
        for viewModel in list {
            if viewModel.picUrls?.count != 1 {
                continue
            }
            
            guard let pic = viewModel.picUrls?.first?.thumbnail_pic,
                let url = URL(string: pic) else {
                    return
            }
            
            // 进入组
            group.enter()
            SDWebImageManager.shared().downloadImage(with: url, options: [], progress: nil, completed: { (image, _, _, _, _) in
                if let image = image,
                    let data = UIImagePNGRepresentation(image) {
                    length += data.count
                    // 更新单图尺寸
                    viewModel.updateSingleImageSize(image: image)
                }
                // 离开组
                group.leave()
            })
            
        }
        
        // 所有进入的组都已经离开，就会执行这个闭包，回调结果
        group.notify(queue: DispatchQueue.main) {
            print("这次刷新加载了 \(length / 1024)kb图片数据")
            finished(true, true)
        }
        
    }
    
}
