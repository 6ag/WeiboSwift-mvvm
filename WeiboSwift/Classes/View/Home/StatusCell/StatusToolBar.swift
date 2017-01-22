//
//  StatusToolBar.swift
//  WeiboSwift
//
//  Created by zhoujianfeng on 2017/1/21.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit

class StatusToolBar: UIView {

    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var commentButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    var viewModel: StatusViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            retweetButton.setTitle(viewModel.retweetString, for: .normal)
            commentButton.setTitle(viewModel.commentString, for: .normal)
            likeButton.setTitle(viewModel.likeString, for: .normal)
        }
    }
    
}
