//
//  StatusPictureView.swift
//  WeiboSwift
//
//  Created by zhoujianfeng on 2017/1/21.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit

class StatusPictureView: UIView {
    
    /// 配图视图高度约束
    @IBOutlet weak var heightConstrait: NSLayoutConstraint!
    
    /// 微博视图模型
    var viewModel: StatusViewModel? {
        didSet {
            calcViewSize()
            urls = viewModel?.picUrls
        }
    }
    
    /// 微博配图模型数组
    private var urls: [StatusPicture]? {
        didSet {
            guard let urls = urls else {
                return
            }
            
            // 默认隐藏全部
            for subview in subviews {
                subview.isHidden = true
            }
            
            var index = 0
            for url in urls {
                let imageView = subviews[index] as? UIImageView
                imageView?.isHidden = false
                imageView?.setImage(urlString: url.thumbnail_pic, placeholderImage: nil)
                
                // 4张图的时候需要2行2列显示
                if index == 1 && urls.count == 4 {
                    index += 2
                } else {
                    index += 1
                }
                
            }
        }
    }
    
    /// 根据视图模型的配图视图尺寸，调整内容显示
    private func calcViewSize() {
        
        // 单图和多图第一张图片尺寸需要更新
        if viewModel?.picUrls?.count == 1 {
            var fistSize = viewModel?.pictureViewSize ?? CGSize()
            fistSize.height -= STATUS_PICTURE_VIEW_OUTER_MARGIN
            subviews.first?.frame = CGRect(x: 0,
                                           y: STATUS_PICTURE_VIEW_OUTER_MARGIN,
                                           width: fistSize.width,
                                           height: fistSize.height)
        } else {
            subviews.first?.frame = CGRect(x: 0,
                                           y: STATUS_PICTURE_VIEW_OUTER_MARGIN,
                                           width: STATUS_PICTURE_ITEM_WIDTH,
                                           height: STATUS_PICTURE_ITEM_WIDTH)
        }
        
        // 修改高度约束
        heightConstrait.constant = viewModel?.pictureViewSize.height ?? 0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }
    
}

// MARK: - 设置界面
extension StatusPictureView {
    
    /// 准备UI
    fileprivate func prepareUI() {
        
        // 超出边界的不显示
        clipsToBounds = true
        
        // 背景颜色
        backgroundColor = superview?.backgroundColor
        
        // 每行3列
        let count = 3
        
        let rect = CGRect(x: 0,
                          y: STATUS_PICTURE_VIEW_OUTER_MARGIN,
                          width: STATUS_PICTURE_ITEM_WIDTH,
                          height: STATUS_PICTURE_ITEM_WIDTH)
        
        for i in 0..<count * count {
            
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            let row = CGFloat(i / count)
            let col = CGFloat(i % count)
            
            let xOffset = col * (STATUS_PICTURE_ITEM_WIDTH + STATUS_PICTURE_VIEW_INNER_MARGIN)
            let yOffset = row * (STATUS_PICTURE_ITEM_WIDTH + STATUS_PICTURE_VIEW_INNER_MARGIN)
            
            imageView.frame = rect.offsetBy(dx: xOffset, dy: yOffset)
            addSubview(imageView)
        }
        
    }
}
