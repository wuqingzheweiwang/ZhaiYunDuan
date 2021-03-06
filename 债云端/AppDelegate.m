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
#import "UMMobClick/MobClick.h"
#import "ZJPaySuccessViewController.h"
#define USHARE_DEMO_APPKEY  @""

@interface AppDelegate ()<UITabBarControllerDelegate,UIAlertViewDelegate,WXApiDelegate>
{
    ZJTabbarViewController *tabBar;
    NSString * jumpUrl;
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

    /************** 更新 *****************/
    [ZJHomeRequest zjgetAppapiVersionresult:^(BOOL success, id responseData) {
        if (success) {
            DLog(@"%@",responseData);
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                NSDictionary * dataDic=[responseData objectForKey:@"data"];
                jumpUrl = @"https://itunes.apple.com/cn/app/%E5%80%BA%E4%BA%91%E7%AB%AF/id1210308421?mt=8";
                NSString *serverVersion = [dataDic objectForKey:@"versionNum"];
                
                if ([ZJAPP_VERSION compare:serverVersion options:NSNumericSearch] == NSOrderedAscending) {//升序  需要升级
                    NSString * isForceString=[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"isForce"]];
                    if ([isForceString isEqualToString:@"1"]) {
                        
                        UIAlertController * alertcon = [UIAlertController alertControllerWithTitle:@"升级提示" message:[dataDic objectForKey:@"updateItems"] preferredStyle:UIAlertControllerStyleAlert];
                        // 添加按钮
                        [alertcon addAction:[UIAlertAction actionWithTitle:@"升级" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                            
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:jumpUrl]];
                        }]];
                        
                        [self.window.rootViewController presentViewController:alertcon animated:YES completion:nil];
                        
                    } else {
                        UIAlertController * alertcon = [UIAlertController alertControllerWithTitle:@"升级提示" message:[dataDic objectForKey:@"updateItems"] preferredStyle:UIAlertControllerStyleAlert];
                        // 添加按钮
                        [alertcon addAction:[UIAlertAction actionWithTitle:@"马上就去" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                            
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:jumpUrl]];
                        }]];
                        [alertcon addAction:[UIAlertAction actionWithTitle:@"以后再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            
                            
                        }]];
                        [self.window.rootViewController presentViewController:alertcon animated:YES completion:nil];
                    }
                }
            }
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
    
    
    
    
    
    /************** 微信支付 *****************/
    [WXApi registerApp:@"wxbc0753acdfa4e7c3"];
    [WXApi registerApp:@"wxbc0753acdfa4e7c3" withDescription:@"demo 2.0"];
    /************** 分享 *****************/
    ZJShareManager *registerManager = [[ZJShareManager alloc] init];
    [registerManager finishLaunchOption:launchOptions];
    /************** 友盟统计 *****************/
    UMConfigInstance.appKey = @"5963012575ca356ae700088d";
    UMConfigInstance.channelId = @"App Store";
    //配置以上参数后调用此方法初始化SDK！
    [MobClick startWithConfigure:UMConfigInstance];
    [MobClick setAppVersion:ZJAPP_VERSION];
    [MobClick setLogEnabled:NO]; //发布为NO
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
                    DLog(@"Unresolved error %@, %@", error, error.userInfo);
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
        DLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


#pragma mark iOS 9.0以上会调用此url回调  支付
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
  
//  微信
    if ([url.host isEqualToString:@"pay"]) {
        // 微信
        return [WXApi handleOpenURL:url delegate:self];
    }else if([url.host isEqualToString:@"safepay"]){
        //  支付宝
        //  跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            DLog(@"result = %@",resultDic);
            if ([resultDic[@"resultStatus"] intValue]==9000) {
                
                [ZJUtil showBottomToastWithMsg:@"支付成功"];
                
                NSString *result = @"支付成功";
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"apliyPay" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:result,@"errCode", nil]];
                
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
    }
   
    return YES;
}


//支付成功时调用，回到第三方应用中
#pragma mark ios 9.0以前会调用此url回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"%@",url.host);
    if ([url.host isEqualToString:@"pay"]) {
        // 微信
      return [WXApi handleOpenURL:url delegate:self];
    }else if([url.host isEqualToString:@"safepay"]){
        // 支付宝
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            DLog(@"result = %@",resultDic);
            if ([resultDic[@"resultStatus"] intValue]==9000) {
                
                [ZJUtil showBottomToastWithMsg:@"支付成功"];
                NSString *result = @"支付成功";
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"apliyPay" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:result,@"errCode", nil]];
                
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
    return YES;
}



#pragma mark WXApiDelegate

//WXSuccess           = 0,    /**< 成功    */
//WXErrCodeCommon     = -1,   /**< 普通错误类型    */
//WXErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
//WXErrCodeSentFail   = -3,   /**< 发送失败    */
//WXErrCodeAuthDeny   = -4,   /**< 授权失败    */
//WXErrCodeUnsupport  = -5,   /**< 微信不支持    */



- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return  [WXApi handleOpenURL:url delegate:self];
    
}
-(void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp*response=(PayResp*)resp;  // 微信终端返回给第三方的关于支付结果的结构体
        switch (response.errCode) {
            case WXSuccess:
            {// 支付成功，向后台发送消息                    0
                DLog(@"支付成功");
                NSString *result = @"支付成功";
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"wXinPay" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:result,@"errCode", nil]];
            }
                break;
            case WXErrCodeCommon:
            { //签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等             -1
                [ZJUtil showBottomToastWithMsg:@"支付失败"];
                DLog(@"支付失败");
            }
                break;
            case WXErrCodeUserCancel:
            { //用户点击取消并返回                        -2
                DLog(@"取消支付");
                [ZJUtil showBottomToastWithMsg:@"取消支付"];
            }
                break;
            case WXErrCodeSentFail:
            { //发送失败                                -3
                DLog(@"发送失败");
                [ZJUtil showBottomToastWithMsg:@"发送失败"];
            }
                break;
            case WXErrCodeUnsupport:
            { //微信不支持                               -4
                DLog(@"微信不支持");
                [ZJUtil showBottomToastWithMsg:@"微信不支持"];
            }
                break;
            case WXErrCodeAuthDeny:
            { //授权失败                                -5
                DLog(@"授权失败");
                [ZJUtil showBottomToastWithMsg:@"授权失败"];
            }
                break;
            default:
                break;
        }
    }
}

@end
