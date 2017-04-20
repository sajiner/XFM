//
//  XPageView.m
//  Demo_Refresh
//
//  Created by sajiner on 2017/3/30.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "XPageView.h"
#import "XTitleView.h"
#import "XContentView.h"

@interface XPageView () {
    NSArray *_titles;
    NSArray *_childVcs;
}

@property (nonatomic, strong) XContentView *contentView;
@property (nonatomic, strong) XTitleViewConfig *config;
@property (nonatomic, strong) XTitleView *titleView;

@end

@implementation XPageView

- (instancetype)initWithFrame:(CGRect)frame titles: (NSArray *)titles childVcs: (NSArray *)childVcs parentVc:(UIViewController *)parentVc {
    self = [super initWithFrame:frame];
    if (self) {
        if (parentVc.childViewControllers.count > 0) {
            for (UIViewController *vc in parentVc.childViewControllers) {
                [vc removeFromParentViewController];
            }
        }
        for (UIViewController *vc in childVcs) {
            [parentVc addChildViewController:vc];
        }
        _titles = titles;
        _childVcs = childVcs;
        [self initElement:_titles];
    }
    return self;
}

- (void)initElement: (NSArray *)titles {
    
    _titleView = [[XTitleView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.config.titleViewHeight) titles:titles config:self.config ];
    [self addSubview:_titleView];
    
    CGRect frame = CGRectMake(0, self.config.titleViewHeight, self.frame.size.width, self.frame.size.height - self.config.titleViewHeight);
    _contentView = [[XContentView alloc] initWithFrame:frame childVcs:_childVcs];
    [self addSubview:_contentView];
    
#warning why
    _titleView.delegate = (id)_contentView;
    _contentView.delegate = (id)_titleView;
}

- (void)updateWithConfig:(void (^)(XTitleViewConfig *))configBlock {
    [self.titleView updateWithConfig:configBlock];
}

#pragma mark - setter
- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    _titleView.currentIndex = currentIndex;
}

#pragma mark - lazy
- (XTitleViewConfig *)config {
    if (!_config) {
        _config = [XTitleViewConfig defaultConfig];
    }
    return _config;
}

@end
