//
//  ZJLoginRegistRequest.m
//  债云端
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJLoginRegistRequest.h"

@implementation ZJLoginRegistRequest
/*
 *登录POST
 */
+ (void)zjLoginWithParams:(NSMutableDictionary *)params result:(result)result;
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"mobile"
                                          andParameters:params
                                              andIsJson:YES
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}


/*
 *注册POST
 */
+ (void)zjRegistWithParams:(NSMutableDictionary *)params result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/regist/valid"
                                          andParameters:params
                                              andIsJson:YES
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}

/*
 *发送验证码
 */
+ (void)zjRegistVerifyWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                          andParameters:nil
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}

/*
 *找回密码
 */
+ (void)zjFoundPasswordVerifyWithParams:(NSMutableDictionary *)params result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/regist/changePwd"
                                          andParameters:params
                                              andIsJson:YES
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}


@end
