//
//  VisitorView.swift
//  WeiboSwift
//
//  Created by zhoujianfeng on 2017/1/16.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit
import SnapKit

/// 访客视图
class VisitorView: UIView {
    
    /// 访客视图信息
    var visitorInfo: [String: String]? {
        didSet {
            guard let imageName = visitorInfo?["imageName"],
                let message = visitorInfo?["message"] else {
                    return
            }
            tipLabel.text = message
            // 首页不修改图片
            if imageName.isEmpty {
                startAnimation()
                return
            }
            bgImageView.image = UIImage(named: imageName)
            hourseImageView.isHidden = true
            grayImageView.isHidden = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 添加旋转动画
    private func startAnimation() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 15
        anim.isRemovedOnCompletion = false
        bgImageView.layer.add(anim, forKey: nil)
    }
    
    // MARK: - 懒加载
    /// 灰色背景图
    fileprivate lazy var grayImageView: UIImageView = UIImageView(
        image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    /// 转圈的背景图
    fileprivate lazy var bgImageView: UIImageView = UIImageView(
        image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    /// 房子
    fileprivate lazy var hourseImageView: UIImageView = UIImageView(
        image: UIImage(named: "visitordiscover_feed_image_house"))
    
    /// 提示文字
    fileprivate lazy var tipLabel: UILabel = UILabel.cz_label(
        withText: "关注一些人，回这里看看有什么惊喜。关注一些人，回这里看看有什么惊喜",
        fontSize: 14,
        color: UIColor.darkGray)
    
    /// 注册按钮
    public lazy var registerButton: UIButton = UIButton.cz_textButton(
        "注册",
        fontSize: 16,
        normalColor: UIColor.orange,
        highlightedColor: UIColor.black,
        backgroundImageName: "common_button_white_disable")
    
    /// 登录按钮
    public lazy var loginButton: UIButton = UIButton.cz_textButton(
        "登录",
        fontSize: 16,
        normalColor: UIColor.orange,
        highlightedColor: UIColor.black,
        backgroundImageName: "common_button_white_disable")
    
}

// MARK: - 设置界面
extension VisitorView {
    
    /// 准备UI
    fileprivate func prepareUI() {
        backgroundColor = UIColor.cz_color(withHex: 0xEDEDED)
        
        tipLabel.preferredMaxLayoutWidth = UIScreen.cz_screenWidth() - 80
        tipLabel.numberOfLines = 0
        
        addSubview(bgImageView)
        addSubview(grayImageView)
        addSubview(hourseImageView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        bgImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        grayImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        hourseImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        tipLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(bgImageView.snp.bottom).offset(20)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self).offset(-80)
            make.top.equalTo(tipLabel.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 120, height: 45))
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self).offset(80)
            make.top.equalTo(tipLabel.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 120, height: 45))
        }
        
    }
}
