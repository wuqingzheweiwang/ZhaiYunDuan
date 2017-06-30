//
//  ZJTabbarViewController.m
//  债云端
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJTabbarViewController.h"
#import "ZJHomeViewController.h"
#import "ZJMyPageViewController.h"
#import "ZJDebtMangerViewController.h"
#import "ZJDebtPersonViewController.h"
#define MAXFLOAT    0x1.fffffep+127f

@interface ZJTabbarViewController ()<UITabBarControllerDelegate>
@end

@implementation ZJTabbarViewController

{
    NSInteger currentSelectIndex;
    
}
//在自定义tabbar中的控制器里
+ (void)load
{
    // 获取当前类的tabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 设置所有item的选中时颜色

    // 设置选中文字颜色
    // 创建字典去描述文本
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    [item setTitleTextAttributes:attr forState:UIControlStateSelected];
    // 通过normal状态设置字体大小
    // 字体大小 跟 normal
    NSMutableDictionary *attrnor = [NSMutableDictionary dictionary];
    // 设置字体
    attrnor[NSFontAttributeName] = [UIFont systemFontOfSize:12];
//    attrnor[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrnor forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[ZJHomeViewController alloc]init]];
    UINavigationController *nav_1 = [[UINavigationController alloc]initWithRootViewController:[[ZJDebtMangerViewController alloc]init]];
    UINavigationController *nav_2 = [[UINavigationController alloc]initWithRootViewController:[[ZJDebtPersonViewController alloc]init]];
    UINavigationController *nav_3 = [[UINavigationController alloc]initWithRootViewController:[[ZJMyPageViewController alloc]init]];
    nav.navigationBar.barTintColor = ZJColor_red;
    nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"home-gray"] selectedImage:[UIImage imageNamed:@"home-red"]];
    nav_1.navigationBar.barTintColor = ZJColor_red;
    nav_1.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"债事管理" image:[UIImage imageNamed:@"debt-manage-gray"] selectedImage:[UIImage imageNamed:@"debt-manage-red"]];
    nav_2.navigationBar.barTintColor = ZJColor_red;
    nav_2.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"债事人管理" image:[UIImage imageNamed:@"debt-people-manage-gray"] selectedImage:[UIImage imageNamed:@"debt-people-manage-red"]];
    nav_3.navigationBar.barTintColor = ZJColor_red;
    nav_3.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"mine-gray"] selectedImage:[UIImage imageNamed:@"mine-red"]];

    self.viewControllers = @[nav,nav_1,nav_2,nav_3];
    self.tabBar.tintColor = [UIColor redColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    isShowSmallSlidView =false;
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(smallSlidView:) name:@"smallSlidView" object:nil];

}

#pragma mark -小框
-(UIView*)smallSlidView:(float)width height:(float)height value:(NSString*)value{
    UIView * _smallSlidView = [[UIView alloc]initWithFrame:CGRectMake(ZJAPPWidth/2-width/2, ZJAPPHeight - 100, width, height)];
    [_smallSlidView setBackgroundColor:[UIColor blackColor]];
    [_smallSlidView setAlpha:0];
    _smallSlidView.layer.masksToBounds = YES;
    _smallSlidView.layer.cornerRadius = 3;
    
    UILabel * text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, height)];
    [text setTextColor:[UIColor whiteColor]];
    [text setBackgroundColor:[UIColor clearColor]];
    [text setTextAlignment:NSTextAlignmentCenter];
    [text setFont:[UIFont fontWithName:@"Arial" size:14]];
    text.text = value;
    CGSize mySize;
    mySize = [text.text sizeWithFont:text.font constrainedToSize:CGSizeMake(text.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    [text setFrame:CGRectMake(0, 0, mySize.width, mySize.height)];
    text.numberOfLines=(int)mySize.height/text.font.xHeight;
    [_smallSlidView setFrame:CGRectMake(ZJAPPWidth/2-(text.frame.size.width+20)/2, ZJAPPHeight - 100-30, text.frame.size.width+20, text.frame.size.height+20)];
    [text setFrame:CGRectMake(_smallSlidView.frame.size.width/2-text.frame.size.width/2, _smallSlidView.frame.size.height/2-text.frame.size.height/2, mySize.width, mySize.height)];
    [_smallSlidView addSubview:text];
    
    return _smallSlidView;
}
-(void)smallSlidView:(NSNotification*)value{
    if (!isShowSmallSlidView ) {
        isShowSmallSlidView = true;
        id obj = [value object];
        smallSlidView=nil;
        smallSlidView = [self smallSlidView:[[obj objectAtIndex:0]floatValue]  height:[[obj objectAtIndex:1]floatValue] value:[obj objectAtIndex:2]] ;
        //        UIWindow *keywindow=[UIApplication sharedApplication].keyWindow;
        //        [keywindow addSubview:smallSlidView];
        [self.view.window addSubview:smallSlidView];
        [self showSlidAnimation];
    }
}
-(void)showSlidAnimation{
    smallSlidView.frame=CGRectMake((ZJAPPWidth-smallSlidView.frame.size.width)/2, ZJAPPHeight,smallSlidView.frame.size.width,smallSlidView.frame.size.height);
    [smallSlidView setAlpha:.88f];
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        smallSlidView.frame=CGRectMake((ZJAPPWidth-smallSlidView.frame.size.width)/2, ZJAPPHeight-smallSlidView.frame.size.height-70,smallSlidView.frame.size.width,smallSlidView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2000*USEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self endSlidAnimation];
    });
}
-(void)endSlidAnimation{
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        smallSlidView.transform = CGAffineTransformMakeScale(1.03, 1);
        smallSlidView.alpha=0.5;
    } completion:^(BOOL finished) {
        smallSlidView.alpha=0;
        isShowSmallSlidView = false;
    }];
}
-(void)closedSlidAnimation{
    isShowSmallSlidView = false;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
