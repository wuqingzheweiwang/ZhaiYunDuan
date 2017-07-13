//
//  ZJNewsDetailsViewController.m
//  债云端
//
//  Created by apple on 2017/5/15.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJNewsDetailsViewController.h"
#import "LMWebProgressLayer.h"
@interface ZJNewsDetailsViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIActivityIndicatorView* activityIndicator;

@end

@implementation ZJNewsDetailsViewController
{
    UIWebView * newsWebview;
    LMWebProgressLayer *_progressLayer; ///< 网页加载进度条
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [ZJNavigationPublic setTitleOnTargetNav:self title:self.newstitle];
    newsWebview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight)];
    newsWebview.scalesPageToFit = YES;
    newsWebview.backgroundColor = [UIColor whiteColor];
    newsWebview.delegate=self;
    [self.view addSubview:newsWebview];
    
    [newsWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.newsurl]]];
    _progressLayer = [LMWebProgressLayer new];
    _progressLayer.frame = CGRectMake(0, 42, SCREEN_WIDTH, 2);
    
    [self.navigationController.navigationBar.layer addSublayer:_progressLayer];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((ZJAPPWidth - 30) / 2, (ZJAPPHeight - 64 - 30)/2, 50, 30)];
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.activityIndicator];

}
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [_progressLayer startLoad];
}
//  防止内存泄露（Html当中的js代码会引起内存泄露）
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_progressLayer finishedLoad];
    [self.activityIndicator stopAnimating];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_progressLayer finishedLoad];
}

- (void)dealloc {
    
    [_progressLayer closeTimer];
    [_progressLayer removeFromSuperlayer];
    _progressLayer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
