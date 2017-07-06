//
//  ZJMyPageViewController.m
//  债云端
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJMyPageViewController.h"
#import "ZJLoginViewController.h"
#import "ZJMyMemberTableViewCell.h"
#import "ZJMyZhangDanViewController.h"
#import "ZJMyBillViewController.h"
#import "ZJDebtMangerViewController.h"
#import "ZJDebtPersonViewController.h"
#import "ZJOwnerDataController.h"
#import "ZJMyMemberViewController.h"
#import "ZJRecommendBankVC.h"
#import "ZJShareAlertView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
static id _publishContent;

@interface ZJMyPageViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UITextViewDelegate,UIScrollViewDelegate,ZJShareAlterViewDelegate>
{
    UIAlertController *alertcon;
    // 意见反馈
    UIView *smallProtrolView;
    // 输入区
    UITextView * writeTextView;
    
    ZJMyMemberTableViewCell *zjMyMembercell;
    
    ZJShareAlertView *zjShareView;
    
    NSMutableArray *_shareTypeArr;
}

@property (nonatomic , strong) NSMutableArray *tableViewdataSource;
@property (nonatomic , strong) UITableView *tableView;
// 头视图
@property (weak, nonatomic) IBOutlet UIView *tableHeaderView;
@property (weak, nonatomic) IBOutlet UIImageView *headerBackGroundImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *quitBut;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *personalData;

@property (weak, nonatomic) IBOutlet UIButton *pushIcon;

@property (weak, nonatomic) IBOutlet UILabel *recommandCode;

@property (nonatomic ,strong) NSString *phoneNmber;

@property (nonatomic ,strong) NSURL *imageUrl;
// 我的推荐个数
@property (nonatomic ,strong) NSString *recommand_1;
@property (nonatomic ,strong) NSString *recommand_2;
@property (nonatomic ,strong) NSString *recommand_3;
@property (nonatomic ,strong) NSString *recommand_4;

@end

@implementation ZJMyPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self setMineUI];
    [self resesmallProtrolView];

    NSLog(@"%@",[ZJUserInfo getUserIDForUserToken]);

}

-(void)viewWillAppear:(BOOL)animated
{
   
    self.navigationController.navigationBarHidden = YES;
    // 判断登录状态
    if ([ZJUtil getUserLogin]) {
         [self getMyPageData];
        [_quitBut setTitle:@"退出" forState:UIControlStateNormal];
        
        _userName.hidden = NO;
        _codeLabel.hidden = NO;
        _vipImageView.hidden = NO;
        _isVIPImageView.hidden = NO;
        _isVIPLabel.hidden = NO;
        _QRcodeView.hidden = YES;
        
        if ([ZJUtil getUserIsDebtBank]) {
            _vipImageView.image = [UIImage imageNamed:@"viplogo"];
            _isVIPImageView.image = [UIImage imageNamed:@"yellow"];
            [_isVIPLabel setTextColor:ZJColor_red];
        }else{
            
            _vipImageView.image = [UIImage imageNamed:@"user"];
            _isVIPImageView.image = [UIImage imageNamed:@"grey"];
            [_isVIPLabel setTextColor:ZJColor_666666];

        }
        
        // 推荐备案数
        [zjMyMembercell.recommandLabel_1 setText:[NSString stringWithFormat:@"%@个",self.recommand_1]];
        [zjMyMembercell.recommandRecoardBut addTarget:self action:@selector(touchRecoardBut) forControlEvents:UIControlEventTouchUpInside];
        // 推荐行长
        [zjMyMembercell.recommandLabel_2 setText:[NSString stringWithFormat:@"%@个",self.recommand_2]];
        
        [zjMyMembercell.recommandBankBut addTarget:self action:@selector(touchBankBut) forControlEvents:UIControlEventTouchUpInside];
        // 解债数
        [zjMyMembercell.recommandLabel_3 setText:[NSString stringWithFormat:@"%@个",self.recommand_3]];
        
        [zjMyMembercell.dismissDebtBut addTarget:self action:@selector(touchdismissDebtBut) forControlEvents:UIControlEventTouchUpInside];
        
        // 推荐行长数
        [zjMyMembercell.recommandLabel_4 setText:[NSString stringWithFormat:@"%@个",self.recommand_4]];
        
        [zjMyMembercell.recomMemberBut addTarget:self action:@selector(touchMyMemberBut) forControlEvents:UIControlEventTouchUpInside];
        
        //未登录
    }else{
        
        [_quitBut setTitle:@"登录" forState:UIControlStateNormal];
        
        _userName.hidden = YES;
        _codeLabel.hidden = YES;
        _headerImage.image=[UIImage imageNamed:@"head-portrait"];
        _vipImageView.hidden = YES;
        _isVIPImageView.hidden = YES;
        _isVIPLabel.hidden = YES;
        _QRcodeView.hidden = YES;
        
        [zjMyMembercell.recommandLabel_1 setText:[NSString stringWithFormat:@"%d个",0]];
        zjMyMembercell.recommandLabel_1.enabled = YES;
        [zjMyMembercell.recommandLabel_2 setText:[NSString stringWithFormat:@"%d个",0]];
        zjMyMembercell.recommandLabel_2.enabled = YES;
        [zjMyMembercell.recommandLabel_3 setText:[NSString stringWithFormat:@"%d个",0]];
        zjMyMembercell.recommandLabel_3.enabled = YES;
        // 推荐行长数
        [zjMyMembercell.recommandLabel_4 setText:[NSString stringWithFormat:@"%d个",0]];
        zjMyMembercell.recommandLabel_4.enabled = YES;

        [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"请登录"]];

    }

}
-(void)setMineUI
{
    self.recommand_1=@"0";
    self.recommand_2=self.recommand_1;
    self.recommand_3=self.recommand_2;
    self.recommand_4=self.recommand_3;

    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    //
    _tableHeaderView.top = 0;
    _tableHeaderView.left = 0;
    _tableHeaderView.width = ZJAPPWidth;
    _tableHeaderView.height = TRUE_1(328/2);
    // 背景图
    _headerBackGroundImage.top =_tableHeaderView.top;
    _headerBackGroundImage.left =_tableHeaderView.left;
    _headerBackGroundImage.width =_tableHeaderView.width;
    _headerBackGroundImage.height =_tableHeaderView.height;
    // 标题
    _titleLabel.top = 20;
    _titleLabel.left = ZJAPPWidth/2 - 100;
    _titleLabel.height = 44;
    _titleLabel.width = 200;
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    _titleLabel.font = [UIFont fontWithName:@".PingFangSC-Semibold" size:17];
    //登录/退出
    _quitBut.top = 20;
    _quitBut.left = ZJAPPWidth-10-_quitBut.width;
    _quitBut.width = 48;
    _quitBut.height = 44;
    _quitBut.titleLabel.font = ZJ_FONT(14);
    [_quitBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _quitBut.tag = 0;
    [_quitBut addTarget:self action:@selector(alertShow:) forControlEvents:UIControlEventTouchUpInside];
    //头像
    _headerImage.top = TRUE_1(150/2);
    _headerImage.left = TRUE_1(44/2);
    _headerImage.width = TRUE_1(140/2);
    _headerImage.height = _headerImage.width;
    _headerImage.clipsToBounds=YES;
    _headerImage.contentMode=UIViewContentModeScaleAspectFill;
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = TRUE_1(70/2);
  
    //    添加手势
    [self setheaderImageGesture];
    
    // 用户名Label
    _userNameLabel.top = _headerImage.top;
    _userNameLabel.left = _headerImage.right+TRUE_1(10);
    _userNameLabel.width = TRUE_1(94/2);
    _userNameLabel.height = TRUE_1(30/2);
    _userNameLabel.font=ZJ_TRUE_FONT(15);
    // 用户名
    _userName.top = _userNameLabel.top;
    _userName.left = _userNameLabel.right+TRUE_1(5);
    _userName.width =  TRUE_1(200/2);
    _userName.height = _userNameLabel.height;
    _userName.font= ZJ_TRUE_FONT(12);

    // vip  vip图片的hideen与是否是行长有关
    _vipImageView.centerY = _headerImage.centerY;
    _vipImageView.left = _userNameLabel.left;
    _vipImageView.width = TRUE_1(40/2);
    _vipImageView.height = TRUE_1(40/2);
    
    // vipImageView
    _isVIPImageView.top = _vipImageView.top + TRUE_1(5);
    _isVIPImageView.left = _vipImageView.right;
    _isVIPImageView.width = TRUE_1(70);
    _isVIPImageView.height = _vipImageView.height - TRUE_1(5);
    
    // vipLabel
    _isVIPLabel.top = _isVIPImageView.top;
    _isVIPLabel.left = _isVIPImageView.left+TRUE_1(5);
    _isVIPLabel.width = _isVIPImageView.width - TRUE_1(5)*2;
    _isVIPLabel.height = _isVIPImageView.height;
    [_isVIPLabel setFont:ZJ_TRUE_FONT_1(10)];
    
    //推荐编码Label
    _recommandCode.top = _vipImageView.bottom+TRUE_1(10);
    _recommandCode.left = _vipImageView.left;
    _recommandCode.width = TRUE_1(100);
    _recommandCode.height = TRUE_1(20);
    _recommandCode.font = ZJ_TRUE_FONT(12);
    // 推荐编码
    _codeLabel.top = _recommandCode.top;
    _codeLabel.left = _userName.left;
    _codeLabel.width = TRUE_1(200);
    _codeLabel.height = _vipImageView.height;
    // >
    _pushIcon.height = TRUE_1(25/2);
    _pushIcon.top = _vipImageView.top+TRUE_1(5);
    _pushIcon.width = TRUE_1(13/2);
    _pushIcon.left = ZJAPPWidth - TRUE_1(45/2)-_pushIcon.width;
    [_pushIcon addTarget:self action:@selector(gotoOwnerDataVC) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 二维码图片
    _QRcodeView.top = _recommandCode.top;
    _QRcodeView.centerX = _pushIcon.centerX;
    _QRcodeView.height = TRUE_1(15);
    _QRcodeView.width = _QRcodeView.height;
    
    // 二维码按钮
    _onQRcodeBut.top = _pushIcon.bottom;
    _onQRcodeBut.centerX = _pushIcon.centerX;
    _onQRcodeBut.width = TRUE_1(50);
    _onQRcodeBut.height = _onQRcodeBut.width;
    [_onQRcodeBut addTarget:self action:@selector(showMyQRtoShare) forControlEvents:UIControlEventTouchUpInside];
    
    // 个人资料
    _personalData.top =_pushIcon.top ;
    _personalData.width = TRUE_1(120/2);
    _personalData.height = TRUE_1(25/2);
    _personalData.left =ZJAPPWidth - TRUE_1(45/2)-_pushIcon.width-_personalData.width-TRUE_1(10);
    _personalData.titleLabel.textAlignment=NSTextAlignmentRight;
    _personalData.titleLabel.font=ZJ_TRUE_FONT(12);
    [_personalData addTarget:self action:@selector(gotoOwnerDataVC) forControlEvents:UIControlEventTouchUpInside];
}

// 弹出分享视图
-(void)showMyQRtoShare
{
    [self setProtrolAlert];
}


-(void)setProtrolAlert
{
    [self.view endEditing:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    zjShareView = [[ZJShareAlertView alloc]initWithHeaderImage:self.imageUrl withPersonName:self.userName.text withCommandCode:self.codeLabel.text withQRUrl:self.imageUrl];
    zjShareView.delegate=self;
    [zjShareView show];
    _shareTypeArr = [NSMutableArray arrayWithObjects:
                     @(SSDKPlatformSubTypeWechatTimeline),
                     @(SSDKPlatformSubTypeWechatSession),
                     @(SSDKPlatformTypeSinaWeibo), nil];

}

#pragma mark ZJShareAlterViewDelegate
-(void)zjProtocolAlertClikButtonIndex:(NSInteger)index alert:(ZJShareAlertView *)alert
{
    NSUInteger typeUI = 0;
    typeUI = [_shareTypeArr[index] unsignedIntegerValue];
    NSLog(@"%lu",(unsigned long)typeUI);
    //built share parames
    NSDictionary *shareContent = (NSDictionary *)_publishContent;
    NSString *text = shareContent[@"text"];
    NSArray *image = shareContent[@"image"];
    NSString *url  = shareContent[@"url"];
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:text
                                     images:image
                                        url:[NSURL URLWithString:url]
                                      title:text
                                       type:SSDKContentTypeAuto];
    [ShareSDK share:typeUI
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 if (typeUI == SSDKPlatformTypeCopy) {
                     NSLog(@"复制成功~");
                 } else {
                     NSLog(@"分享成功~");
                 }
             }
                 break;
             case SSDKResponseStateFail:
             {
                 NSLog(@"分享失败~");
             }
                 break;
             case SSDKResponseStateCancel:
             {
                 NSLog(@"分享取消~");
             }
                 break;
             default:
                 break;
         }
     }];

//    if (index == 0) {
//        
//        NSLog(@"000");
//        
//    }else if (index== 1){
//        
//        NSLog(@"111");
//        
//    }else{
//        
//        NSLog(@"222");
//        
//    }

}



-(void)getMyPageData
{
    
        [ZJMyPageRequest zjgetUserInfoWithParams:nil result:^(BOOL success, id responseData) {
            
            // 请求成功
            if (success) {
                
                NSLog(@"1111%@",responseData);
                if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
//
                    self.phoneNmber = [[responseData objectForKey:@"data"] objectForKey:@"phone"];
                    self.userName.text =[[responseData objectForKey:@"data"] objectForKey:@"username"];
                    self.codeLabel.text =[[responseData objectForKey:@"data"] objectForKey:@"recommendCode"];
                    
                    if ([ZJUtil getUserIsDebtBank]) {
                        self.isVIPLabel.text = [[responseData objectForKey:@"data"] objectForKey:@"hangzhang"];
                    }else{
                        self.isVIPLabel.text = @"普通会员";
                    }
                   
                 
                    
                    self.recommand_1 = [NSString stringWithFormat:@"%@",[[responseData objectForKey:@"data"] objectForKey:@"zhaishi"]];
                    self.recommand_2 = [NSString stringWithFormat:@"%@",[[responseData objectForKey:@"data"] objectForKey:@"kaihang"]];
                    self.recommand_3 = [NSString stringWithFormat:@"%@",[[responseData objectForKey:@"data"] objectForKey:@"jiezhai"]];
                    self.recommand_4 = [NSString stringWithFormat:@"%@",[[responseData objectForKey:@"data"] objectForKey:@"huiyuan"]];

                    if ([[[responseData objectForKey:@"data"] objectForKey:@"image"] isEqualToString:@""]) {
                        
                        self.headerImage.image = [UIImage imageNamed:@"head-portrait"];
                    }else{
                        

                        self.imageUrl = [[responseData objectForKey:@"data"] objectForKey:@"image"];
                        
                        [self.headerImage sd_setImageWithURL: self.imageUrl placeholderImage:[UIImage imageNamed:@"head-portrait"]];

                    }
                    [self.tableView reloadData];
                }else{
                    
                    [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"%@",[responseData objectForKey:@"message"]]];
                }
            }else{
                [ZJUtil showBottomToastWithMsg:@"系统异常"];

            }
        }];
        
    
}


// 个人资料
-(void)gotoOwnerDataVC
{
    if ([ZJUtil getUserLogin]) {
        
        ZJOwnerDataController *ownerVC = [[ZJOwnerDataController alloc]initWithNibName:@"ZJOwnerDataController" bundle:nil];
        
        if (!self.userName.text) {
            ownerVC.userName = @"用户名";
        }else{
            ownerVC.userName = self.userName.text;
        }
        
        if (!self.headerImage.image) {
            ownerVC.image = [UIImage imageNamed:@"head-portrait"];
        }else{
            ownerVC.imageUrl = self.imageUrl;
            NSLog(@"%@",ownerVC.image);
        }
        
        if (!self.phoneNmber) {
            ownerVC.phoneNmber = @"18300210192";
        }else{
            ownerVC.phoneNmber = self.phoneNmber;
        }
        [ownerVC setHidesBottomBarWhenPushed:YES];
        
        [self.navigationController pushViewController:ownerVC animated:YES];
    }else {
        
        ZJLoginViewController *loginVC = [[ZJLoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
   
}


//  退出
-(void)alertShow:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"登录"]) {
        ZJLoginViewController *loginVc = [[ZJLoginViewController alloc]init];
        [loginVc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:loginVc animated:YES];
    }else if ([sender.titleLabel.text isEqualToString:@"退出"]){
        alertcon = [UIAlertController alertControllerWithTitle:@"确定要退出吗" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        // 添加按钮
        __weak typeof(alertcon) weakAlert = alertcon;
        [alertcon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            NSLog(@"点击了确定按钮--%@-%@", [weakAlert.textFields.firstObject text], [weakAlert.textFields.lastObject text]);
            
            // 退出
            [ZJUserInfo removeUserInfoWithUserToken];
            [ZJUserInfo changeUserLoginState:NO];
            // 点击退出按钮 效果
            [_quitBut setTitle:@"登录" forState:UIControlStateNormal];
            _quitBut.titleLabel.font = [UIFont systemFontOfSize:14];
        
            self.headerImage.image = [UIImage imageNamed:@"head-portrait"];
            self.userName.hidden = YES;
            self.vipImageView.hidden = YES;
            self.isVIPImageView.hidden = YES;
            self.isVIPLabel.hidden = YES;
            self.codeLabel.hidden = YES;
            self.QRcodeView.hidden = YES;
            
            [zjMyMembercell.recommandLabel_1 setText:[NSString stringWithFormat:@"%d个",0]];
            zjMyMembercell.recommandLabel_1.enabled = YES;
            [zjMyMembercell.recommandLabel_2 setText:[NSString stringWithFormat:@"%d个",0]];
            zjMyMembercell.recommandLabel_2.enabled = YES;
            [zjMyMembercell.recommandLabel_3 setText:[NSString stringWithFormat:@"%d个",0]];
            zjMyMembercell.recommandLabel_3.enabled = YES;
            [zjMyMembercell.recommandLabel_4 setText:[NSString stringWithFormat:@"%d个",0]];
            zjMyMembercell.recommandLabel_4.enabled = YES;


            //为了在债事人请求那里用
            [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"DebtPersonRequest"];
            [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"DebtMangerRequest"];
            //清除缓存
            [ZJUtil clearCachesWithFilePath:[ZJUtil CachesDirectory]];
//            [ZJUserInfo removeUserInfoWithUserToken];
            
            //            float caches = [ZJUtil  sizeWithFilePaht:[ZJUtil CachesDirectory]];
            //            text = [NSString stringWithFormat:@"%0.2fMB",caches];    //计算缓存大小
        }]];
        [alertcon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"点击了取消按钮");
        }]];
        
        [self presentViewController:alertcon animated:YES completion:nil];
    }
    
    
    
}

//  添加手势
-(void)setheaderImageGesture
{
    //  给头像加一个圆形边框
    self.headerImage.layer.borderWidth = 1.5f;
    self.headerImage.layer.borderColor = [UIColor whiteColor].CGColor;
    
    /**
     *  添加手势：也就是当用户点击头像了之后，对这个操作进行反应
     */
    //允许用户交互
    _headerImage.userInteractionEnabled = YES;
    
    //初始化一个手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                               action:@selector(alterHeadPortrait)];
    
    //给imageView添加手势
    [_headerImage addGestureRecognizer:singleTap];
}

//  方法：alterHeadPortrait
-(void)alterHeadPortrait{

    [self gotoOwnerDataVC];

}

-(NSMutableArray *)tableViewdataSource
{
    
    if (_tableViewdataSource == nil) {
        
        _tableViewdataSource = [NSMutableArray arrayWithObjects:@[
                               @[@"myvip",@"我的推荐",@""],
                              ],
                             @[
                               @[@"bill",@"我的账单",@""],
                               @[@"purse",@"我的钱包",@""],
                              ],
                             @[
                                @[@"update",@"版本更新",ZJAPP_VERSION],
                                @[@"opinion",@"意见反馈",@""],
                                @[@"contact",@"联系我们",@"400-068-9588"],
                              ],
                                nil];
    }
    return _tableViewdataSource;
}


-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return _tableView;
}

#pragma mark TableView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableViewdataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.tableViewdataSource[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *str  =@"vsd";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    移除cell.contentView 上的子视图（解决重影效果）
    for (UIView *subView in cell.contentView.subviews) {
        
        [subView removeFromSuperview];
        
    }

    UIImageView *imahe = [[UIImageView alloc]init];
    imahe.top = TRUE_1(25/2);
    imahe.left = TRUE_1(30/2);
    imahe.width = TRUE_1(50/2);
    imahe.height = imahe.width;
    imahe.image = [UIImage imageNamed:self.tableViewdataSource[indexPath.section][indexPath.row][0]];
    
    UILabel *label = [[UILabel alloc]init];
    label.top = imahe.top;
    label.left = imahe.right+TRUE_1(30/2);
    label.width = TRUE_1(100);
    label.height = imahe.height;
    label.font = ZJ_TRUE_FONT(28/2);
    label.text = self.tableViewdataSource[indexPath.section][indexPath.row][1];
    label.textColor=ZJColor_333333;

    UILabel *detianllabel = [[UILabel alloc]init];
    detianllabel.top = imahe.top;
    detianllabel.left = ZJAPPWidth-TRUE_1(170);
    detianllabel.width = TRUE_1(150);
    detianllabel.height = imahe.height;
    detianllabel.font = ZJ_TRUE_FONT(26/2);
    detianllabel.text = self.tableViewdataSource[indexPath.section][indexPath.row][2];
    detianllabel.textAlignment=NSTextAlignmentRight;
    detianllabel.textColor=ZJColor_999999;
    
    UIImageView *bottomLine = [[UIImageView alloc]init];
    bottomLine.top = TRUE_1(100/2);
    bottomLine.left = label.left;
    bottomLine.width = ZJAPPWidth-bottomLine.left;
    bottomLine.height = 1;
    bottomLine.image = [UIImage imageNamed:@"line"];
    
    [cell.contentView addSubview:imahe];
    [cell.contentView addSubview:label];
    [cell.contentView addSubview:detianllabel];
    [cell.contentView addSubview:bottomLine];
    
    
    if (indexPath.section == 0) {
    
        static NSString *str  =@"111";
        zjMyMembercell = [tableView dequeueReusableCellWithIdentifier:str];
        if (zjMyMembercell == nil) {
            zjMyMembercell = [[[NSBundle mainBundle]loadNibNamed:@"ZJMyMemberTableViewCell" owner:self options:nil]firstObject];
        }
        
        zjMyMembercell.selectionStyle = UITableViewCellSelectionStyleNone;
        zjMyMembercell.imageHeader.image = [UIImage imageNamed:self.tableViewdataSource[indexPath.section][indexPath.row][0]];
        
        if ([ZJUtil getUserLogin]) {
            // 推荐备案数
            [zjMyMembercell.recommandLabel_1 setText:[NSString stringWithFormat:@"%@个",self.recommand_1]];
            [zjMyMembercell.recommandRecoardBut addTarget:self action:@selector(touchRecoardBut) forControlEvents:UIControlEventTouchUpInside];
            // 推荐行长
            [zjMyMembercell.recommandLabel_2 setText:[NSString stringWithFormat:@"%@个",self.recommand_2]];
            
            [zjMyMembercell.recommandBankBut addTarget:self action:@selector(touchBankBut) forControlEvents:UIControlEventTouchUpInside];
            // 解债数
            [zjMyMembercell.recommandLabel_3 setText:[NSString stringWithFormat:@"%@个",self.recommand_3]];
            
            [zjMyMembercell.dismissDebtBut addTarget:self action:@selector(touchdismissDebtBut) forControlEvents:UIControlEventTouchUpInside];
            
            // 推荐会员数
            [zjMyMembercell.recommandLabel_4 setText:[NSString stringWithFormat:@"%@个",self.recommand_4]];
            
            [zjMyMembercell.recomMemberBut addTarget:self action:@selector(touchMyMemberBut) forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            
            [zjMyMembercell.recommandLabel_1 setText:[NSString stringWithFormat:@"%d个",0]];
            [zjMyMembercell.recommandLabel_2 setText:[NSString stringWithFormat:@"%d个",0]];
            [zjMyMembercell.recommandLabel_3 setText:[NSString stringWithFormat:@"%d个",0]];
            [zjMyMembercell.recommandLabel_4 setText:[NSString stringWithFormat:@"%d个",0]];

        }
        
    
     return zjMyMembercell;
        
    }else if (indexPath.section == 1){
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        return cell;
    }
    else{
        
        return cell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TRUE_1(5);
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return TRUE_1(200/2);
    }else
    
        return TRUE_1(100/2);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        
        
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
//            ZJMyZhangDanViewController *zhangdanVC = [[ZJMyZhangDanViewController alloc]initWithNibName:@"ZJMyZhangDanViewController" bundle:nil];
//            [zhangdanVC setHidesBottomBarWhenPushed:YES];
//            [self.navigationController pushViewController:zhangdanVC animated:YES];
            
            [ZJUtil showBottomToastWithMsg:@"该功能正在开发中"];
        }else if (indexPath.row == 1){
            
//            ZJMyBillViewController *billVC  = [[ZJMyBillViewController alloc]initWithNibName:@"ZJMyBillViewController" bundle:nil];
//            [billVC setHidesBottomBarWhenPushed:YES];
//            [self.navigationController pushViewController:billVC animated:YES];
            
            [ZJUtil showBottomToastWithMsg:@"该功能正在开发中"];

         }

        
    }else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
           
           
        }else if (indexPath.row == 1){
            
            // 弹出意见反馈页面
            [self.view addSubview:smallProtrolView];
            
            
            
        }else if (indexPath.row == 2){
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel:4000689588"]];
            
        }

        
        
    }
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, TRUE_1(10/2))];
    view.backgroundColor = ZJColor_efefef;
    return view;
}

#pragma mark smallProtrolView意见反馈
- (void)resesmallProtrolView
{
    smallProtrolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight)];
    UITapGestureRecognizer * hidderprotap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyBoard)];
    [smallProtrolView addGestureRecognizer:hidderprotap];
//    smallProtrolView.backgroundColor = [UIColor whiteColor];
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight)];
    [smallProtrolView addSubview:bgView];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.4;
    
    UIView *backView=[[UIView alloc]init];
    backView.frame = CGRectMake(0, 0, ZJAPPWidth-TRUE_1(75),TRUE_1(450));
    backView.center = smallProtrolView.center;
    backView.layer.cornerRadius = TRUE_1(5);
    backView.backgroundColor=[UIColor whiteColor];
    backView.layer.shadowOffset= CGSizeMake(0, 2);
    backView.layer.shadowColor=[UIColor blackColor].CGColor;
    backView.layer.shadowOpacity=0.5;
    backView.layer.shadowRadius=2;
    [smallProtrolView addSubview:backView];
    
    UILabel * Onelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, backView.width, TRUE_1(40))];
    Onelabel.textAlignment=NSTextAlignmentCenter;
    Onelabel.text=@"意见反馈";
    Onelabel.textColor=ZJColor_333333;
    Onelabel.font=ZJ_FONT(TRUE_1(15));
    [backView addSubview:Onelabel];
    
    UIView * TwoView=[[UIView alloc]initWithFrame:CGRectMake(0, TRUE_1(40), backView.width, TRUE_1(325))];
    TwoView.backgroundColor=HexRGB(colorLong(@"efefef"));
    [backView addSubview:TwoView];
    
    writeTextView=[[UITextView alloc]initWithFrame:CGRectMake(TRUE_1(20),TRUE_1(50), backView.width-TRUE_1(40), TRUE_1(305))];
    writeTextView.textColor=ZJColor_666666;
    writeTextView.backgroundColor=HexRGB(colorLong(@"efefef"));
    writeTextView.font=ZJ_FONT(TRUE_1(12));
    writeTextView.showsVerticalScrollIndicator=NO;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2.5;// 字体的行间距
    writeTextView.tag=2001;
    writeTextView.delegate = self;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:10],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    writeTextView.attributedText = [[NSAttributedString alloc] initWithString:writeTextView.text attributes:attributes];
    [backView addSubview:writeTextView];
    
    UIView * threeView=[[UIView alloc]initWithFrame:CGRectMake(0, TwoView.bottom, backView.width, TRUE_1(85))];
    threeView.layer.cornerRadius = TRUE_1(5);
    threeView.backgroundColor=[UIColor whiteColor];
    [backView addSubview:threeView];
    
    
    UIButton * quitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame=CGRectMake(TRUE_1(20), TRUE_1(30), (backView.width-TRUE_1(80))/2,TRUE_1(27));
    [quitBtn setTitle:@"取消" forState:UIControlStateNormal];
    quitBtn.titleLabel.font=ZJ_FONT(TRUE_1(13));
    quitBtn.tag=2001;
    [quitBtn setTitleColor:ZJColor_666666 forState:UIControlStateNormal];
    quitBtn.backgroundColor=HexRGB(colorLong(@"efefef"));
    quitBtn.layer.cornerRadius=TRUE_1(3);
    quitBtn.layer.masksToBounds=YES;
    [threeView addSubview:quitBtn];
    [quitBtn addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * okBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame=CGRectMake(TRUE_1(20)+backView.width/2, TRUE_1(30), (backView.width-TRUE_1(80))/2, TRUE_1(27));
    [okBtn setTitle:@"确认" forState:UIControlStateNormal];
    okBtn.titleLabel.font=ZJ_FONT(TRUE_1(13));
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    okBtn.tag=2002;
    okBtn.backgroundColor=ZJColor_red;
    okBtn.layer.cornerRadius=TRUE_1(3);
    okBtn.layer.masksToBounds=YES;
    [threeView addSubview:okBtn];
    [okBtn addTarget:self action:@selector(touchAgree:) forControlEvents:UIControlEventTouchUpInside];
    
}

// 取消
- (void)touchCancel:(UIButton *)button
{

    [self showCanleView];


}

//  确定  （需要将smallProtrolView的文字上传到后台）网络请求
- (void)touchAgree:(UIButton *)button
{
    if ( [ZJUtil isKGEmpty:writeTextView.text]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请给我们留下您宝贵的意见" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            writeTextView.text = nil;
            [smallProtrolView removeFromSuperview];
            
        }];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            writeTextView.text = nil;
            
        }];
        
        // Add the actions.
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
         [self postMyIdearData];
       
        
    }
    
}

// 意见反馈请求
-(void)postMyIdearData
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:writeTextView.text,@"feedback", nil];
    
    [ZJMyPageRequest zjPOSTMyIdearRequestWithParams:dic result:^(BOOL success, id responseData) {
        
        // 请求成功
        if (success) {
            
            NSLog(@"1111%@",responseData);
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的意见已提交,会尽快处理" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    writeTextView.text = nil;
                    [smallProtrolView removeFromSuperview];
                    
                }];
                
                // Add the actions.
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
                

                
            }else{
                
                [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"%@",[responseData objectForKey:@"message"]]];
                [smallProtrolView removeFromSuperview];
            }
        }
        // 请求失败
        else{
            [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"系统异常"]];
        }
    }];
    
    
}


// 失败
-(void)showCanleView
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定结束编辑吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        writeTextView.text = nil;

    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [smallProtrolView removeFromSuperview];
        writeTextView.text = nil;
        
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}



/*
 *  我的会员点击事件
 */

//  推荐备案数
-(void)touchRecoardBut
{
    ZJDebtMangerViewController *zjDebtVC = [[ZJDebtMangerViewController alloc]initWithNibName:@"ZJDebtMangerViewController" bundle:nil];
    zjDebtVC.isPopVc=YES;
    zjDebtVC.Btntype = ZJDebtMangerUnsolved;
    zjDebtVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:zjDebtVC animated:YES];
}

//  推荐行长数
-(void)touchBankBut
{
    ZJRecommendBankVC *zjRecommangBankPersonVC = [[ZJRecommendBankVC alloc]initWithNibName:@"ZJRecommendBankVC" bundle:nil];
    zjRecommangBankPersonVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:zjRecommangBankPersonVC animated:YES];
}

//  解债数
-(void)touchdismissDebtBut
{
    ZJDebtMangerViewController *zjDebtVC = [[ZJDebtMangerViewController alloc]initWithNibName:@"ZJDebtMangerViewController" bundle:nil];
    zjDebtVC.isPopVc=YES;
    zjDebtVC.Btntype = ZJDebtMangerResolved;
    zjDebtVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:zjDebtVC animated:YES];
    
}

// 我的会员
-(void)touchMyMemberBut
{
    ZJMyMemberViewController *zjMyMemberVC = [[ZJMyMemberViewController alloc]initWithNibName:@"ZJMyMemberViewController" bundle:nil];
    zjMyMemberVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:zjMyMemberVC animated:YES];    
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;

}

// 想调才调，目前打电话方式可以(备用)
-(void)callTelePhoneNmuber
{
    NSMutableString *str=[[NSMutableString alloc]initWithFormat:@"tel:%@",@"4000689588"];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"联系我们" message:@"400-068-9588" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];

}
//手势隐藏键盘
- (void)hiddenKeyBoard
{
    [self.view endEditing:YES];
}
//放大图片
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_tableView.contentOffset.y<=0) {
        CGFloat h=(_tableView.contentOffset.y*-1.0)/TRUE_1(328/2)+1;
        if (h>1) {
            _headerBackGroundImage.transform=CGAffineTransformMakeScale(h, h);
        }
        _headerBackGroundImage.top=0+_tableView.contentOffset.y;
    }
}

@end
