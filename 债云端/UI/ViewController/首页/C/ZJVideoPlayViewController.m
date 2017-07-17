//
//  ZJVideoPlayViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/7/17.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJVideoPlayViewController.h"
#import "ZGLVideoPlyer.h"

@interface ZJVideoPlayViewController ()

@property (nonatomic, strong) ZGLVideoPlyer *player;

@end

@implementation ZJVideoPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavcaition];
    [self creatVideoPlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNav) name:@"show" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideenNav) name:@"hideen" object:nil];


}

-(void)showNav
{
    self.navigationController.navigationBar.hidden = NO;
}

-(void)hideenNav
{
    self.navigationController.navigationBar.hidden = YES;
}

//刷新数据
-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"show" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"hideen" object:nil];

}

-(void)creatVideoPlayer
{
    
    CGFloat deviceWith = [UIScreen mainScreen].bounds.size.width;
    
    self.player = [[ZGLVideoPlyer alloc]initWithFrame:CGRectMake(0, 20, deviceWith, 300)];
    self.player.videoUrlStr = self.movieUrl;
    
    [self.view addSubview:self.player];

}

-(void)setNavcaition
{
    [ZJNavigationPublic setTitleOnTargetNav:self title:self.navgationTitle];
    [ZJNavigationPublic setLeftButtonOnTargetNav:self action:@selector(leftAction) With:[UIImage imageNamed:@"back"]];
}

-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
