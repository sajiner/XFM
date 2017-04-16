//
//  UIColor+XExtension.m
//  Demo_Refresh
//
//  Created by sajiner on 2017/3/31.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "UIColor+XExtension.h"

@implementation UIColor (XExtension)

+ (NSArray *)getRGB:(UIColor *)color {
    
    CGFloat r = 0;
    CGFloat g = 0;
    CGFloat b = 0;
    CGFloat a = 0;
    [color getRed:&r green:&g blue:&b alpha:&a];
    return @[@(r), @(g), @(b)];
}

+ (UIColor *)getColor:(UIColor *)fromColor toColor:(UIColor *)toColor progress:(CGFloat)progress {
    NSArray *fromArr = [self getRGB:fromColor];
    NSArray *toArr = [self getRGB:toColor];
    CGFloat rDelta = - [fromArr[0] floatValue] + [toArr[0] floatValue];
    CGFloat gDelta = - [fromArr[1] floatValue] + [toArr[1] floatValue];
    CGFloat bDelta = - [fromArr[2] floatValue] + [toArr[2] floatValue];
    
    CGFloat resultR = [fromArr[0] floatValue] + rDelta * progress;
    CGFloat resultG = [fromArr[1] floatValue] + gDelta * progress;
    CGFloat resultB = [fromArr[2] floatValue] + bDelta * progress;
    return [UIColor colorWithRed:resultR green:resultG blue:resultB alpha:1.0];
}

@end
