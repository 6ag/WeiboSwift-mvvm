//
//  JFRefreshControl.swift
//  WeiboSwift
//
//  Created by zhoujianfeng on 2017/1/23.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit

private let JFRefreshOffset: CGFloat = 64

/// 刷新状态
///
/// - normal: 普通状态，什么都不做
/// - pulling: 超过临界点，如果放手就开始刷新
/// - willRefresh: 超过临界点，已经放手，将进行刷新
enum JFRefreshState {
    case normal
    case pulling
    case willRefresh
}

/// 刷新相关的逻辑处理 刷新步骤：下拉开始刷新、松开开始刷新、正在刷新
class JFRefreshControl: UIControl {

    /// 刷新控件的父视图
    private weak var scrollView: UIScrollView?
    
    /// 刷新视图
    fileprivate lazy var refreshView: JFRefreshView = JFRefreshView.refreshView()
    
    init() {
        super.init(frame: CGRect())
        prepareUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareUI()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        guard let sv = newSuperview as? UIScrollView else { return }
        scrollView = sv
        
        // kvo监听父控件偏移量
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
    }
    
    override func removeFromSuperview() {
        // 移除监听
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        super.removeFromSuperview()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let scrollView = scrollView else { return }
        
        let height = -(scrollView.contentInset.top + scrollView.contentOffset.y)
        if height < 0 {
            return
        }
        
        frame = CGRect(x: 0, y: -height, width: scrollView.bounds.width, height: height)

        if scrollView.isDragging { // 正在拖拽
            
            if height > JFRefreshOffset && refreshView.refreshState == .normal {
                // 超过临界点，并且状态是normal。也就是拉过了临界点的时候
                refreshView.refreshState = .pulling
            } else if height <= JFRefreshOffset && refreshView.refreshState == .pulling {
                // 小于了临界点，并且状态是pulling。也就是从超过了临界点拽上去了
                refreshView.refreshState = .normal
            }
            
        } else { // 放手
            
            if refreshView.refreshState == .pulling {
                // 开始刷新
                beginRefreshing()
            }
            
        }
        
    }
    
    /// 开始刷新
    func beginRefreshing() {
        guard let scrollView = scrollView, refreshView.refreshState != .willRefresh else { return }
        
        // 刷新结束后，将状态改为.normal才能继续响应刷新
        refreshView.refreshState = .willRefresh
        
        // 让表格悬停 - 刷新完成后需要恢复
        UIView.animate(withDuration: 0.25) { 
            scrollView.contentInset.top += JFRefreshOffset
        }
        
        // 发送值改变事件
        sendActions(for: .valueChanged)
    }
    
    /// 结束刷新
    func endRefreshing() {
        guard let scrollView = scrollView, refreshView.refreshState == .willRefresh else { return }
        
        // 修改为默认刷新状态
        refreshView.refreshState = .normal
                
        // 恢复悬停
        UIView.animate(withDuration: 0.25) {
            scrollView.contentInset.top -= JFRefreshOffset
        }
        
    }
    
}

// MARK: - 界面设置
extension JFRefreshControl {
    
    /// 准备UI
    fileprivate func prepareUI() {
        backgroundColor = superview?.backgroundColor
        
        addSubview(refreshView)
        
        // 刷新视图水平居中、底部和刷新控件对齐
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.width))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.height))
    }
}
