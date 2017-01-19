//
//  UserAccount.swift
//  WeiboSwift
//
//  Created by zhoujianfeng on 2017/1/19.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit
import YYModel

class UserAccount: NSObject {
    
    /// token
    var access_token: String?
    
    /// token有效期 秒数
    var expires_in: TimeInterval = 0 {
        didSet {
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    /// 用户id
    var uid: String?
    
    /// 过期日期
    var expiresDate: Date?
    
    /// 保存账号数据的文件路径
    var filePath: String {
        return ("useraccount.json" as NSString).cz_appendDocumentDir()
    }
    
    override init() {
        super.init()
        
        // 反序列化
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
            let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : AnyObject] else {
                return
        }
        
        // 字典转模型
        yy_modelSet(with: dict ?? [:])
        
    }
    
    override var description: String {
        return yy_modelDescription()
    }
    
    /// 保存模型
    func saveAccount() {
        // 模型转字典 - 忽略计算型属性
        var dict = (yy_modelToJSONObject() as? [String : AnyObject]) ?? [:]
        
        // 移除有效期
        _ = dict.removeValue(forKey: "expires_in")
        
        // 序列化，拼接路径
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
            return
        }
        
        // 写入磁盘
        do {
            try data.write(to: URL(fileURLWithPath: filePath))
            print("保存成功，filePath = " + filePath)
        } catch {
            print("保存失败")
        }
        
    }
    
}
