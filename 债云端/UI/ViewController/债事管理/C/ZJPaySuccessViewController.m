//
//  ZJPaySuccessViewController.m
//  债云端
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJPaySuccessViewController.h"

@interface ZJPaySuccessViewController ()

@end

@implementation ZJPaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

        
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"支付"];
    [ZJNavigationPublic setRightButtonOnTargetNav:self action:@selector(backHomePage) image:[UIImage imageNamed:@"return-home"] HighImage:[UIImage imageNamed:@"return-home"]];
    [self resetUI];
}
- (void)resetUI
{
    UIView * backview=[[UIView alloc]initWithFrame:CGRectMake(0, (ZJAPPHeight-64-TRUE_1(105))/2, ZJAPPWidth, TRUE_1(105))];
    [self.view addSubview:backview];
    UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake((ZJAPPWidth-TRUE_1(70))/2, 0, TRUE_1(70), TRUE_1(70))];
    imageview.image=[UIImage imageNamed:@"paySuccess"];
    [backview addSubview:imageview];
    UILabel * textlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, TRUE_1(90), ZJAPPWidth, TRUE_1(15))];
    textlabel.text=@"支付成功";
    textlabel.textAlignment=NSTextAlignmentCenter;
    textlabel.textColor=ZJColor_333333;
    textlabel.font=ZJ_TRUE_FONT(15);
    [backview addSubview:textlabel];
}
// 返回首页
-(void)backHomePage
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
