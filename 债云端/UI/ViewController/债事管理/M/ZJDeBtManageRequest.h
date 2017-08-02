//
//  ZJDeBtManageRequest.h
//  债云端
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJDataRequest.h"
typedef void(^result)(BOOL success, id responseData);
@interface ZJDeBtManageRequest : NSObject
/*
 *查询债务人
 */
+ (void)GetsearchDebtPersonWithActions:(NSString *)action result:(result)result;
/*
 * 债事管理列表
 */
+(void)GetDebtManageListRequestWithActions:(NSString *)action result:(result)result;
/*
 * 债事备案
 */
+(void)postAddDebtInfoRequestWithParms:(NSMutableDictionary *)parms result:(result)result;
/*
 * 债事详情
 */
+(void)GetDebtManageDetailInfoRequestWithActions:(NSString *)action result:(result)result;
/*
 *债事搜索
 */
+(void)zjGetSearchDebtRequestWithActions:(NSString *)action result:(result)result;
@end
