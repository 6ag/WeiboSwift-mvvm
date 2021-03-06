//
//  StatusCell.swift
//  WeiboSwift
//
//  Created by zhoujianfeng on 2017/1/21.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {
    
    /// 头像
    @IBOutlet weak var iconView: UIImageView!
    
    /// 昵称
    @IBOutlet weak var nicknameLabel: UILabel!
    
    /// 会员等级图标
    @IBOutlet weak var memberIconView: UIImageView!
    
    /// 时间
    @IBOutlet weak var timeLabel: UILabel!
    
    /// 来源
    @IBOutlet weak var sourceLabel: UILabel!
    
    /// 认证图标
    @IBOutlet weak var vipIconView: UIImageView!
    
    /// 微博正文
    @IBOutlet weak var statusLabel: UILabel!
    
    /// 配图区域
    @IBOutlet weak var pictureView: StatusPictureView!
    
    /// 底部工具条
    @IBOutlet weak var toolBar: StatusToolBar!
    
    /// 被转发微博正文
    @IBOutlet weak var retweetedStatusLabel: UILabel!
    
    var viewModel: StatusViewModel? {
        didSet {
            iconView.setAvatarImage(urlString: viewModel?.status.user?.profile_image_url, placeholderImage: UIImage(named: "avatar"))
            vipIconView.image = viewModel?.vipIcon
            nicknameLabel.text = viewModel?.status.user?.screen_name
            memberIconView.image = viewModel?.memberIcon
            statusLabel.text = viewModel?.status.text
            
            // 被转发微博文字
            retweetedStatusLabel?.text = viewModel?.retweetedText
        
            // 微博配图
            pictureView.viewModel = viewModel
            
            // 底部工具条
            toolBar.viewModel = viewModel
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 离屏渲染 - 异步绘制
        layer.drawsAsynchronously = true
        
        // 栅格化 - 异步绘制之后，会生成一张独立的图像，cell在屏幕上滚动的时候，本质滚动的是这张图片
        layer.shouldRasterize = true
        
        // 使用栅格化，需要指定分辨率
        layer.rasterizationScale = UIScreen.main.scale
    }
    
}
