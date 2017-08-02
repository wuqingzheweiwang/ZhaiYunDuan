//
//  ZJDeBtManageRequest.m
//  债云端
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJDeBtManageRequest.h"

@implementation ZJDeBtManageRequest

/*
 *查询债务人
 */
+ (void)GetsearchDebtPersonWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}
/*
 * 债事管理列表
 */
+(void)GetDebtManageListRequestWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}
/*
 * 债事备案
 */
+(void)postAddDebtInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/debtrelation/adddebtrelation/relation"
                                          andParameters:parms
                                              andIsJson:YES
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}
/*
 * 债事详情
 */
+(void)GetDebtManageDetailInfoRequestWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}
/*
 *债事搜索
 */
+(void)zjGetSearchDebtRequestWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}
@end
