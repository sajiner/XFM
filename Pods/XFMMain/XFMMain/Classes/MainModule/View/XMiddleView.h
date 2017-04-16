//
//  XMiddleView.h
//  XFM
//
//  Created by 张鑫 on 2017/4/15.
//  Copyright © 2017年 张鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMiddleView : UIView

@property (nonatomic, strong) UIImage *middleImage;
@property (nonatomic, copy) void(^middleClickBlock)(BOOL isPlaying);
@property (nonatomic, assign) BOOL isPlaying;

+ (instancetype)middleView;
+ (instancetype)shareInstance;

@end
