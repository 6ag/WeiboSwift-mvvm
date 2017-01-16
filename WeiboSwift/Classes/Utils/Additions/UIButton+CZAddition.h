//
//  UIButton+CZAddition.h
//
//  Created by 刘凡 on 16/5/17.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CZAddition)

/**
 创建文本按钮

 @param title            标题文字
 @param fontSize         字体大小
 @param normalColor      默认颜色
 @param highlightedColor 高亮颜色

 @return UIButton
 */
+ (instancetype __nonnull)cz_textButton:(NSString * __nullable)title fontSize:(CGFloat)fontSize normalColor:(UIColor * __nullable)normalColor highlightedColor:(UIColor * __nullable)highlightedColor;


/**
 创建文本按钮

 @param title               标题文字
 @param fontSize            字体大小
 @param normalColor         默认颜色
 @param highlightedColor    高亮颜色
 @param backgroundImageName 背景图像名称

 @return UIButton
 */
+ (instancetype __nonnull)cz_textButton:(NSString * __nullable)title fontSize:(CGFloat)fontSize normalColor:(UIColor * __nullable)normalColor highlightedColor:(UIColor * __nullable)highlightedColor backgroundImageName:(NSString * __nullable)backgroundImageName;

/**
 创建图像按钮

 @param imageName           图像名称
 @param backgroundImageName 背景图像名称

 @return UIButton
 */
+ (instancetype __nonnull)cz_imageButton:(NSString * __nullable)imageName backgroundImageName:(NSString * __nullable)backgroundImageName;

@end
