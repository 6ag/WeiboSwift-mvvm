//
//  BaseViewController.swift
//  WeiboSwift
//
//  Created by 周剑峰 on 2017/1/16.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var tableView: UITableView?
    var refreshControl: UIRefreshControl?
    var isPullup = false // 标记上下拉  true上拉  false下拉
    var visitorInfo: [String: String]? // 访客视图信息
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        loadData()
        
        // 监听登录成功的通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loginSuccess(notification:)),
            name: NSNotification.Name(USER_LOGIN_SUCCESS_NOTIFICATION),
            object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 登录成功
    @objc fileprivate func loginSuccess(notification: Notification) {
        // 清除所有顶部导航栏
        navItem.leftBarButtonItem = nil
        navItem.rightBarButtonItem = nil
        // view == nil, 再次调用view的时候会去 loadView -> viewDidLoad
        view = nil
        // 避免重复注册通知
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 加载数据 - 让子类去重写
    func loadData() {
        refreshControl?.endRefreshing()
    }
    
    /// 注册
    @objc fileprivate func register() {
        // 发出请求登录的通知
        NotificationCenter.default.post(name: NSNotification.Name(NEED_USER_LOGIN_NOTIFICATION), object: nil)
    }
    
    /// 登录
    @objc fileprivate func login() {
        // 发出请求登录的通知
        NotificationCenter.default.post(name: NSNotification.Name(NEED_USER_LOGIN_NOTIFICATION), object: nil)
    }
    
    /// 重写title属性，给自定义导航条设置标题
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
    
    // MARK: - 懒加载
    /// 自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    
    /// 自定义导航条的条目
    lazy var navItem = UINavigationItem()
    
}

// MARK: - 设置界面
extension BaseViewController {
    
    /// 准备UI
    fileprivate func prepareUI() {
        view.backgroundColor = UIColor.white
        
        // 如果隐藏了导航栏，会缩进20。需要取消自动缩进
        automaticallyAdjustsScrollViewInsets = false
        
        prepareNavigationBar()
        NetworkManager.shared.isLogin ? prepareTableView() : prepareVisitorView()
        
    }
    
    /// 设置导航条
    private func prepareNavigationBar() {
        // 添加导航条
        view.addSubview(navigationBar)
        // 设置条目
        navigationBar.items = [navItem]
        // 背景颜色
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xf6f6f6)
        // 标题文字颜色
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkGray]
        // 按钮文字颜色
        navigationBar.tintColor = UIColor.orange
        // 是否有半透明效果
        navigationBar.isTranslucent = false
    }
    
    /// 设置登录后的表格视图 - 登录后的视图
    func prepareTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        tableView?.dataSource = self
        tableView?.delegate = self
        
        let inset = UIEdgeInsets(top: navigationBar.bounds.height,
                                 left: 0,
                                 bottom: tabBarController?.tabBar.bounds.height ?? 49,
                                 right: 0)
        // 偏移内容区域
        tableView?.contentInset = inset
        // 偏移滚动条区域
        tableView?.scrollIndicatorInsets = inset
        // 设置刷新控件
        refreshControl = UIRefreshControl()
        
        // 添加刷新控件到表格视图
        tableView?.addSubview(refreshControl!)
        
        // 添加监听方法
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    /// 设置未登录的访客视图 - 登录前的视图
    private func prepareVisitorView() {
        let visitorView = VisitorView(frame: view.bounds.insetBy(dx: 0, dy: 49))
        visitorView.visitorInfo = visitorInfo
        view.insertSubview(visitorView, belowSubview: navigationBar)
        
        visitorView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        visitorView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .done, target: self, action: #selector(register))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .done, target: self, action: #selector(login))
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension BaseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // 取出某组的行数
        let section = tableView.numberOfSections - 1
        let count = tableView.numberOfRows(inSection: section) - 1
        
        // 是否是最后一个cell并且还没有上拉刷新
        if indexPath.row == count && !isPullup {
            isPullup = true
            loadData()
        }
        
    }
    
}
