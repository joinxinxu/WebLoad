//
//  WXWebLoadView.m
//  WebLoadDemo
//
//  Created by wangxinxu on 2017/9/4.
//  Copyright © 2017年 wangxinxu. All rights reserved.
//

#import "WXWebLoadView.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation WXWebLoadView

-(void)setWebUrl:(NSString *)webUrl
{
    _webUrl = webUrl;
    self.webview = [[UIWebView alloc] initWithFrame:self.frame];
    self.webview.delegate = self;
    [self addSubview:self.webview];
    
    self.progressLine = [[WebviewProgressLine alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 3)];
    self.progressLine.lineColor = [UIColor redColor];
    [self addSubview:self.progressLine];
    
    
    NSURL *url = [NSURL URLWithString:_webUrl];
    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.progressLine startLoadingAnimation];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.progressLine endLoadingAnimation];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.progressLine endLoadingAnimation];
}
@end
