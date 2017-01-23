//
//  Common.swift
//  WeiboSwift
//
//  Created by 周剑峰 on 2017/1/17.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import Foundation

/// MARK: - 微博api
let WB_APP_KEY = "3269898516"
let WB_APP_SECRET = "1c198fe59b234e7e73d379d6caf65bcc"
let WB_REDIRECT_URI = "http://blog.6ag.cn"


// MARK: - 通知
/// 需要用户登录通知
let NEED_USER_LOGIN_NOTIFICATION = "NEED_USER_LOGIN_NOTIFICATION"

/// 用户登录成功通知
let USER_LOGIN_SUCCESS_NOTIFICATION = "USER_LOGIN_SUCCESS_NOTIFICATION"


// MARK: - 微博配图视图常量
/// 配图视图外边距
let STATUS_PICTURE_VIEW_OUTER_MARGIN: CGFloat = 12

/// 配图图片之间的间距
let STATUS_PICTURE_VIEW_INNER_MARGIN: CGFloat = 3

/// 配图视图的宽度
let STATUS_PICTURE_VIEW_WIDHT: CGFloat = UIScreen.cz_screenWidth() - STATUS_PICTURE_VIEW_OUTER_MARGIN * 2

/// 每个图片的宽度
let STATUS_PICTURE_ITEM_WIDTH: CGFloat = (STATUS_PICTURE_VIEW_WIDHT - STATUS_PICTURE_VIEW_INNER_MARGIN * 2) / 3




