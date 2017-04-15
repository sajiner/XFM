//
//  XTabBarController.m
//  XFM
//
//  Created by 张鑫 on 2017/4/15.
//  Copyright © 2017年 张鑫. All rights reserved.
//

#import "XTabBarController.h"
#import "XTabBar.h"
#import "XNavigationController.h"
#import "UIImage+XImage.h"
#import "XMiddleView.h"

@interface XTabBarController ()

@end

@implementation XTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBar];
}

#pragma mark - 设置tabbar
- (void)setupTabBar {
    [self setValue:[[XTabBar alloc] init] forKey:@"tabBar"];
}

#pragma mark - 单例
static XTabBarController *_tabbarC;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tabbarC = [[XTabBarController alloc] init];
    });
    return _tabbarC;
}

#pragma mark - public method
- (void)addChildVC:(UIViewController *)vc normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController:(BOOL)isRequired {
    if (isRequired) {
        XNavigationController *nav = [[XNavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage originImageWithName:normalImageName] selectedImage:[UIImage originImageWithName:selectedImageName]];
        [self addChildViewController:nav];
    } else {
        
    }
}

+ (instancetype)tabBarControllerWithAddChildVCsBlock:(void (^)(XTabBarController *))addVCBlock {
    XTabBarController *tabbarVC = [[XTabBarController alloc] init];
    if (addVCBlock) {
        addVCBlock(tabbarVC);
    }
    
    return tabbarVC;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    UIViewController *vc = self.childViewControllers[selectedIndex];
    if (vc.view.tag == 666) {
        vc.view.tag = 888;
        
        XMiddleView *middleView = [XMiddleView middleView];
        middleView.middleClickBlock = [XMiddleView shareInstance].middleClickBlock;
        middleView.middleImage = [XMiddleView shareInstance].middleImage;
        middleView.isPlaying = [XMiddleView shareInstance].isPlaying;
        
        CGRect frame = middleView.frame;
        CGFloat w = [XMiddleView shareInstance].bounds.size.width;
        CGFloat h = [XMiddleView shareInstance].bounds.size.height;
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        frame.origin.x = (screenSize.width - w) * 0.5;
        frame.origin.y = screenSize.height - h;
        middleView.frame = frame;
        [vc.view addSubview:middleView];
    }
}

@end
