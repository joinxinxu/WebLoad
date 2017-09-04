简介

如果项目支持iOS7之前的系统版本的话，可以做个系统判断，这里就不介绍了，这里还是推荐使用WKWebView，先介绍下使用这个的好处，然后介绍使用UIWebView和WKWebView加载进度条的代码。

开发App的过程中，常常会遇到在App内部加载网页，通常用UIWebView加载。这个自iOS2开始使用的网页加载器一直是开发的心病：加载速度慢，占用内存多，优化困难。如果加载网页多，还可能因为过量占用内存而给系统kill掉。各种优化的方法效果也不那么明显。


iOS8以后，苹果推出了新框架Wekkit，提供了替换UIWebView的组件WKWebView。各种UIWebView的问题没有了，速度更快了，占用内存少了，一句话，WKWebView是App内部加载网页的最佳选择！
先看下 WKWebView的特性：
在性能、稳定性、功能方面有很大提升（最直观的体现就是加载网页是占用的内存，模拟器加载百度与开源中国网站时，WKWebView占用23M，而UIWebView占用85M）；
允许JavaScript的Nitro库加载并使用（UIWebView中限制）；
支持了更多的HTML5特性；
高达60fps的滚动刷新率以及内置手势；
将UIWebViewDelegate与UIWebView重构成了14类与3个协议（查看苹果官方文档）；

![image](https://github.com/joinxinxu/WebLoad/blob/master/baidupic.gif)

一、首先介绍UIWebview进度条的使用方法

不同于WKWebview，wk是有自己的加载进度值的，我们可以直接通过kvo检测到，并显示到进度条内。

 

但如果我们为了适配ios7，只能使用UIWebview了，这里的加载进度，就比较尴尬了

 

所以我们的实现方式就是：模拟进度-俗称假进度。



实现原理：

自定义一个UIView的进度条，添加到Nav下方，给予两个方法：

1、startLoadingAnimation  开始加载

2、endLoadingAnimation  结束加载

 

开始加载，先动画模拟一个0.4s的加载，加载宽度为0.6倍屏幕宽度，动画结束，再0.4s实现，总共0.8倍的屏幕宽度。

结束动画，动画模拟1.0倍数的屏幕宽度，实现全部加载完成，并最后隐藏掉进度条。

 

代码：

.h文件

复制代码
#import <UIKit/UIKit.h>

@interface WebviewProgressLine : UIView

//进度条颜色
@property (nonatomic,strong) UIColor  *lineColor;

//开始加载
-(void)startLoadingAnimation;

//结束加载
-(void)endLoadingAnimation;

@end
复制代码
 

.m文件

复制代码
#import "WebviewProgressLine.h"

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
        weakSelf.width = KScreenWidth * 0.6;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.width = KScreenWidth * 0.8;
        }];
    }];
    
    
}

-(void)endLoadingAnimation{
    __weak UIView *weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.width = KScreenWidth;
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
    }];
}

@end
复制代码
 

webview页面使用：

复制代码
#import "webviewViewController.h"
#import "WebviewProgressLine.h"

@interface webviewViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView  *webview;
@property (nonatomic,strong) WebviewProgressLine  *progressLine;

@end

@implementation webviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webview = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webview.delegate = self;
    [self.view addSubview:self.webview];
    
    self.progressLine = [[WebviewProgressLine alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, 3)];
    self.progressLine.lineColor = [UIColor redColor];
    [self.view addSubview:self.progressLine];
    
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
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
复制代码


二、介绍WKWebview进度条使用方法

iOS8之后就可以使用WKWebview了


1.添加UIProgressView属性

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIProgressView *progressView;
2.初始化progressView

- (void)viewDidLoad {
    [super viewDidLoad];    
    //进度条初始化
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, 2)];
    self.progressView.backgroundColor = [UIColor blueColor];
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view addSubview:self.progressView];
}
3.添加KVO，WKWebView有一个属性estimatedProgress，就是当前网页加载的进度，所以监听这个属性。

[self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
4.在监听方法中获取网页加载的进度，并将进度赋给progressView.progress

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkWebView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;

            }];
        }    
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
5.在WKWebViewd的代理中展示进度条，加载完成后隐藏进度条

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
    //加载完成后隐藏progressView
    //self.progressView.hidden = YES;
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    //加载失败同样需要隐藏progressView
    //self.progressView.hidden = YES;
}
6.在dealloc中取消监听

- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}
三、总结

一般h5页面有联系我们然后点击拨打电话的功能，在使用的时候发现了UIWebView加载的H5，可以调用；但是WKWebView就是不行，解决WKWebView加载H5页面，无法调用拨打电话功能的问题

H5的拨打电话代码是

<a href="tel:13112345678">移动WEB页面JS一键拨打号码咨询功能</a>
解决的方法：在WKWebView的WKNavigationDelegate代理方法处理

解决代码如下：

// 处理拨打电话以及Url跳转等等
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URLscheme];
    if ([schemeisEqualToString:@"tel"]) {
        NSString *resourceSpecifier = [URLresourceSpecifier];
        NSString *callPhone = [NSStringstringWithFormat:@"telprompt://%@", resourceSpecifier];
        /// 防止iOS 10及其之后，拨打电话系统弹出框延迟出现
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            [[UIApplicationsharedApplication] openURL:[NSURLURLWithString:callPhone]];
        });
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
