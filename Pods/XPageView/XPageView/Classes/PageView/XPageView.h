//
//  XPageView.h
//  Demo_Refresh
//
//  Created by sajiner on 2017/3/30.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTitleViewConfig.h"

@interface XPageView : UIView

@property (nonatomic, assign) NSInteger currentIndex;

/**
 初始化方法
 
 @param frame frame
 @param titles 标题数组
 @param childVcs 子控制器
 @param parentVc 父控制器
 @return 返回XPageView对象
 */
- (instancetype)initWithFrame:(CGRect)frame titles: (NSArray *)titles childVcs: (NSArray *)childVcs parentVc: (UIViewController *)parentVc;

/**
 更新配置
 
 @param configBlock block
 */
- (void)updateWithConfig: (void(^)(XTitleViewConfig *config))configBlock;

@end
