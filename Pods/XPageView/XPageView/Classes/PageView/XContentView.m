//
//  XContentView.m
//  Demo_Refresh
//
//  Created by sajiner on 2017/3/30.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "XContentView.h"
#import "XFlowLayout.h"
#import "XTitleView.h"

@interface XContentView ()<UICollectionViewDelegate, UICollectionViewDataSource, XTitleViewDelegate> {
    NSArray *_childVcs;
//    UIViewController *_parentVc;
    CGFloat _startOffsetX; // 开始拖拽的位置
    BOOL _isForbidScroll;
}
@property (nonatomic, strong) UICollectionView *contentView;

@end

@implementation XContentView

- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray *)childVcs {
    self = [super initWithFrame:frame];
    if (self) {
        _childVcs = childVcs;
//        _parentVc = parentVc;
        [self initElement];
    }
    return self;
}

- (void)initElement {
    _contentView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[[XFlowLayout alloc] init]];
    [_contentView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"kCell"];
    _contentView.dataSource = self;
    _contentView.delegate = self;
    
    [self addSubview:_contentView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _childVcs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kCell" forIndexPath:indexPath];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UIViewController *vc = _childVcs[indexPath.item];
    vc.view.frame = cell.bounds;
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isForbidScroll = NO;
    _startOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self contentEndScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self contentEndScroll];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_startOffsetX == scrollView.contentOffset.x || _isForbidScroll) {
        return;
    }
    CGFloat progress = 0;
    int targetIndex = 0;
    int currentIndex = (int)(_startOffsetX / scrollView.bounds.size.width);
    if (_startOffsetX > scrollView.contentOffset.x) {  // 右滑
        targetIndex = (currentIndex - 1 > 0) ? currentIndex - 1 : 0;
        progress = (CGFloat)(_startOffsetX - scrollView.contentOffset.x) / scrollView.bounds.size.width;
    } else {   // 左滑
        targetIndex = (currentIndex + 1 <= (int)_childVcs.count - 1) ? (currentIndex + 1) : ((int)_childVcs.count - 1);
        progress = (CGFloat)(scrollView.contentOffset.x - _startOffsetX) / scrollView.bounds.size.width;
    }
    if ([self.delegate respondsToSelector:@selector(contentView:targetIndex: progress:)]) {
        [self.delegate contentView:self targetIndex:targetIndex progress:progress];
    }
}

#pragma mark - XTitleViewDelegate
- (void)titleView:(XTitleView *)titleView didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex {
    _isForbidScroll = YES;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:toIndex inSection:0];
    [self.contentView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

#pragma mark - private
- (void)contentEndScroll {
    if (_isForbidScroll) {
        return;
    }
    int currentIndex = _contentView.contentOffset.x / _contentView.frame.size.width;
    if ([self.delegate respondsToSelector:@selector(contentView:targetIndex:)]) {
        [self.delegate contentView:self targetIndex:currentIndex];
    }
    _startOffsetX = _contentView.contentOffset.x;
}


@end
