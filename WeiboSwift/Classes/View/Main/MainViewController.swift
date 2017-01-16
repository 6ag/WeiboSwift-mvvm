//
//  MainViewController.swift
//  WeiboSwift
//
//  Created by 周剑峰 on 2017/1/16.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildViewControllers()
        setupComposeButton()
    }
    
    /// 让所有子控制器只支持竖屏 这个方法是UIViewController中的，会让当前控制器和他所有子控制器都能被限制方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    /// 发布微博按钮点击
    @objc fileprivate func composeStatus() {
        print("发布微博")
    }
    
    /// 发布按钮
    fileprivate lazy var composeButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
    
}

// MARK: - 添加子控制器
extension MainViewController {
    
    /// 设置发布按钮
    fileprivate func setupComposeButton() {
        tabBar.addSubview(composeButton)
        let width = tabBar.bounds.width / CGFloat(childViewControllers.count) - 1
        composeButton.frame = tabBar.bounds.insetBy(dx: width * 2, dy: 0)
        print("composeButton.frame = \(composeButton.frame)")
        
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
        
    }
    
    /// 设置所有子控制器
    fileprivate func setupChildViewControllers() {
        let array = [
            ["clsName" : "HomeViewController", "title" : "首页", "imageName" : "home"],
            ["clsName" : "MessageViewController", "title" : "消息", "imageName" : "message_center"],
            ["clsName" : "UIViewController"],
            ["clsName" : "DiscoverViewController", "title" : "发现", "imageName" : "discover"],
            ["clsName" : "ProfileViewController", "title" : "我的", "imageName" : "profile"]
        ]
        
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict: dict))
        }
        
        viewControllers = arrayM
        
    }
    
    /// 使用字典创建一个子控制器
    ///
    /// - Parameter dict: 信息字典[clsName, title, imageName]
    /// - Returns: 子控制器
    private func controller(dict: [String: String]) -> UIViewController {
        guard let clsName = dict["clsName"],
            let title = dict["title"],
            let imageName = dict["imageName"],
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type
            else {
                return UIViewController()
        }
        
        let vc = cls.init()
        vc.title = title
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.orange], for: .highlighted)
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        let nav = NavigationViewController(rootViewController: vc)
        return nav
        
    }
    
}
