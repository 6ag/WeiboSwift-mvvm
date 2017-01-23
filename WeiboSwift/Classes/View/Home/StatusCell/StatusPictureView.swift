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
    
    var urls: [StatusPicture]? {
        didSet {
            guard let urls = urls else {
                return
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
            
            // 默认隐藏
            imageView.isHidden = true
        }
        
    }
}
