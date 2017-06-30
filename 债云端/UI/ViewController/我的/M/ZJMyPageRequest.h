//
//  ZJMyPageRequest.h
//  债云端
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJDataRequest.h"
typedef void(^result)(BOOL success, id responseData);
@interface ZJMyPageRequest : NSObject
/*
 * 获取个人信息POST
 */
+ (void)zjgetUserInfoWithParams:(NSMutableDictionary *)params result:(result)result;
/*
 * 推荐行长列表
 */
+(void)GetRecommandBankRequestWithActions:(NSString *)action result:(result)result;
/*
 * 我的会员列表
 */
+(void)GetMyMemberListRequestWithActions:(NSString *)action result:(result)result;
/*
 * 我的钱包POST
 */
+(void)zjPOSTMyBillRequestWithParams:(NSMutableDictionary *)params result:(result)result;
/*
 * 我的账单POST
 */
+(void)zjPOSTMyZhangDanRequestWithParams:(NSMutableDictionary *)params result:(result)result;
/*
 * 意见反馈POST
 */
+(void)zjPOSTMyIdearRequestWithParams:(NSMutableDictionary *)params result:(result)result;
/*
 * 添加银行卡POST
 */
+ (void)zjaddBandCardWithParams:(NSMutableDictionary *)params result:(result)result;
/*
 * 获取验证码
 */
+ (void)zjRegistVerifyWithActions:(NSString *)action result:(result)result;
/*
 * 更改手机号POST
 */
+ (void)zjChangeTelphoneNumberWithParams:(NSMutableDictionary *)params result:(result)result;
/*
 * 充值POST
 */
+ (void)zjPayMoneyPOSTWithParams:(NSMutableDictionary *)params result:(result)result;
/*
 * 提现POST
 */
+ (void)zjGetMoneyPOSTWithParams:(NSMutableDictionary *)params result:(result)result;
@end
