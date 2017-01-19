//
//  NSString+CZPath.m
//
//  Created by 刘凡 on 16/6/10.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "NSString+CZPath.h"

@implementation NSString (CZPath)

- (NSString * __nonnull)cz_appendDocumentDir {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString * __nonnull)cz_appendCacheDir {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString * __nonnull)cz_appendTempDir {
    NSString *dir = NSTemporaryDirectory();
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

@end
