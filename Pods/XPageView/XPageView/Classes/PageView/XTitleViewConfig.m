//
//  XTitleViewConfig.m
//  Demo_Refresh
//
//  Created by sajiner on 2017/3/30.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "XTitleViewConfig.h"

@implementation XTitleViewConfig

+ (instancetype)defaultConfig {
    XTitleViewConfig *config = [[XTitleViewConfig alloc] init];
    config.titleFont = [UIFont systemFontOfSize:12];
    config.norColor = [UIColor lightGrayColor];
    config.selColor = [UIColor redColor];
    
    config.isShowUnderLine = YES;
    config.indicatorColor = [UIColor redColor];
    
    config.isScroll = YES;
    config.margin = 10;
    
    config.titleViewHeight = 40;
    
    return config;
}



@end
