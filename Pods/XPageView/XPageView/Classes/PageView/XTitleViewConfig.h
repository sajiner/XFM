//
//  XTitleViewConfig.h
//  Demo_Refresh
//
//  Created by sajiner on 2017/3/30.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTitleViewConfig : NSObject

/**
 字体大小
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 字正常颜色
 */
@property (nonatomic, strong) UIColor *norColor;

/**
 选中的颜色
 */
@property (nonatomic, strong) UIColor *selColor;

/**
 是否展示下划线
 */
@property (nonatomic, assign) BOOL isShowUnderLine;

/**
 下划线的颜色
 */
@property (nonatomic, strong) UIColor *indicatorColor;

/**
 下划线高度
 */
@property (nonatomic, assign) CGFloat indicatorHeight;

/**
 是否滑动
 */
@property (nonatomic, assign) BOOL isScroll;

/**
 XTitleView的高度
 */
@property (nonatomic, assign) CGFloat titleViewHeight;

/**
 item之间的间距
 */
@property (nonatomic, assign) CGFloat margin;

/**
 类方法
 */
+ (instancetype)defaultConfig;

@end
