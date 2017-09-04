//
//  UIView+Extension.h
//  CheckRoom
//
//  Created by wangxinxu on 16/3/28.
//  Copyright © 2016年 wangxinxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property(nonatomic,assign)CGFloat x;

@property(nonatomic,assign)CGFloat y;

@property(nonatomic,assign)CGFloat centerX;

@property(nonatomic,assign)CGFloat centerY;

@property(nonatomic,assign)CGFloat width;

@property(nonatomic,assign)CGFloat height;

@property(nonatomic,assign)CGSize size;

@property(nonatomic,assign)CGPoint origin;

@property (nonatomic, assign) CGFloat originX;

@property (nonatomic, assign) CGFloat originY;

@property (nonatomic, assign) CGFloat endX;

@property (nonatomic, assign) CGFloat endY;

@property (nonatomic, assign, readonly) CGPoint centerOfCurrentView;

@property (nonatomic, assign) CGFloat centerXOfCurrentView;

@property (nonatomic, assign) CGFloat centerYOfCurrentView;

// 设置圆角
- (void)cornerRadius:(CGFloat)cornerRadius
         borderColor:(CGColorRef)borderColor
         borderWidth:(CGFloat)borderWidth;

@end
