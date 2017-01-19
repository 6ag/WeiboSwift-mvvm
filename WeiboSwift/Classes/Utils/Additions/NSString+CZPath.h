//
//  NSString+CZPath.h
//
//  Created by 刘凡 on 16/6/10.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CZPath)

/// 给当前文件追加文档路径
- (NSString * __nonnull)cz_appendDocumentDir;

/// 给当前文件追加缓存路径
- (NSString * __nonnull)cz_appendCacheDir;

/// 给当前文件追加临时路径
- (NSString * __nonnull)cz_appendTempDir;

@end
