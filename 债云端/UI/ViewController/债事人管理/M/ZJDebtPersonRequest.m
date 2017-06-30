//
//  ZJDebtPersonRequest.m
//  债云端
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJDebtPersonRequest.h"

@implementation ZJDebtPersonRequest
/*
 * 债事人管理列表
 */
+(void)GetDebtPersonManageListRequestWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}
/*
 * 债事人基本信息
 */
+(void)GetDebtPersonBaseInfomationRequestWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}
/*
 * 债事人资产信息，需求信息
 */
+(void)GetDebtPersonCapitalInfomationRequestWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}
/*
 * 债事人债事信息
 */
+(void)GetDebtPersondebtInfomationRequestWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}
/*
 * 添加债事人
 */
+(void)postAddDebtPersonInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/debt/adddebt"
                                          andParameters:parms
                                              andIsJson:YES
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}
/*
 * 新增资产
 */
+(void)postAddDebtPersonCapitalInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/asset"
                                          andParameters:parms
                                              andIsJson:YES
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}
/*
 * 编辑资产
 */
+(void)postEditDebtPersonCapitalInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/asset/update"
                                          andParameters:parms
                                              andIsJson:YES
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}
/*
 * 债事人资产详情
 */
+(void)GetDebtPersonCapitalDetailRequestWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}
/*
 * 删除资产
 */
+(void)postDeleteDebtPersonCapitalInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/asset/delete"
                                          andParameters:parms
                                              andIsJson:NO
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}
/*
 * 新增需求
 */
+(void)postAddDebtPersonDemandInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/demand/adddemand"
                                          andParameters:parms
                                              andIsJson:YES
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}
/*
 * 编辑需求
 */
+(void)postEditDebtPersonDemandInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/demand/updatedemand"
                                          andParameters:parms
                                              andIsJson:YES
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}
/*
 * 删除需求
 */
+(void)getDeleteDebtPersonDemandInfoRequestWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}
/*
 * 搜索债事人
 */
+(void)GetSearchDebtPersonRequestWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}
/*
 * 债事人股权列表信息
 */
+(void)GetDebtCompanyequityRequestWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}
/*
 * 新增股权
 */
+(void)postAddDebtCompanyStockInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/equity/adddemand"
                                          andParameters:parms
                                              andIsJson:YES
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}
/*
 * 删除股权
 */
+(void)postdeleteDebtCompanyStockInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/equity/deleteequity"
                                          andParameters:parms
                                              andIsJson:NO
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}
/*
 * 债事人经营列表信息
 */
+(void)GetDebtCompanyOperateRequestWithActions:(NSString *)action result:(result)result
{
    [[ZJDataRequest shareInstance]getDataWithURLString:action
                                         andParameters:nil
                                               timeOut:20
                                         requestSecret:YES
                                          resultSecret:YES
                                       resultWithBlock:result];
}
/*
 * 新增经营
 */
+(void)postAddDebtCompanyOperateInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/managestate/add"
                                          andParameters:parms
                                              andIsJson:YES
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}
/*
 * 删除经营
 */
+(void)postdeleteDebtCompanyOperateInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result
{
    [[ZJDataRequest shareInstance]postDataWithURLString:@"api/managestate/delete"
                                          andParameters:parms
                                              andIsJson:NO
                                                timeOut:20
                                          requestSecret:YES
                                           resultSecret:YES
                                        resultWithBlock:result];
}
@end
