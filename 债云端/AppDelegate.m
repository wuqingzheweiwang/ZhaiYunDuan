//
//  AppDelegate.m
//  债云端
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "AppDelegate.h"
#import "ZJTabbarViewController.h"
#import "ZJLoginViewController.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "WXApi.h"
#import "WXApiManager.h"
#import "ZJShareManager.h"
#define USHARE_DEMO_APPKEY  @""

@interface AppDelegate ()<UITabBarControllerDelegate>
{
    ZJTabbarViewController *tabBar;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ////////////////////////////////////////////////////////////////////
    //                          _ooOoo_                               //
    //                         o8888888o                              //
    //                         88" . "88                              //
    //                         (| ^_^ |)                              //
    //                         O\  =  /O                              //
    //                      ____/`---'\____                           //
    //                    .'  \\|     |//  `.                         //
    //                   /  \\|||  :  |||//  \                        //
    //                  /  _||||| -:- |||||-  \                       //
    //                  |   | \\\  -  /// |   |                       //
    //                  | \_|  ''\---/''  |   |                       //
    //                  \  .-\__  `-`  ___/-. /                       //
    //                ___`. .'  /--.--\  `. . ___                     //
    //              ."" '<  `.___\_<|>_/___.'  >'"".                  //
    //            | | :  `- \`.;`\ _ /`;.`/ - ` : | |                 //
    //            \  \ `-.   \_ __\ /__ _/   .-` /  /                 //
    //      ========`-.____`-.___\_____/___.-`____.-'========         //
    //                           `=---='                              //
    //      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        //
    //         佛祖保佑            永无BUG              永不修改          //
    ////////////////////////////////////////////////////////////////////
    
   
    //  获取和设置激活状态
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    //  如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager ] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                NSLog(@"未知网络");
                break;
            case 0:
                NSLog(@"网络不可达");
                break;
            case 1:
                NSLog(@"GPRS网络");
                break;
            case 2:
                NSLog(@"wifi网络");
                break;
            default:
                break;
        }
 if(status ==AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            NSLog(@"有网");
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络无法连接" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.delegate = self;
            [alert show];
        }
    }];


    sleep(1);
    
    
    /************** 1.创建window ***************/
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    
    /************** 2.设置根控制器 **************/
    // 创建tabBarVc
    tabBar = [[ZJTabbarViewController alloc] init];
    tabBar.delegate = self;
    // 设置窗口的根控制器
    self.window.rootViewController = tabBar;
    /************** 3.显示窗口 *****************/
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    /************** 支付 *****************/
    [WXApi registerApp:@"wx92b0f09429075038" withDescription:@"demo 2.0"];
    /************** 分享 *****************/
    ZJShareManager *registerManager = [[ZJShareManager alloc] init];
    [registerManager finishLaunchOption:launchOptions];
    

    
    return YES;
}



//  通过tabBar选中比较字符串(登录状态)判断是否跳转页面
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    if ([viewController.tabBarItem.title isEqualToString:@"债事管理"]||[viewController.tabBarItem.title isEqualToString:@"债事人管理"]) {
        //如果用户ID存在的话，说明已登陆([ZJUtil getUserLogin]= YES说明已登录)
        if ([ZJUtil getUserLogin]) {
            return YES;
        }else{
            //跳到登录页面 CCPLoginVC
            ZJLoginViewController *login = [[ZJLoginViewController alloc]initWithNibName:@"ZJLoginViewController" bundle:nil];;
            //隐藏tabbar
            login.hidesBottomBarWhenPushed =YES;
            [((UINavigationController *)tabBarController.selectedViewController)pushViewController:login animated:YES];
            
            return NO;
            
        }
        
    }else {
        
        return YES;
        
    }

    return YES;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}




#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"___"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


#pragma mark iOS 9.0以上会调用此url回调  支付
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    
//  微信
    NSLog(@"%d",[WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]]);
    
//  支付宝
//  跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        
            NSLog(@"result = %@",resultDic);
        if ([resultDic[@"resultStatus"] intValue]==9000) {
            
            [ZJUtil showBottomToastWithMsg:@"支付成功"];
            
            
        }else if ([resultDic[@"resultStatus"] intValue] == 8000) {
            [ZJUtil showBottomToastWithMsg:@"正在处理中"];
        } else if ([resultDic[@"resultStatus"] intValue] == 4000) {
            [ZJUtil showBottomToastWithMsg:@"订单支付失败"];
        } else if ([resultDic[@"resultStatus"] intValue] == 6001) {
            [ZJUtil showBottomToastWithMsg:@"用户中途取消"];
        } else if ([resultDic[@"resultStatus"] intValue] == 6002) {
            [ZJUtil showBottomToastWithMsg:@"网络连接出错"];
        }
        else {
            
            NSString *resultMes = resultDic[@"memo"];
            resultMes = (resultMes.length<=0?@"支付失败":resultMes);
            [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"%@",resultMes]];
        }
            }];
    
    
    return YES;
}


//支付成功时调用，回到第三方应用中
#pragma mark ios 9.0以前会调用此url回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
        
    // 支付宝
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        
        NSLog(@"result = %@",resultDic);
        if ([resultDic[@"resultStatus"] intValue]==9000) {
            
            [ZJUtil showBottomToastWithMsg:@"支付成功"];
            
            
        }else if ([resultDic[@"resultStatus"] intValue] == 8000) {
            [ZJUtil showBottomToastWithMsg:@"正在处理中"];
        } else if ([resultDic[@"resultStatus"] intValue] == 4000) {
            [ZJUtil showBottomToastWithMsg:@"订单支付失败"];
        } else if ([resultDic[@"resultStatus"] intValue] == 6001) {
            [ZJUtil showBottomToastWithMsg:@"用户中途取消"];
        } else if ([resultDic[@"resultStatus"] intValue] == 6002) {
            [ZJUtil showBottomToastWithMsg:@"网络连接出错"];
        }
        else {
            
            NSString *resultMes = resultDic[@"memo"];
            resultMes = (resultMes.length<=0?@"支付失败":resultMes);
            [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"%@",resultMes]];
        }
    }];
    
    // 微信
    NSLog(@"%d",[WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]]);

    
   
   
    
    
    return YES;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    
}

@end
