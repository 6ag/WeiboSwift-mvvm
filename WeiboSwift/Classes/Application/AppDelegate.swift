//
//  AppDelegate.swift
//  WeiboSwift
//
//  Created by 周剑峰 on 2017/1/15.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupViewController()  // 配置控制器
        
        return true
    }
    
    /// 配置控制器
    private func setupViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
    }
    
}

