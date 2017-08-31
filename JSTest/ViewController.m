//
//  ViewController.m
//  JSTest
//
//  Created by 安宁 on 2017/8/31.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import "ViewController.h"
#import "JSObjcDelegate.h"



@interface ViewController ()<UIWebViewDelegate , JSObjcDelegate>
{
    UIWebView * _wv ;
    
}

@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self createHTML];

}

-(void)createHTML
{
    
    _wv = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 300, 400)];
    _wv.backgroundColor  =[UIColor redColor];
    _wv.delegate = self ;
    
    
    [self.view addSubview:_wv];
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"File" withExtension:@"html"];
    
    
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20] ;
    
    
    [_wv loadRequest:request];
    
    [_wv reload];
    
}


#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    //    if (!self.jsContext)
    //    {
    self.jsContext = [_wv valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"Toyun"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
    //    }
    
    //
    //    _jsContextTemp = [JSContext currentContext];
    
    
    
    return YES ;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSLog(@" ================ %d",[webView canGoBack]);
    
    [_wv stringByEvaluatingJavaScriptFromString:@"picCallback('1111xt')"];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}


#pragma mark - JSObjcDelegate

- (void)callCamera {
    NSLog(@"callCamera");
    // 获取到照片之后在回调js的方法picCallback把图片传出去
    JSValue *picCallback = self.jsContext[@"picCallback"];
    [picCallback callWithArguments:@[@"photos"]];
}

- (void)share:(NSString *)shareString {
    NSLog(@"share:%@", shareString);
    // 分享成功回调js的方法shareCallback
    JSValue *shareCallback = self.jsContext[@"shareCallback"];
    [shareCallback callWithArguments:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self createHTML];

}


@end
