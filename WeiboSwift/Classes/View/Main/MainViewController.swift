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
        delegate = self
        
        // 监听需要用户登录通知
        NotificationCenter.default.addObserver(self, selector: #selector(showUserLogin), name: NSNotification.Name(NEED_USER_LOGIN_NOTIFICATION), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 弹出用户登录界面
    @objc private func showUserLogin() {
        let nav = UINavigationController(rootViewController: OAuthViewController())
        present(nav, animated: true, completion: nil)
    }
    
    /// 让所有子控制器只支持竖屏 这个方法是UIViewController中的，会让当前控制器和他所有子控制器都能被限制方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    /// 发布微博按钮点击
    @objc fileprivate func composeStatus() {
        if NetworkManager.shared.isLogin {
            let composeTypeView = ComposeTypeView()
            composeTypeView.show()
        } else {
            // 发出请求登录的通知
            NotificationCenter.default.post(name: NSNotification.Name(NEED_USER_LOGIN_NOTIFICATION), object: nil)
        }
    }
    
    /// 发布按钮
    fileprivate lazy var composeButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
    
}

// MARK: - 添加子控制器
extension MainViewController {
    
    /// 设置发布按钮
    fileprivate func setupComposeButton() {
        tabBar.addSubview(composeButton)
        let width = tabBar.bounds.width / CGFloat(childViewControllers.count)
        composeButton.frame = tabBar.bounds.insetBy(dx: width * 2, dy: 0)
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
    /// 设置所有子控制器
    fileprivate func setupChildViewControllers() {
        let array = [
            ["clsName" : "HomeViewController",
             "title" : "首页",
             "imageName" : "home",
             "visitorInfo" : [
                "imageName" : "",
                "message" : "关注一些人，回来看看有什么惊喜"
                ]
            ],
            ["clsName" : "MessageViewController",
             "title" : "消息",
             "imageName" : "message_center",
             "visitorInfo" : [
                "imageName" : "visitordiscover_image_message",
                "message" : "登录后，别人评论你的微博，发给你的信息，都会在这里收到通知"
                ]
            ],
            ["clsName" : "UIViewController"],
            ["clsName" : "DiscoverViewController",
             "title" : "发现",
             "imageName" : "discover",
             "visitorInfo" : [
                "imageName" : "visitordiscover_image_message",
                "message" : "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过"
                ]
            ],
            ["clsName" : "ProfileViewController",
             "title" : "我的",
             "imageName" : "profile",
             "visitorInfo" : [
                "imageName" : "visitordiscover_image_profile",
                "message" : "登录后，你的微博、相册、个人资料会显示在这里，展示给别人"
                ]
            ]
        ]
        
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict: dict as [String : AnyObject]))
        }
        
        viewControllers = arrayM
        
    }
    
    /// 使用字典创建一个子控制器
    ///
    /// - Parameter dict: 信息字典[clsName, title, imageName]
    /// - Returns: 子控制器
    private func controller(dict: [String: AnyObject]) -> UIViewController {
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type,
            let visitorInfo = dict["visitorInfo"] as? [String : String]
            
            else {
                return UIViewController()
        }
        
        let vc = cls.init()
        if let baseVc = vc as? BaseViewController {
            baseVc.visitorInfo = visitorInfo
        }
        vc.title = title
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.orange], for: .highlighted)
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        let nav = NavigationController(rootViewController: vc)
        return nav
        
    }
    
}

// MARK: - UITabBarControllerDelegate
extension MainViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let currendIndex: Int = childViewControllers.index(of: viewController) ?? 0
        let lastIndex = selectedIndex
        
        if currendIndex == 0 && currendIndex == lastIndex {
            print("刷新数据")
            let nav = childViewControllers[0] as! NavigationController
            let homeVc = nav.childViewControllers[0] as! HomeViewController
            homeVc.tableView?.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
            
            // 延迟刷新数据，让列表先滚动等顶部
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: { 
                homeVc.refreshControl?.beginRefreshing()
            })
            
        }
        
        return !viewController.isMember(of: UIViewController.classForCoder())
    }
}


