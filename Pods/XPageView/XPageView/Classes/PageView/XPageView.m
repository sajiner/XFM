//
//  XPageView.m
//  Demo_Refresh
//
//  Created by sajiner on 2017/3/30.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "XPageView.h"
#import "XTitleView.h"
#import "XTitleViewConfig.h"
#import "XContentView.h"

@interface XPageView () {
    NSArray *_titles;
    NSArray *_childVcs;
}

@property (nonatomic, strong) XContentView *contentView;

@property (nonatomic, strong) XTitleViewConfig *config;

@end

@implementation XPageView

- (instancetype)initWithFrame:(CGRect)frame titles: (NSArray *)titles childVcs: (NSArray *)childVcs {
    self = [super initWithFrame:frame];
    if (self) {
        _titles = titles;
        _childVcs = childVcs;
        [self initElement:titles];
    }
    return self;
}

- (void)initElement: (NSArray *)titles {
    
    _titleView = [[XTitleView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.config.titleViewHeight) titles:titles config:self.config];
    [self addSubview:_titleView];
    
    CGRect frame = CGRectMake(0, self.config.titleViewHeight, self.frame.size.width, self.frame.size.height - self.config.titleViewHeight);
    _contentView = [[XContentView alloc] initWithFrame:frame childVcs:_childVcs];
    [self addSubview:_contentView];
    
    _titleView.delegate = (id)_contentView;
    _contentView.delegate = (id)_titleView;
}

#pragma mark - lazy
- (XTitleViewConfig *)config {
    if (!_config) {
        _config = [XTitleViewConfig defaultConfig];
    }
    return _config;
}

@end
