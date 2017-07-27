//
//  ZJHomeRequest.m
//  债云端
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJHomeRequest.h"

@implementation ZJHomeRequest

/*
 * 首页
 */
+(void)zjGetHomeRequestWithParams:(NSDictionary *)params result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:@"/api/news/getFirstNews"
                                         andParameters:params
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
    
}

/*
 * 更多新闻
 */
+(void)zjGetHomeNewsRequestWithParams:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
    
}

/*
 * 开通债行POST
 */
+(void)zjPOSTDebtRequestWithParams:(NSDictionary *)params result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/opendebt"
                                         andParameters:params
                                             andIsJson:YES
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}

/*
 * 开通债行GET 地区三级联动
 */
+(void)zjGETDebtAddressRequestWithParams:(NSDictionary *)params result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:@"api/address"
                                         andParameters:params
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}

/*
 *支付宝支付
 */
+(void)zjPostAlipayDebtRequestWithParams:(NSDictionary *)params result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"/api/alipay/pay/createpay"
                                         andParameters:params
                                             andIsJson:NO
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}
/*
 * 获取用户角色
 */
+(void)zjGetUserRoleRequestresult:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:@"/api/provide"
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}

/*
 * 更新版本
 */
+(void)zjgetAppapiVersionresult:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:@"api/version/getVersion?type=iOS"
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
    
}
/*
 *微信支付
 */
+(void)zjPostWeiXinDebtRequestWithParams:(NSDictionary *)params result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/pay/toPay"
                                          andParameters:params
                                              andIsJson:NO
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}

/*
 *商学院
 */
+(void)zjGetBussinessSchoolRequestWithActions:(NSString *)action result:(result)result

{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
    
}

/*
 *视频课程
 */
+(void)zjGetBussinessClassRequestWithActions:(NSString *)action result:(result)result

{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
    
}

/*
 *图文课程
 */
+(void)zjGetImageandTextRequestWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}

/*
 *视频详情
 */
+(void)zjGetVideoContentWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}

/*
 *视频搜索
 */
+(void)zjGetSearchVideoRequestWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}


@end
