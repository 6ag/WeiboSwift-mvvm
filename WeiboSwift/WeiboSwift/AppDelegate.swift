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
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        // 反射
        let cls = NSClassFromString("\(Bundle.main.namespace).ViewController") as? UIViewController.Type
        window?.rootViewController = cls?.init()
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

