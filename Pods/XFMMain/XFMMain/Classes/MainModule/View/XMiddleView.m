//
//  XMiddleView.m
//  XFM
//
//  Created by 张鑫 on 2017/4/15.
//  Copyright © 2017年 张鑫. All rights reserved.
//

#import "XMiddleView.h"
#import "CALayer+XAnimate.h"

@interface XMiddleView ()

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation XMiddleView

static XMiddleView *_shareInstance;
+ (instancetype)shareInstance {
    if (_shareInstance == nil) {
        _shareInstance = [XMiddleView middleView];
    }
    return _shareInstance;
}

+ (instancetype)middleView {
    XMiddleView *middleView = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"XMiddleView" owner:nil options:nil] firstObject];
    return middleView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconView.layer.cornerRadius = self.iconView.frame.size.width * 0.5;
    self.iconView.layer.masksToBounds = YES;
    
    [self.iconView.layer removeAnimationForKey:@"playAnimation"];
    CABasicAnimation *basicAnama = [[CABasicAnimation alloc] init];
    basicAnama.keyPath = @"transform.rotation.z";
    basicAnama.fromValue = @0;
    basicAnama.toValue = @(M_PI * 2);
    basicAnama.duration = 30;
    basicAnama.repeatCount = MAXFLOAT;
    basicAnama.removedOnCompletion = NO;
    [self.iconView.layer addAnimation:basicAnama forKey:@"playAnimation"];
    
    [self.iconView.layer pauseAnimate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isPlayerPlay:) name:@"playState" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setPlayImage:) name:@"playImage" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)isPlayerPlay:(NSNotification *)notification {
    BOOL isPlay = [notification.object boolValue];
    self.isPlaying = isPlay;
}

- (void)setPlayImage:(NSNotification *)notification {
    UIImage *image = notification.object;
    self.middleImage = image;
}

- (IBAction)playBtnClick:(UIButton *)sender {
    if (self.middleClickBlock) {
        self.middleClickBlock(self.isPlaying);
    }
}

#pragma mark - setter
- (void)setIsPlaying:(BOOL)isPlaying {
    if (isPlaying == _isPlaying) {
        return;
    }
    _isPlaying = isPlaying;
    if (isPlaying) {
        [self.playBtn setImage:nil forState:UIControlStateNormal];
        [self.iconView.layer resumeAnimate];
    } else {
        NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
        NSString *bunleName = [currentBundle.infoDictionary[@"CFBundleName"] stringByAppendingString:@".bundle"];
        NSString *path = [currentBundle pathForResource:@"tabbar_np_play@2x.png" ofType:nil inDirectory:bunleName];
        NSString *path1 = [currentBundle pathForResource:@"tabbar_np_play@3x.png" ofType:nil inDirectory:bunleName];
        [self.playBtn setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        [self.playBtn setImage:[UIImage imageWithContentsOfFile:path1] forState:UIControlStateNormal];
        [self.iconView.layer pauseAnimate];
    }
}

- (void)setMiddleImage:(UIImage *)middleImage {
    _middleImage = middleImage;
    self.iconView.image = middleImage;
}

@end
