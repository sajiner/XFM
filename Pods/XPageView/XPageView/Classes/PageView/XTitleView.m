//
//  XTitleView.m
//  Demo_Refresh
//
//  Created by sajiner on 2017/3/30.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "XTitleView.h"
#import "XTitleViewConfig.h"
#import "XContentView.h"
#import "UIColor+XExtension.h"

@interface XTitleView ()<XContentViewDelegate> {
    UILabel *_lastLabel;  /// 纪录最后一次点击的label
    XTitleViewConfig *_config;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *lineView;
/// 盛放label的arr
@property (nonatomic, strong) NSMutableArray *labelArr;

@end

@implementation XTitleView

- (instancetype)initWithFrame:(CGRect)frame titles: (NSArray *)titles config:(XTitleViewConfig *)config {
    self = [super initWithFrame:frame];
    if (self) {
        _config = config;
        [self initElement: titles];
    }
    return self;
}

- (void)initElement: (NSArray *)titles {
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    NSUInteger count = titles.count;
    for (int i = 0; i < count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.font = _config.titleFont;
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        label.textColor = _config.norColor;
        if (i == 0) {
            label.textColor = _config.selColor;
        }
        label.text = titles[i];
        label.userInteractionEnabled = YES;
        [_scrollView addSubview:label];
        [self.labelArr addObject:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [label addGestureRecognizer:tap];
    }
    
    _lastLabel = self.labelArr[0];
    
    if (_config.isShowUnderLine) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = _config.indicatorColor;
        [_scrollView addSubview:_lineView];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _scrollView.frame = CGRectMake(0, 0, kWidth, _config.titleViewHeight);
    
    CGFloat w = 0;
    CGFloat h = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    
    NSUInteger count = self.labelArr.count;
    for (int i = 0; i < count; i++) {
        UILabel *label = self.labelArr[i];
        label.tag = i;
        
        h = (_config.isShowUnderLine ? _config.titleViewHeight - 1 : _config.titleViewHeight);
        if (_config.isScroll) {  // 如果滑动
            w = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                              NSFontAttributeName:_config.titleFont
                            }context:nil].size.width;
            if (i == 0) {
                x = _config.margin;
            } else {
                UILabel *lastLabel = self.labelArr[i - 1];
                x = CGRectGetMaxX(lastLabel.frame) + _config.margin;
            }
        } else {
            w = kWidth / count;
            x = w * i;
        }
        label.frame = CGRectMake(x, y, w, h);
    }
    UILabel *lastLabel = self.labelArr.lastObject;
    _scrollView.contentSize = (_config.isScroll ? CGSizeMake(CGRectGetMaxX(lastLabel.frame) + _config.margin, 0) : CGSizeMake(kWidth, 0));
    
    UILabel *firstLabel = self.labelArr.firstObject;
    if (_config.isShowUnderLine) {
        _lineView.frame = (_config.isScroll ? CGRectMake(_config.margin, _config.titleViewHeight - _config.indicatorHeight, CGRectGetWidth(firstLabel.frame), _config.indicatorHeight) : CGRectMake(0, _config.titleViewHeight - _config.indicatorHeight, kWidth / count, _config.indicatorHeight));
    }
}

#pragma mark - event
- (void)tap: (UITapGestureRecognizer *)tap {
    UILabel *selLabel = (UILabel *)tap.view;
    
    if ([self.delegate respondsToSelector:@selector(titleView:didSelectIndex:fromIndex:)]) {
        [self.delegate titleView:self didSelectIndex:selLabel.tag fromIndex:_lastLabel.tag];
    }
    [self setupLabel:selLabel];
    
    if (_config.isShowUnderLine) {
        [UIView animateWithDuration:0.25 animations:^{
            _lineView.frame = CGRectMake(CGRectGetMinX(selLabel.frame), _config.titleViewHeight - _config.indicatorHeight, CGRectGetWidth(selLabel.frame), _config.indicatorHeight);
        }];
    }
}

#pragma mark - public method   更新配置
- (void)updateWithConfig:(void (^)(XTitleViewConfig *))configBlock {
    if (configBlock) {
        configBlock(_config);
    }
    
    _lineView.backgroundColor = _config.indicatorColor;
    for (UILabel *label in self.labelArr) {
        label.font = _config.titleFont;
        label.textColor = _config.norColor;
        if ([label isEqual:_lastLabel]) {
            label.textColor = _config.selColor;
        }
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - XContentViewDelegate
- (void)contentView:(XContentView *)contentView targetIndex:(int)targetIndex {
    UILabel *selLabel = self.labelArr[targetIndex];
    [self setupLabel:selLabel];
}

- (void)contentView:(XContentView *)contentView targetIndex:(int)targetIndex progress:(CGFloat)progress {
    UILabel *selLabel = self.labelArr[targetIndex];
    
    selLabel.textColor = [UIColor getColor:_config.norColor toColor:_config.selColor progress:progress];
    _lastLabel.textColor = [UIColor getColor:_config.selColor toColor:_config.norColor progress:progress];
    
    if (_config.isShowUnderLine) {
        CGFloat x = (selLabel.frame.origin.x - _lastLabel.frame.origin.x) * progress + _lastLabel.frame.origin.x;
        CGFloat w = (CGRectGetWidth(selLabel.frame) - CGRectGetWidth(_lastLabel.frame)) * progress + CGRectGetWidth(_lastLabel.frame);
        _lineView.frame = CGRectMake(x, _config.titleViewHeight - _config.indicatorHeight, w, _config.indicatorHeight);
    }
}

#pragma mark - private
- (void)setupLabel: (UILabel *)selLabel {
    if (_lastLabel.tag == selLabel.tag) {
        return;
    }
    selLabel.textColor = _config.selColor;
    _lastLabel.textColor = _config.norColor;
    
    if (_config.isScroll) {
        CGFloat offsetX = selLabel.center.x - self.bounds.size.width * 0.5;
        if (offsetX < 0) {
            offsetX = 0;
        } else if (offsetX > self.scrollView.contentSize.width - self.scrollView.bounds.size.width) {
            offsetX = self.scrollView.contentSize.width - self.scrollView.bounds.size.width;
        }
        [self.scrollView setContentOffset:CGPointMake(offsetX, 0)];
    }
    
    _lastLabel = selLabel;
}

#pragma mark - lazy
- (NSMutableArray *)labelArr {
    if (!_labelArr) {
        _labelArr = [NSMutableArray array];
    }
    return _labelArr;
}

@end
