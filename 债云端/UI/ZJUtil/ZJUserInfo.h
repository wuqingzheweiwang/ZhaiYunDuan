//
//  ZJUserInfo.h
//  债云端
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJUserInfo : NSObject
//存储用户信息
+ (void)saveInfo:(NSDictionary *)dic;
//获取用户信息
+ (NSMutableDictionary *)getUserInfo;
//存
+ (NSString*)filePath:(NSString*)fileName;
//删
+ (void)removeFileAtPath:(NSString *)filePath;
/**
 *  获取用户id
 */
+ (NSString *)getUserSexForUserInfo;
//存储用户ID
+ (void)saveUserInfoWithUserID:(NSString *)userID;
//获得用户ID
+ (NSString *)getUserIDForUserInfo;

//存储用户token
+ (void)saveUserInfoWithUserToken:(NSString *)usertoken;
//获得用户token
+ (NSString *)getUserIDForUserToken;
//清除token
+ (void)removeUserInfoWithUserToken;
//存储用户身份
+ (void)saveUserInfoWithUserRole:(NSString *)userRole;
//获得用户身份
+ (NSString *)getUserRoleForUserRole;

//存储用户角色
+ (void)saveUserInfoWithUserhangtype:(NSString *)hangtype;
//获得用户角色
+ (NSString *)getUserRoleForUserhangtype;


//存储用户手机号
+ (void)saveUserInfoWithUserPhone:(NSString *)userRole;
//获得用户手机号
+ (NSString *)getUserRoleForUserPhone;
/**
 *  改变登录状态
 */
+ (void)changeUserLoginState:(BOOL)isLogin;
@end
