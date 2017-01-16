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
    var isLogin = false // 是否已经登录 true已经登录 false未登录
    /// 访客视图信息
    var visitorInfo: [String: String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        loadData()
    }
    
    /// 加载数据 - 让子类去重写
    func loadData() {
        refreshControl?.endRefreshing()
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
    func prepareUI() {
        view.backgroundColor = UIColor.white
        
        // 如果隐藏了导航栏，会缩进20。需要取消自动缩进
        automaticallyAdjustsScrollViewInsets = false
        
        prepareNavigationBar()
        isLogin ? prepareTableView() : prepareVisitorView()
        
    }
    
    /// 设置导航条
    private func  prepareNavigationBar() {
        // 添加导航条
        view.addSubview(navigationBar)
        // 设置条目
        navigationBar.items = [navItem]
        // 渲染颜色
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xf6f6f6)
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkGray]
        // 是否有半透明效果
        navigationBar.isTranslucent = false
    }
    
    /// 设置登录后的表格视图
    private func prepareTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        tableView?.dataSource = self
        tableView?.delegate = self
        
        // 向下移动一个导航条的高度
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height,
                                               left: 0,
                                               bottom: tabBarController?.tabBar.bounds.height ?? 49,
                                               right: 0)
        // 设置刷新控件
        refreshControl = UIRefreshControl()
        
        // 添加刷新控件到表格视图
        tableView?.addSubview(refreshControl!)
        
        // 添加监听方法
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    /// 设置未登录的访客视图
    private func prepareVisitorView() {
        let visitorView = VisitorView(frame: view.bounds.insetBy(dx: 0, dy: 49))
        visitorView.visitorInfo = visitorInfo
        view.insertSubview(visitorView, belowSubview: navigationBar)
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
        let row = indexPath.row
        let section = tableView.numberOfSections - 1
        
        if row < 0 || section < 0 {
            return
        }
        
        // 取出某组的行数
        let count = tableView.numberOfRows(inSection: section) - 1
        
        // 是否是最后一个cell并且还没有上拉刷新
        if row == count && !isPullup {
            loadData()
        }
        
    }
    
}
