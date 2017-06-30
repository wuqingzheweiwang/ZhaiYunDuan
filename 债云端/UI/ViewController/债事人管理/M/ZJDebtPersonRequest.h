//
//  ZJDebtPersonRequest.h
//  债云端
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJDataRequest.h"
typedef void(^result)(BOOL success, id responseData);
@interface ZJDebtPersonRequest : NSObject
/*
 * 债事人管理列表
 */
+(void)GetDebtPersonManageListRequestWithActions:(NSString *)action result:(result)result;
/*
 * 债事人基本信息
 */
+(void)GetDebtPersonBaseInfomationRequestWithActions:(NSString *)action result:(result)result;
/*
 * 债事人资产信息，需求信息
 */
+(void)GetDebtPersonCapitalInfomationRequestWithActions:(NSString *)action result:(result)result;
/*
 * 债事人债事信息
 */
+(void)GetDebtPersondebtInfomationRequestWithActions:(NSString *)action result:(result)result;
/*
 * 添加债事人
 */
+(void)postAddDebtPersonInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result;
/*
 * 新增资产
 */
+(void)postAddDebtPersonCapitalInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result;
/*
 * 编辑资产
 */
+(void)postEditDebtPersonCapitalInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result;
/*
 * 删除资产
 */
+(void)postDeleteDebtPersonCapitalInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result;
/*
 * 债事人资产详情
 */
+(void)GetDebtPersonCapitalDetailRequestWithActions:(NSString *)action result:(result)result;

/*
 * 新增需求
 */
+(void)postAddDebtPersonDemandInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result;
/*
 * 编辑需求
 */
+(void)postEditDebtPersonDemandInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result;
/*
 * 删除需求
 */
+(void)getDeleteDebtPersonDemandInfoRequestWithActions:(NSString *)action result:(result)result;
/*
 * 搜索债事人债事人
 */
+(void)GetSearchDebtPersonRequestWithActions:(NSString *)action result:(result)result;
/*
 * 债事人股权列表信息
 */
+(void)GetDebtCompanyequityRequestWithActions:(NSString *)action result:(result)result;
/*
 * 新增股权
 */
+(void)postAddDebtCompanyStockInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result;
/*
 * 删除股权
 */
+(void)postdeleteDebtCompanyStockInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result;
/*
 * 债事人经营列表信息
 */
+(void)GetDebtCompanyOperateRequestWithActions:(NSString *)action result:(result)result;
/*
 * 新增经营
 */
+(void)postAddDebtCompanyOperateInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result;
/*
 * 删除经营
 */
+(void)postdeleteDebtCompanyOperateInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result;
@end
