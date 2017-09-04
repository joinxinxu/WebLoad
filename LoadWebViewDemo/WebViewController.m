//
//  WebViewController.m
//  LoadWebViewDemo
//
//  Created by wangxinxu on 2017/9/4.
//  Copyright © 2017年 wangxinxu. All rights reserved.
//

#import "WebViewController.h"
#import "WXWebLoadView.h"
#import "WXWKLoadView.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"web页面的加载";
    
    if (_num == 1001) {
        WXWebLoadView *loadVC = [[WXWebLoadView alloc] initWithFrame:self.view.bounds];
        loadVC.webUrl = @"https://www.baidu.com";
        [self.view addSubview:loadVC];
    } else {
        WXWKLoadView *loadVC = [[WXWKLoadView alloc] initWithFrame:self.view.bounds];
        loadVC.webUrl = @"https://www.baidu.com";
        [self.view addSubview:loadVC];
    }
}

@end
