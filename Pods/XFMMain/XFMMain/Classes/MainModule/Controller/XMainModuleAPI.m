//
//  XMainModuleAPI.m
//  Pods
//
//  Created by 张鑫 on 2017/4/16.
//
//

#import "XMainModuleAPI.h"
#import "XTabBarController.h"
#import "XTabBar.h"
#import "XMiddleView.h"
#import "XNavigationBar.h"

@implementation XMainModuleAPI

+ (XTabBarController *)rootTabBarCcontroller {
    return [XTabBarController shareInstance];
}

+ (void)addChildVC:(UIViewController *)vc normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController:(BOOL)isRequired {
    [[XTabBarController shareInstance] addChildVC:vc normalImageName:normalImageName selectedImageName:selectedImageName isRequiredNavController:isRequired];
}

+ (void)setTabbarMiddleBtnClick:(void (^)(BOOL))middleClickBlock {
    XTabBar *tabBar = (XTabBar *)[XTabBarController shareInstance].tabBar;
    tabBar.middleClickBlock = middleClickBlock;
}

+ (void)setNavBarGlobalBackGroundImage:(UIImage *)globalImg {
    [XNavigationBar setGlobalBackGroundImage:globalImg];
}

+ (void)setNavBarGlobalTextColor:(UIColor *)globalTextColor andFontSize:(CGFloat)fontSize {
    [XNavigationBar setGlobalTextColor:globalTextColor andFontSize:fontSize];
}

+ (UIView *)middleView {
    return [XMiddleView middleView];
}


@end
