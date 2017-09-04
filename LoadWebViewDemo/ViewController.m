//
//  ViewController.m
//  LoadWebViewDemo
//
//  Created by wangxinxu on 2017/9/4.
//  Copyright © 2017年 wangxinxu. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"web";
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
    but.frame = CGRectMake(100, 100, 200, 30);
    but.layer.cornerRadius = 15.0f;
    but.layer.borderColor = [UIColor redColor].CGColor;
    but.layer.borderWidth = 0.5;
    but.tag = 1001;
    [but setTitle:@"WebView的加载" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(butButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeSystem];
    but2.frame = CGRectMake(100, 150, 200, 30);
    but2.layer.cornerRadius = 15.0f;
    but2.layer.borderColor = [UIColor redColor].CGColor;
    but2.layer.borderWidth = 0.5;
    but2.tag = 1002;
    [but2 setTitle:@"WKWebView的加载" forState:UIControlStateNormal];
    [but2 addTarget:self action:@selector(butButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but2];
}

-(void)butButClick:(UIButton *)but
{
    WebViewController *webView = [[WebViewController alloc] init];
    webView.num = but.tag;
    [self.navigationController pushViewController:webView animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
