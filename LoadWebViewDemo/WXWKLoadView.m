//
//  WXWKLoadView.m
//  WebLoadDemo
//
//  Created by wangxinxu on 2017/9/4.
//  Copyright © 2017年 wangxinxu. All rights reserved.
//

#import "WXWKLoadView.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation WXWKLoadView

- (WKWebView *)webView{
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
        [_webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [_webView setNavigationDelegate:self];
        [_webView setUIDelegate:self];
        [_webView setMultipleTouchEnabled:YES];
        [_webView setAutoresizesSubviews:YES];
        [_webView.scrollView setAlwaysBounceVertical:YES];
        [_webView setAllowsBackForwardNavigationGestures:true];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webUrl]]];
        [self addSubview:_webView];
    }
    return _webView;
}

- (UIProgressView *)progressView
{
    if (!_progressView) {
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 3)];
        self.progressView.backgroundColor = [UIColor blueColor];
        self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
        
        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _progressView;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *viewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
        viewBg.backgroundColor = [UIColor whiteColor];
        [self addSubview:viewBg];
    }
    return self;
}

-(void)setWebUrl:(NSString *)webUrl
{
    _webUrl = webUrl;
    [self addSubview:self.progressView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = _webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
            }];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.progressView.hidden = NO;
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self bringSubviewToFront:self.progressView];
}

// 处理拨打电话以及Url跳转等等
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme isEqualToString:@"tel"]) {
        NSString *resourceSpecifier = [URL resourceSpecifier];
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", resourceSpecifier];
        /// 防止iOS 10及其之后，拨打电话系统弹出框延迟出现
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        });
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
