//
//  WebviewProgressLine.m
//  LoadWebViewDemo
//
//  Created by wangxinxu on 2017/9/4.
//  Copyright © 2017年 wangxinxu. All rights reserved.
//

#import "WebviewProgressLine.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation WebviewProgressLine

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    self.backgroundColor = lineColor;
}

-(void)startLoadingAnimation{
    self.hidden = NO;
    self.width = 0.0;
    
    __weak UIView *weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.width = ScreenWidth * 0.6;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.width = ScreenWidth * 0.8;
        }];
    }];
    
    
}

-(void)endLoadingAnimation{
    __weak UIView *weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.width = ScreenWidth;
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
    }];
}

@end
