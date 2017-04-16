//
//  UIImage+XImage.m
//  XFM
//
//  Created by 张鑫 on 2017/4/15.
//  Copyright © 2017年 张鑫. All rights reserved.
//

#import "UIImage+XImage.h"

@implementation UIImage (XImage)

+ (UIImage *)originImageWithName:(NSString *)name {
    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


@end
