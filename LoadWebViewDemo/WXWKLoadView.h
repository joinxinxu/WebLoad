//
//  WXWKLoadView.h
//  WebLoadDemo
//
//  Created by wangxinxu on 2017/9/4.
//  Copyright © 2017年 wangxinxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WXWKLoadView : UIView<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) NSString       *webUrl;
@property (nonatomic, strong) WKWebView      *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end
