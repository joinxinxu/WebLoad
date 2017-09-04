//
//  WXWebLoadView.h
//  WebLoadDemo
//
//  Created by wangxinxu on 2017/9/4.
//  Copyright © 2017年 wangxinxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebviewProgressLine.h"

@interface WXWebLoadView : UIView<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView            *webview;
@property (nonatomic, strong) NSString            *webUrl;
@property (nonatomic,strong) WebviewProgressLine  *progressLine;




@end
