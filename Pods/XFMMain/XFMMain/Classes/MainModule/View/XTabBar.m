//
//  XTabBar.m
//  XFM
//
//  Created by 张鑫 on 2017/4/15.
//  Copyright © 2017年 张鑫. All rights reserved.
//

#import "XTabBar.h"
#import "XMiddleView.h"
#import "UIView+XLayout.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface XTabBar ()

@property (nonatomic, strong) XMiddleView *middleView;

@end

@implementation XTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initElement];
    }
    return self;
}

- (void)initElement {
    self.barStyle = UIBarStyleBlack;
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    NSString *bunleName = [currentBundle.infoDictionary[@"CFBundleName"] stringByAppendingString:@".bundle"];
    NSString *path = [currentBundle pathForResource:@"tabbar_bg@2x.png" ofType:nil inDirectory:bunleName];
    NSString *path1 = [currentBundle pathForResource:@"tabbar_bg@3x.png" ofType:nil inDirectory:bunleName];
    self.backgroundImage = [UIImage imageWithContentsOfFile:path1];
    self.backgroundImage = [UIImage imageWithContentsOfFile:path];
   
    [self addSubview:self.middleView];
    NSLog(@"XTabBar === %p", self.middleView);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = self.items.count;
    
    CGFloat btnW = self.width / (count + 1);
    CGFloat btnH = self.height;
    CGFloat btnY = 5;
    NSInteger index = 0;
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (index == count / 2) {
                index ++;
            }
            CGFloat btnX = index * btnW;
            subView.frame = CGRectMake(btnX, btnY, btnW, btnH);
            
            index ++;
        }
    }
    self.middleView.centerX = self.width * 0.5;
    self.middleView.y = self.height - self.middleView.height;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGPoint pointInMiddleBtn = [self convertPoint:point toView:self.middleView];
    CGPoint middleCenter = CGPointMake(self.middleView.width * 0.5, self.middleView.height * 0.5);
    CGFloat distance = sqrt(pow(pointInMiddleBtn.x - middleCenter.x, 2) + pow(pointInMiddleBtn.y - middleCenter.y, 2));
    NSLog(@"%@", NSStringFromCGPoint(pointInMiddleBtn));
    if (distance > self.middleView.width * 0.5 && pointInMiddleBtn.y < self.middleView.height - self.height) {
        return NO;
    }
    return YES;
}

#pragma mark - setter
- (void)setMiddleClickBlock:(void (^)(BOOL))middleClickBlock {
    self.middleView.middleClickBlock = middleClickBlock;
}

#pragma mark - lazy
- (XMiddleView *)middleView {
    if (!_middleView) {
        // 注意，此处如果使用[XMiddleView middleView]初始化，会造成第一次传递数据不统一
        _middleView = [XMiddleView shareInstance];
        _middleView.bounds = CGRectMake(0, 0, 66, 66);
    }
    return _middleView;
}

@end
