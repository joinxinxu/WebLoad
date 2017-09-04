//
//  WebviewProgressLine.h
//  LoadWebViewDemo
//
//  Created by wangxinxu on 2017/9/4.
//  Copyright © 2017年 wangxinxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@interface WebviewProgressLine : UIView

//进度条颜色
@property (nonatomic,strong) UIColor  *lineColor;

//开始加载
-(void)startLoadingAnimation;

//结束加载
-(void)endLoadingAnimation;

@end
