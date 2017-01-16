//
//  UIButton+CZAddition.m
//
//  Created by 刘凡 on 16/5/17.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UIButton+CZAddition.h"

@implementation UIButton (CZAddition)

+ (instancetype __nonnull)cz_textButton:(NSString * __nullable)title fontSize:(CGFloat)fontSize normalColor:(UIColor * __nullable)normalColor highlightedColor:(UIColor * __nullable)highlightedColor {
    return [self cz_textButton:title fontSize:fontSize normalColor:normalColor highlightedColor:highlightedColor backgroundImageName:nil];
}

+ (instancetype __nonnull)cz_textButton:(NSString * __nullable)title fontSize:(CGFloat)fontSize normalColor:(UIColor * __nullable)normalColor highlightedColor:(UIColor * __nullable)highlightedColor backgroundImageName:(NSString * __nullable)backgroundImageName {
    
    UIButton *button = [[self alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    if (backgroundImageName != nil) {
        [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
        
        NSString *backgroundImageNameHL = [backgroundImageName stringByAppendingString:@"_highlighted"];
        [button setBackgroundImage:[UIImage imageNamed:backgroundImageNameHL] forState:UIControlStateHighlighted];
    }
    
    [button sizeToFit];
    
    return button;
}

+ (instancetype __nonnull)cz_imageButton:(NSString * __nullable)imageName backgroundImageName:(NSString * __nullable)backgroundImageName {
    
    UIButton *button = [[self alloc] init];
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    NSString *imageNameHL = [imageName stringByAppendingString:@"_highlighted"];
    [button setImage:[UIImage imageNamed:imageNameHL] forState:UIControlStateHighlighted];
    
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    
    NSString *backgroundImageNameHL = [backgroundImageName stringByAppendingString:@"_highlighted"];
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageNameHL] forState:UIControlStateHighlighted];
    
    [button sizeToFit];
    
    return button;
}

@end
