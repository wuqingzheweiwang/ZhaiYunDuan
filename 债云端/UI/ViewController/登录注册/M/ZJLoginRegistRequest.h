//
//  ZJLoginRegistRequest.h
//  债云端
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJDataRequest.h"
typedef void(^result)(BOOL success, id responseData);
@interface ZJLoginRegistRequest : NSObject
/*
 *登录POST
 */
+ (void)zjLoginWithParams:(NSMutableDictionary *)params result:(result)result;

/*
 *注册POST
 */
+ (void)zjRegistWithParams:(NSMutableDictionary *)params result:(result)result;
/*
 *发送验证码
 */
+ (void)zjRegistVerifyWithActions:(NSString *)action result:(result)result;
/*
 *找回密码
 */
+ (void)zjFoundPasswordVerifyWithParams:(NSMutableDictionary *)params result:(result)result;
@end
