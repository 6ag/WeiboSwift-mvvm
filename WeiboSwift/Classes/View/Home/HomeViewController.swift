//
//  HomeViewController.swift
//  WeiboSwift
//
//  Created by 周剑峰 on 2017/1/16.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit

fileprivate let CELL_IDENTIFIER = "status_list_cell"

class HomeViewController: BaseViewController {

    fileprivate var statusList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /// 加载数据
    override func loadData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            
            if self.refreshControl?.isRefreshing ?? false {
                // 停止刷新
                self.refreshControl?.endRefreshing()
            }
            
            // 假数据
            for index in 0..<20 {
                if self.isPullup {
                    self.statusList.append(index.description)
                    self.isPullup = false
                } else {
                    self.statusList.insert(index.description, at: 0)
                }
                
            }
            
            // 刷新数据
            self.tableView?.reloadData()
        }
    }
    
    /// 跳转到朋友界面
    @objc fileprivate func showFriends() {
        navigationController?.pushViewController(MessageViewController(), animated: true)
    }
    
}

// MARK: - 设置界面
extension HomeViewController {
    
    /// 准备UI
    override internal func prepareUI() {
        super.prepareUI()
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
    }
}

// MARK: - 数据源
extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = statusList[indexPath.row]
        return cell
    }
    
}

