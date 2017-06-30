//
//  AppDelegate.h
//  债云端
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ZJTabbarViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
- (void)saveContext;


@end

