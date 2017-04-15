//
//  CALayer+XAnimate.m
//  XFM
//
//  Created by 张鑫 on 2017/4/15.
//  Copyright © 2017年 张鑫. All rights reserved.
//

#import "CALayer+XAnimate.h"

@implementation CALayer (XAnimate)

- (void)pauseAnimate {
    CFTimeInterval pauseTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0;
    self.timeOffset = pauseTime;
}

- (void)resumeAnimate {
    CFTimeInterval pauseTime = self.timeOffset;
    self.speed = 1;
    self.timeOffset = 0;
    CFTimeInterval timeDelta = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    self.beginTime = timeDelta;
}

@end
