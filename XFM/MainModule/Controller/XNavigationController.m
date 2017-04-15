//
//  XNavigationController.m
//  XFM
//
//  Created by 张鑫 on 2017/4/15.
//  Copyright © 2017年 张鑫. All rights reserved.
//

#import "XNavigationController.h"
#import "XNavigationBar.h"
#import "XMiddleView.h"

@interface XNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation XNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:gesture.delegate action:NSSelectorFromString(@"handleNavigationTransition:")];
    [gesture.view addGestureRecognizer:pan];
    gesture.delaysTouchesBegan = YES;
    pan.delegate = self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self setValue:[[XNavigationBar alloc] init] forKey:@"navigationBar"];
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_n"] style:0 target:self action:@selector(back)];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    if (viewController.view.tag == 666) {
        viewController.view.tag = 888;
        
        XMiddleView *middleView = [XMiddleView middleView];
        middleView.middleClickBlock = [XMiddleView shareInstance].middleClickBlock;
        middleView.middleImage = [XMiddleView shareInstance].middleImage;
        middleView.isPlaying = [XMiddleView shareInstance].isPlaying;
        NSLog(@" === %p == %p", middleView, [XMiddleView shareInstance]);
        CGRect frame = middleView.frame;
        CGFloat w = [XMiddleView shareInstance].bounds.size.width;
        CGFloat h = [XMiddleView shareInstance].bounds.size.height;
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        frame.origin.x = (screenSize.width - w) * 0.5;
        frame.origin.y = screenSize.height - h;
        middleView.frame = frame;
        [viewController.view addSubview:middleView];
    }
}

- (void)back {
     [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    // 如果根控制器也要返回手势有效, 就会造成假死状态
    // 所以, 需要过滤根控制器
    if(self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}

@end
