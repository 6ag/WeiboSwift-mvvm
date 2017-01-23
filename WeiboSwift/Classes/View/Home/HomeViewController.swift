//
//  HomeViewController.swift
//  WeiboSwift
//
//  Created by 周剑峰 on 2017/1/16.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit

fileprivate let ORIGINAL_CELL_IDENTIFIER = "ORIGINAL_CELL_IDENTIFIER"
fileprivate let RETWEETED_CELL_IDENTIFIER = "RETWEETED_CELL_IDENTIFIER"

class HomeViewController: BaseViewController {

    fileprivate var listViewModel = StatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /// 加载数据
    override func loadData() {
        
        if !NetworkManager.shared.isLogin {
            print("用户未登录，无需加载数据")
            return
        }
        
        listViewModel.loadStatus(pullup: isPullup) { (isSuccess, isShouldRefresh) in
            self.refreshControl?.endRefreshing()
            self.isPullup = false
            
            // 有更多数据才刷新
            if isShouldRefresh {
                self.tableView?.reloadData()
            }
            
        }
    }
    
}

// MARK: - 设置界面
extension HomeViewController {
    
    /// 准备UI
    override func prepareTableView() {
        super.prepareTableView()
        
        tableView?.register(UINib(nibName: "StatusNormalCell", bundle: nil),
                            forCellReuseIdentifier: ORIGINAL_CELL_IDENTIFIER)
        tableView?.register(UINib(nibName: "StatusRetweetedCell", bundle: nil),
                            forCellReuseIdentifier: RETWEETED_CELL_IDENTIFIER)
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 300
        tableView?.separatorStyle = .none
    }
}

// MARK: - 数据源
extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = listViewModel.statusList[indexPath.row]
        let cellId = viewModel.status.retweeted_status == nil ? ORIGINAL_CELL_IDENTIFIER : RETWEETED_CELL_IDENTIFIER
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! StatusCell
        cell.viewModel = listViewModel.statusList[indexPath.row]
        return cell
    }
    
}

