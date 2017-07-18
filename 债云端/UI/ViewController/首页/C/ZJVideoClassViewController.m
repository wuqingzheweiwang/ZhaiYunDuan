//
//  ZJVideoClassViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/7/18.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJVideoClassViewController.h"

@interface ZJVideoClassViewController ()

@end

@implementation ZJVideoClassViewController
{
    __weak IBOutlet UIView *HeaderView;
    NSMutableArray * _dataSource; 
    NSInteger _page;
    UIScrollView * headerScrollview;
    NSString * BtnType;   //直接赋值上面的按钮文字，根据他去判断显示什么布局

}
- (void)viewDidLoad {
    [super viewDidLoad];

    BtnType=@"名师讲堂";
    _page = 1;
    [self creatUI];

}

-(void)creatUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"视频课程"];
    HeaderView.top=64;
    HeaderView.left=0;
    HeaderView.width=ZJAPPWidth;
    HeaderView.height=44;
    headerScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, 44)];
    headerScrollview.userInteractionEnabled=YES;
    headerScrollview.showsVerticalScrollIndicator=NO;
    headerScrollview.showsHorizontalScrollIndicator=NO;
    [HeaderView addSubview:headerScrollview];
    NSMutableArray * infoarray=[NSMutableArray arrayWithObjects:@"名师讲堂",@"解债案例",@"答疑解惑",@"法律咨询",@"名师风采", nil];
    for (int i=0; i<infoarray.count; i++) {
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(i*(ZJAPPWidth/5), 0, ZJAPPWidth/5, 44);
        [button setTitle:[NSString stringWithFormat:@"%@",[infoarray objectAtIndex:i]] forState:UIControlStateNormal];
        if (i==0) {
            [button setTitleColor:ZJColor_red forState:UIControlStateNormal];
        }else [button setTitleColor:ZJColor_333333 forState:UIControlStateNormal];
        button.tag=1000+i;
        [button.titleLabel setFont:ZJ_FONT(12)];
        [headerScrollview addSubview:button];
        [button addTarget:self action:@selector(infoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        UIView * lineview=[[UIView alloc]initWithFrame:CGRectMake(10+i*(ZJAPPWidth/5), 43, ZJAPPWidth/5-20, 1)];
        lineview.backgroundColor=ZJColor_red;
        lineview.tag=2000+i;
        [headerScrollview addSubview:lineview];
        if (i==0) {
            lineview.hidden=NO;
        }else lineview.hidden=YES;
        [headerScrollview setContentSize:CGSizeMake(button.right, 0)];
    }

    

}

//button的点击事件
-(void)infoBtnAction:(UIButton *)sender
{
    //遍历查找btn
    BtnType=sender.titleLabel.text;
    [sender setTitleColor:ZJColor_red forState:UIControlStateNormal];
    for (UIButton *subView in headerScrollview.subviews) {
        if ([subView isKindOfClass:[UIButton class]] && subView.tag != sender.tag) {
            [subView setTitleColor:ZJColor_333333 forState:UIControlStateNormal];
        }
    }
    //便利查找红线
    for (UIView *subView in headerScrollview.subviews) {
        if (![subView isKindOfClass:[UIButton class]] && subView.tag == sender.tag+1000) {
            subView.hidden=NO;
        }
        if (![subView isKindOfClass:[UIButton class]] && subView.tag != sender.tag+1000) {
            subView.hidden=YES;
        }
    }
    if ([BtnType isEqualToString:@"名师讲堂"]) {
        _page=1;
//        [Infotabel reloadData];
    }else if ([BtnType isEqualToString:@"解债案例"]){
        _page=1;
        [self requestVideoRequestData];
    }else if ([BtnType isEqualToString:@"答疑解惑"]){
        _page=1;
        [self requestVideoRequestData];
    }else if ([BtnType isEqualToString:@"法律咨询"]){
        _page=1;
        [self requestVideoRequestData];
    }else if ([BtnType isEqualToString:@"名师风采"]){

        _page=1;
        [self requestVideoRequestData];
    }
//    [Infotabel reloadData];
}


#pragma mark--请求债事信息
- (void)requestVideoRequestData
{
//    NSString * action=[NSString stringWithFormat:@"api/debtrelation/debtinfo?debtId=%@&ps=8&pn=%ld",self.companyId,(long)_page];
//    [self showProgress];
//    [ZJDebtPersonRequest GetDebtPersondebtInfomationRequestWithActions:action result:^(BOOL success, id responseData) {
//        DLog(@"%@",responseData);
//        [self dismissProgress];
//        if (success) {
//            
//            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
//                if (_page==1) {
//                    [_dataSource removeAllObjects];
//                }
//                NSArray * dicArray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
//                for (int i=0; i<dicArray.count; i++) {
////                    ZJDebtMangerHomeItem * item=[ZJDebtMangerHomeItem itemForDictionary:[dicArray objectAtIndex:i]];
//                    [_dataSource addObject:item];
//                }
//                [Infotabel reloadData];
//            }else{
//                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
//            }
//        }else{
//            [ZJUtil showBottomToastWithMsg:@"网络请求错误"];
//        }
//        [Infotabel.mj_header endRefreshing];
//        [Infotabel.mj_footer endRefreshing];
        
//    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
