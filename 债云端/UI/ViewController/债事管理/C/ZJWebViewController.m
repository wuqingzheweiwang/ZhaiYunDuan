//
//  ZJWebViewController.m
//  债云端
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJWebViewController.h"
#import "ZJBranchOfficeViewController.h"
@interface ZJWebViewController ()<UIWebViewDelegate>

@end

@implementation ZJWebViewController
{
    UIWebView * _webview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight)];
    [self.view addSubview:_webview];
    _webview.delegate=self;
    //创建要打开的html文件的完整路径
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *resPath = [bundle resourcePath];
    NSString *filePath = [resPath stringByAppendingPathComponent:@"index.html"];
         //加载指定的html文件
    [_webview loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initFileURLWithPath:filePath]]];
}
- (void)webViewDidFinishLoad:(UIWebView*)webView
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [ZJNavigationPublic setTitleOnTargetNav:self title:title];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString * url = [NSString stringWithFormat:@"%@",request.URL];
    NSArray *array = [url componentsSeparatedByString:@"."];
    if (array.count>3) {
        ZJBranchOfficeViewController * BofficeVC=[[ZJBranchOfficeViewController alloc]initWithNibName:@"ZJBranchOfficeViewController" bundle:nil];
        BofficeVC.typeTitle=[NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
        [self.navigationController pushViewController:BofficeVC animated:YES];
    }
    return YES;

    
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
