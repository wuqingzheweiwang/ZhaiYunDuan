//
//  ZJMyPageRequest.m
//  债云端
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJMyPageRequest.h"

@implementation ZJMyPageRequest

/*
 * 获取个人信息POST
 */
+ (void)zjgetUserInfoWithParams:(NSMutableDictionary *)params result:(result)result
{

    [[ZJDataRequest shareInstance]getDataWithURLString:@"api/my/my"
                                         andParameters:params
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}

/*
 * 推荐行长列表
 */
+(void)GETRecommandBankRequestWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}

/*
 * 我的会员列表
 */
+(void)GETMyMemberListRequestWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}

/*
 * 我的钱包POST
 */
+(void)zjPOSTMyBillRequestWithParams:(NSDictionary *)params result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/my/package"
                                          andParameters:params
                                              andIsJson:NO
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}

/*
 * 我的账单POST
 */
+(void)zjPOSTMyZhangDanRequestWithParams:(NSDictionary *)params result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/my/bill"
                                          andParameters:params
                                              andIsJson:YES
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}

/*
 * 意见反馈POST
 */
+(void)zjPOSTMyIdearRequestWithParams:(NSDictionary *)params result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/my/feedback"
                                          andParameters:params
                                              andIsJson:NO
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}



/*
 * 添加银行卡POST
 */
+ (void)zjaddBandCardWithParams:(NSMutableDictionary *)params result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/my/bank"
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
 * 更改手机号POST
 */
+ (void)zjChangeTelphoneNumberWithParams:(NSMutableDictionary *)params result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/my/changePhone"
                                          andParameters:params
                                              andIsJson:NO
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];

}

/*
 * 充值POST
 */
+ (void)zjPayMoneyPOSTWithParams:(NSMutableDictionary *)params result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/my/pay"
                                          andParameters:params
                                              andIsJson:NO
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
    
}

/*
 * 提现POST
 */
+ (void)zjGetMoneyPOSTWithParams:(NSMutableDictionary *)params result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/my/pay"
                                          andParameters:params
                                              andIsJson:NO
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
    
}

/*
 * 我的银行卡列表
 */
+(void)GETMyBankCardListRequestWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}

/*
 * 我的佣金
 */
+ (void)GETMyCommissRequestWithParams:(NSMutableDictionary *)params result:(result)result
{
    
    [[ZJDataRequest shareInstance]getDataWithURLString:@"api/my/my"
                                         andParameters:params
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}


@end
