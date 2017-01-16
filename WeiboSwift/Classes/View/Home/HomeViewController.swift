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

        prepareUI()
        
        // 假数据
        for index in 0..<20 {
            statusList.insert(index.description, at: 0)
        }
        
//        tableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: CELL_IDENTIFIER)
        
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
//        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath)
        let cell = UITableViewCell()
        cell.textLabel?.text = statusList[indexPath.row]
        return cell
    }
    
}

