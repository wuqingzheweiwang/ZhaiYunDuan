//
//  ZJHomeRequest.h
//  债云端
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJDataRequest.h"
typedef void(^result)(BOOL success, id responseData);
@interface ZJHomeRequest : NSObject

/*
 * 首页
 */
+(void)zjGetHomeRequestWithParams:(NSDictionary *)params result:(result)result;
/*
 * 更多新闻
 */
+(void)zjGetHomeNewsRequestWithParams:(NSString *)action result:(result)result;

/*
 *开通债行GET
 */
+(void)zjPOSTDebtRequestWithParams:(NSDictionary *)params result:(result)result;
/*
 *开通债行GET 地区三级联动
 */
+(void)zjGETDebtAddressRequestWithParams:(NSDictionary *)params result:(result)result;

/*
 *微信支付
 */
+(void)zjPostWeiXinDebtRequestWithParams:(NSDictionary *)params result:(result)result;

/*
 *支付宝支付
 */
+(void)zjPostAlipayDebtRequestWithParams:(NSDictionary *)params result:(result)result;

/*
 * 获取用户角色
 */
+(void)zjGetUserRoleRequestresult:(result)result;
/*
 * 更新版本
 */
+(void)zjgetAppapiVersionresult:(result)result;

/*
 *商学院
 */
+(void)zjGetBussinessSchoolRequestWithActions:(NSString *)action result:(result)result;
/*
 *视频课程
 */
+(void)zjGetBussinessClassRequestWithActions:(NSString *)action result:(result)result;
/*
 *图文课程
 */
+(void)zjGetImageandTextRequestWithActions:(NSString *)action result:(result)result;
/*
 *视频详情
 */
+(void)zjGetVideoContentWithActions:(NSString *)action result:(result)result;
@end
