//
//  ZJUserInfo.m
//  债云端
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJUserInfo.h"
#define UserDeafult [NSUserDefaults standardUserDefaults]
@implementation ZJUserInfo

//存储用户信息
+ (void)saveInfo:(NSDictionary *)dic
{
    NSString * userInfoPath = [ZJUserInfo filePath:@"NPUserInfo.plist"];
    [dic writeToFile:userInfoPath atomically:YES];
}
//获取用户信息
+ (NSMutableDictionary *)getUserInfo
{
    NSString * userInfoPath = [ZJUserInfo filePath:@"NPUserInfo.plist"];
    NSMutableDictionary * resutDic = [NSMutableDictionary dictionaryWithContentsOfFile:userInfoPath];
    return resutDic;
}

//存
+ (NSString*)filePath:(NSString*)fileName {
    NSString *archiveDirPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/Information"];
    
    NSError* error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:archiveDirPath]) {
        
        if (![[NSFileManager defaultManager] createDirectoryAtPath:archiveDirPath
                                       withIntermediateDirectories:YES
                                                        attributes:nil
                                                             error:&error])
        {
            return nil;
        }
    }
    NSString *archivePath = [archiveDirPath stringByAppendingFormat:@"/%@", fileName];
    return archivePath;
}

//删
+ (void)removeFileAtPath:(NSString *)filePath {
    NSError *error = nil;
    if ([ZJUserInfo filePath: filePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:[ZJUserInfo filePath: filePath] error:&error];
        
        if (error) {
            DLog(@"移除文件失败，错误信息：%@", error);
        }
        else {
            DLog(@"成功移除文件");
        }
    }
    else {
        DLog(@"文件不存在");
    }
}

//获得用户性别   例子
+ (NSString *)getUserSexForUserInfo
{
    NSDictionary * resultDic = [ZJUserInfo getUserInfo];
    return [resultDic objectForKey:@"sex"];
}
//存储用户ID
+ (void)saveUserInfoWithUserID:(NSString *)userID;
{
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//存储用户token
+ (void)saveUserInfoWithUserToken:(NSString *)usertoken
{
    [[NSUserDefaults standardUserDefaults] setObject:usertoken forKey:@"userToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//清除token
+ (void)removeUserInfoWithUserToken
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//获得用户token
+ (NSString *)getUserIDForUserToken
{
    NSString * usertoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"userToken"];
    return usertoken;
}
//存储用户身份
+ (void)saveUserInfoWithUserRole:(NSString *)userRole
{
    [[NSUserDefaults standardUserDefaults] setObject:userRole forKey:@"isMember"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//获得用户身份
+ (NSString *)getUserRoleForUserRole
{
    NSString * userRole = [[NSUserDefaults standardUserDefaults] objectForKey:@"isMember"];
    return userRole;
}

//存储用户手机号
+ (void)saveUserInfoWithUserPhone:(NSString *)userRole
{
    [[NSUserDefaults standardUserDefaults] setObject:userRole forKey:@"userphone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//获得用户手机号
+ (NSString *)getUserRoleForUserPhone
{
    NSString * userRole = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
    return userRole;
}

//获得用户ID
+ (NSString *)getUserIDForUserInfo
{
    NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    return userID;
}

/**
 *  改变登录状态
 */
+ (void)changeUserLoginState:(BOOL)isLogin
{
//    [UserDeafult removeObjectForKey:@"userloginstate"];
    [UserDeafult setObject:[NSNumber numberWithBool:isLogin] forKey:@"userloginstate"];
    [UserDeafult synchronize];
}
@end
