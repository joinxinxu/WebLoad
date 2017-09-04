//
//  UIView+Extension.m
//  CheckRoom
//
//  Created by wangxinxu on 16/3/28.
//  Copyright © 2016年 wangxinxu. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

-(void)setX:(CGFloat)x {
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(CGFloat)x {
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y {
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
    
}

-(CGFloat)y {
    return self.frame.origin.y;
    
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}


-(void)setWidth:(CGFloat)width {
    
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    
}

-(CGFloat)width {
    
    return self.frame.size.width;
    
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}


- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)originX
{
    return self.frame.origin.x;
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (CGFloat)endX
{
    return self.originX + self.width;
}

- (CGFloat)endY
{
    return self.originY + self.height;
}

- (CGPoint)centerOfCurrentView
{
    return CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
}

- (CGFloat)centerXOfCurrentView
{
    return self.bounds.size.width/2;
}

- (CGFloat)centerYOfCurrentView
{
    return self.bounds.size.height/2;
}

- (void)setOriginX:(CGFloat)originX
{
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
}

- (void)setOriginY:(CGFloat)originY
{
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
}

- (void)setCenterOfCurrentView:(CGPoint)centerOfCurrentView
{
    // readonly
}

- (void)setEndX:(CGFloat)endX
{
    CGRect frame = self.frame;
    frame.origin.x = endX - self.width;
    self.frame = frame;
}

- (void)setEndY:(CGFloat)endY
{
    CGRect frame = self.frame;
    frame.origin.y = endY - self.height;
    self.frame = frame;
}

- (void)cornerRadius:(CGFloat)cornerRadius
         borderColor:(CGColorRef)borderColor
         borderWidth:(CGFloat)borderWidth
{
    self.clipsToBounds      = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor  = borderColor;
    self.layer.borderWidth  = borderWidth;
}

@end
