//
//  ZJNavigationPublic.m
//  债云端
//
//  Created by Napai on 17/4/20.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJNavigationPublic.h"

@implementation ZJNavigationPublic


/***
 nav返回键
 ***/
+ (void)setBackButtonOnTargetNav:(id)controller action:(SEL)action {
    //设置navbar上的按钮Back按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:controller action:action forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
    [backBtn sizeToFit];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [[controller navigationItem] setLeftBarButtonItem:backItem];
}

/**
 * nav返回键+标题(有距离)
 **/

+ (void)setLeftButtonOnTargetNav:(id)controller action:(SEL)action WithtitleText:(NSString *)titleText withimage:(UIImage *)imgLeft
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TRUE_1(250/2), TRUE_1(45/2))];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.top = 0;
    backBtn.left = 0;
    backBtn.width = TRUE_1(20/2);
    backBtn.height = TRUE_1(20/2);
    [backBtn addTarget:controller action:action forControlEvents:UIControlEventTouchUpInside];
    [backBtn.titleLabel setFont:ZJ_TRUE_FONT_1(17)];
    [backBtn setImage:imgLeft forState:UIControlStateNormal];
    [backBtn sizeToFit];
    [view addSubview:backBtn];
    
    UILabel *label = [[UILabel alloc]init];
    label.top = backBtn.top;
    label.left = backBtn.right+TRUE_1(60/2);
    label.width = view.width- label.left;
    label.height = backBtn.height;
    [label setText:titleText];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:ZJ_TRUE_FONT_1(17)];
    [view addSubview:label];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    [[controller navigationItem] setLeftBarButtonItem:backItem];

    
    
    
    
}


/***
 nav自定义左键
 ***/
+ (void)setLeftButtonOnTargetNav:(id)controller action:(SEL)action With:(UIImage *)imgLeft{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:controller action:action forControlEvents:UIControlEventTouchUpInside];
    [backBtn.titleLabel setFont:ZJ_TRUE_FONT_1(17)];
    [backBtn setImage:imgLeft forState:UIControlStateNormal];
    [backBtn sizeToFit];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [[controller navigationItem] setLeftBarButtonItem:backItem];
}
+ (void)setLeftButtonOnTargetNav:(id)controller action:(SEL)action Withtitle:(NSString *)title withimage:(UIImage *)imgLeft{
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:controller action:action forControlEvents:UIControlEventTouchUpInside];
    [backBtn.titleLabel setFont:ZJ_TRUE_FONT_1(17)];
    [backBtn setImage:imgLeft forState:UIControlStateNormal];
    [backBtn setTitle:title forState:UIControlStateNormal];
//    [backBtn setTitleColor:HexRGB(colorLong(@"444444")) forState:UIControlStateNormal];
    [backBtn sizeToFit];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [[controller navigationItem] setLeftBarButtonItem:backItem];
}
/***
 nav右键
 ***/
+ (void)setRightButtonOnTargetNav:(id)controller action:(SEL)action image:(UIImage *)image HighImage:(UIImage *)high_img {
    //设置navbar上的右键按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:controller action:action forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:image forState:UIControlStateNormal];
    if (high_img) {
        [rightBtn setImage:high_img forState:UIControlStateSelected];
    }
    [rightBtn sizeToFit];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [[controller navigationItem] setRightBarButtonItem:backItem];
}





+ (void)setRightButtonOnTargetNav:(id)controller action:(SEL)action Withtitle:(NSString *)title withimage:(UIImage *)imgLeft{
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:controller action:action forControlEvents:UIControlEventTouchUpInside];
    backBtn.titleLabel.font = [UIFont fontWithName:@".PingFangSC-Semibold" size:14];
    [backBtn setImage:imgLeft forState:UIControlStateNormal];
    [backBtn setTitle:title forState:UIControlStateNormal];
//    [backBtn setTitleColor:HexRGB(colorLong(@"444444")) forState:UIControlStateNormal];
    [backBtn sizeToFit];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [[controller navigationItem]setRightBarButtonItem:backItem];
}
//为了隐藏
+ (UIButton *)setHiddenRightButtonOnTargetNav:(id)controller action:(SEL)action Withtitle:(NSString *)title {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:controller action:action forControlEvents:UIControlEventTouchUpInside];
    backBtn.titleLabel.font = [UIFont fontWithName:@".PingFangSC-Semibold" size:14];
    [backBtn setTitle:title forState:UIControlStateNormal];
    [backBtn sizeToFit];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [[controller navigationItem]setRightBarButtonItem:backItem];
    return backBtn;
}
/***
 nav的title
 ***/
+ (void)setTitleOnTargetNav:(id)controller title:(NSString *)title{

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 125, 20)];
    label.text = title;
    label.textAlignment=NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@".PingFangSC-Semibold" size:17];
    
    label.textColor = [UIColor whiteColor];
    
    [[controller navigationItem]setTitleView:label];
}

+ (void)setHomeTitleOnTargetNav:(id)controller {
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 165, 20)];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, -2, 30, 20)];
    imageV.image = [UIImage imageNamed:@"logo"];
    [titleView addSubview:imageV];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, 125, 20)];
    label.text = @"中金债事智慧云";
    label.font = [UIFont fontWithName:@".PingFangSC-Semibold" size:17];
    
    label.textColor = [UIColor whiteColor];
    [titleView addSubview:label];
    [[controller navigationItem] setTitleView:titleView];
}
@end
