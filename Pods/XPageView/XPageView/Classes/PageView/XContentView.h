//
//  XContentView.h
//  Demo_Refresh
//
//  Created by sajiner on 2017/3/30.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTitleView.h"

@class XContentView;
@protocol XContentViewDelegate <NSObject>

- (void)contentView: (XContentView *)contentView targetIndex: (int)targetIndex;
- (void)contentView: (XContentView *)contentView targetIndex: (int)targetIndex progress: (CGFloat)progress;

@end

@interface XContentView : UIView

@property (nonatomic, weak) id <XContentViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray *)childVcs;

@end
