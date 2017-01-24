//
//  JFRefreshView.swift
//  tableviewTest
//
//  Created by zhoujianfeng on 2017/1/24.
//  Copyright © 2017年 zhoujianfeng. All rights reserved.
//

import UIKit

class JFRefreshView: UIView {

    /// 指示器
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    /// 箭头图标
    @IBOutlet weak var arrowIconView: UIImageView!
    
    /// 刷新文本
    @IBOutlet weak var refreshLabel: UILabel!
    
    /// 刷新状态
    var refreshState = JFRefreshState.normal {
        didSet {
            switch refreshState {
            case .normal:
                // 恢复状态
                indicatorView.stopAnimating()
                arrowIconView.isHidden = false
                
                refreshLabel.text = "下拉刷新"
                UIView.animate(withDuration: 0.25, animations: { 
                    self.arrowIconView.transform = CGAffineTransform.identity
                })
            case .pulling:
                refreshLabel.text = "释放更新"
                UIView.animate(withDuration: 0.25, animations: { 
                    self.arrowIconView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
                })
            case .willRefresh:
                refreshLabel.text = "加载中..."
                arrowIconView.isHidden = true
                indicatorView.startAnimating()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        refreshLabel.text = "下拉刷新"
    }

    /// 创建刷新视图
    ///
    /// - Returns: 刷新视图
    class func refreshView() -> JFRefreshView {
        let nib = UINib(nibName: "JFRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0] as! JFRefreshView
    }
    
    /// 将要添加到父控件时，将背景颜色和父控件背景颜色统一
    ///
    /// - Parameter newSuperview: 新的父控件
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        guard let newSuperview = newSuperview else { return }
        backgroundColor = newSuperview.backgroundColor
    }
    
}
