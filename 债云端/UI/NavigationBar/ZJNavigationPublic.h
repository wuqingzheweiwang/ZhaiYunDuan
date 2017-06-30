//
//  ZJNavigationPublic.h
//  债云端
//
//  Created by Napai on 17/4/20.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZJNavigationPublic : NSObject
/**
 * nav返回键
 ***/
+ (void)setBackButtonOnTargetNav:(id)controller action:(SEL)action;

/**
 * nav返回键+标题(有距离)
 **/
+ (void)setLeftButtonOnTargetNav:(id)controller action:(SEL)action WithtitleText:(NSString *)titleText withimage:(UIImage *)imgLeft;


/**
 * nav自定义左键
 ***/
+ (void)setLeftButtonOnTargetNav:(id)controller action:(SEL)action With:(UIImage *)imgLeft;
+ (void)setLeftButtonOnTargetNav:(id)controller action:(SEL)action Withtitle:(NSString *)title withimage:(UIImage *)imgLeft;

/**
 * nav右键
 ***/
+ (void)setRightButtonOnTargetNav:(id)controller action:(SEL)action image:(UIImage *)image HighImage:(UIImage *)high_img;
+ (void)setRightButtonOnTargetNav:(id)controller action:(SEL)action Withtitle:(NSString *)title withimage:(UIImage *)imgLeft;

//为了隐藏
+ (UIButton *)setHiddenRightButtonOnTargetNav:(id)controller action:(SEL)action Withtitle:(NSString *)title;
/**
 * nav的title
 ***/
+ (void)setTitleOnTargetNav:(id)controller title:(NSString *)title;

/**
 * nav的titleView
 ***/
+ (void)setHomeTitleOnTargetNav:(id)controller;

@end
