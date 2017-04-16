//
//  XPageView.h
//  Demo_Refresh
//
//  Created by sajiner on 2017/3/30.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTitleView;
@interface XPageView : UIView

@property (nonatomic, strong) XTitleView *titleView;

- (instancetype)initWithFrame:(CGRect)frame titles: (NSArray *)titles childVcs: (NSArray *)childVcs ;

//- (void)updateWithConfig: (void(^)(XTitleViewConfig *config))configBlock;

@end
