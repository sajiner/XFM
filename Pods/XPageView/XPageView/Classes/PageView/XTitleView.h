//
//  XTitleView.h
//  Demo_Refresh
//
//  Created by sajiner on 2017/3/30.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XContentView.h"

#define kWidth self.frame.size.width

@class XTitleView, XTitleViewConfig;
@protocol XTitleViewDelegate <NSObject>

/**
 代理方法, 告诉外界, 内部的点击数据
 
 @param titleView titleView
 @param toIndex    选中的索引(从0开始)
 @param fromIndex  上一个索引
 */
- (void)titleView: (XTitleView *)titleView didSelectIndex: (NSInteger)toIndex fromIndex: (NSInteger)fromIndex;

@end

@interface XTitleView : UIView

@property (nonatomic, weak) id <XTitleViewDelegate> delegate;

/**
 初始化方法

 @param frame frame
 @param titles 盛放title的数组
 @return 对象
 */
- (instancetype)initWithFrame:(CGRect)frame titles: (NSArray *)titles config: (XTitleViewConfig *)config;

/**
 更新配置

 @param configBlock block
 */
- (void)updateWithConfig: (void(^)(XTitleViewConfig *config))configBlock;

@end
