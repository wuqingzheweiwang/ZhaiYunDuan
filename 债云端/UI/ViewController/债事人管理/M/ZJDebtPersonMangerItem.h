//
//  ZJDebtPersonMangerItem.h
//  债云端
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJDebtPersonMangerItem : NSObject

@end
/**
 *  债事人管理主界面cell的model
 */
@interface ZJDebtPersonMangerHomeItem : NSObject
@property (nonatomic, strong) NSString *deptType;
@property (nonatomic, strong) NSString *deptid;
@property (nonatomic, strong) NSString *deptidCode;
@property (nonatomic, strong) NSString *deptname;
+ (ZJDebtPersonMangerHomeItem *)itemForDictionary:(NSDictionary *)dic;
@end
/**
 *  债事人管理主界面 个人基本信息
 */
//@interface ZJDebtPersonBaseInfoItem : NSObject
//@property (nonatomic, strong) NSString *infotext;
//@property (nonatomic, strong) NSString *infotype;
//+ (ZJDebtPersonBaseInfoItem *)itemForDictionary:(NSDictionary *)dic;
//@end
/**
 *  债事人管理主界面 个人资产信息
 */
@interface ZJCapitalInfoItem : NSObject
@property (nonatomic, strong) NSString * assetNum;
@property (nonatomic, strong) NSString * capitalid;
@property (nonatomic, strong) NSString * totalAmout;
@property (nonatomic, strong) NSString * capitalname;
@property (nonatomic, strong) NSString * tradeableAssets;
+ (ZJCapitalInfoItem *)itemForDictionary:(NSDictionary *)dic;
@end
/**
 *  债事人管理主界面 个人需求信息
 */
@interface ZJDemandInfoItem : NSObject
@property (nonatomic, strong) NSString * demandNum;
@property (nonatomic, strong) NSString * demandid;
@property (nonatomic, strong) NSString * totalAmout;
@property (nonatomic, strong) NSString * demandname;
@property (nonatomic, strong) NSString * tangible;
+ (ZJDemandInfoItem *)itemForDictionary:(NSDictionary *)dic;
@end
/**
 *  债事人管理主界面 股权信息
 */
@interface ZJStockInfoItem : NSObject
@property (nonatomic, strong) NSString * stockid;
@property (nonatomic, strong) NSString * shareholderName;
@property (nonatomic, strong) NSString * shareholderCode;
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * amount;
@property (nonatomic, strong) NSString * proportion;
@property (nonatomic, strong) NSString * registeredCapital;
@property (nonatomic, strong) NSString * actualCapital;
+ (ZJStockInfoItem *)itemForDictionary:(NSDictionary *)dic;
@end
/**
 *  债事人管理主界面 经营信息
 */
@interface ZJOperateInfoItem : NSObject
@property (nonatomic, strong) NSString * operateid;
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * gross;
@property (nonatomic, strong) NSString * lastElectricityBills;
@property (nonatomic, strong) NSString * legalPersonName;
@property (nonatomic, strong) NSString * lastSales;
@property (nonatomic, strong) NSString * phoneNumber;
@property (nonatomic, strong) NSString * profitMargin;
@property (nonatomic, strong) NSString * taxNumber;
@property (nonatomic, strong) NSString * totalInvestment;
@property (nonatomic, strong) NSString * year;
+ (ZJOperateInfoItem *)itemForDictionary:(NSDictionary *)dic;
@end
/**
 *  债事人管理主界面 新增需求信息
 */
@interface ZJAddDemandInfoItem : NSObject
+ (ZJAddDemandInfoItem *)itemForDictionary:(NSDictionary *)dic;
@end
