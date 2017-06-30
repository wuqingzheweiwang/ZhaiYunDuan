//
//  ZJBaseViewController.m
//  债云端
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBaseViewController.h"
#import "ZJTabbarViewController.h"
#define  HUD_TAG  9999

@interface ZJBaseViewController ()

@end

@implementation ZJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     [ZJNavigationPublic setBackButtonOnTargetNav:self action:@selector(backToPrevious)];

}

// 返回键
- (void)backToPrevious
{
    if (self.isPushPresent) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else [self.navigationController popViewControllerAnimated:YES];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 菊花
- (void)showProgress
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)dismissProgress
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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
