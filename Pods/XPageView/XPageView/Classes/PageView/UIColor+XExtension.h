//
//  UIColor+XExtension.h
//  Demo_Refresh
//
//  Created by sajiner on 2017/3/31.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XExtension)

+ (NSArray *)getRGB: (UIColor *)color;

+ (UIColor *)getColor: (UIColor *)fromColor toColor: (UIColor *)toColor progress: (CGFloat)progress;

@end
