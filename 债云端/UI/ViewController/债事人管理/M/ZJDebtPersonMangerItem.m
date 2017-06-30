//
//  ZJDebtPersonMangerItem.m
//  债云端
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJDebtPersonMangerItem.h"

@implementation ZJDebtPersonMangerItem

@end
/**
 *  债事人管理主界面cell的model
 */
@implementation ZJDebtPersonMangerHomeItem

+ (ZJDebtPersonMangerHomeItem *)itemForDictionary:(NSDictionary *)dic{
    
    
    ZJDebtPersonMangerHomeItem *item = [[ZJDebtPersonMangerHomeItem alloc] init];
    if ([dic objectForKey:@"type"]) {
        if ([[dic objectForKey:@"type"]isEqualToString:@"company"]) {
            item.deptType=@"企业";
        }
        if ([[dic objectForKey:@"type"]isEqualToString:@"human"]) {
            item.deptType=@"自然人";
        }
    }
    if ([dic objectForKey:@"id"]) {
        item.deptid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
    }
    if ([dic objectForKey:@"idCode"]) {
        item.deptidCode=[NSString stringWithFormat:@"%@",[dic objectForKey:@"idCode"]];
    }
    if ([dic objectForKey:@"name"]) {
        item.deptname=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    }
    return item;
}
@end
/**
 *  债事人管理主界面 个人基本信息
 */
//@implementation ZJDebtPersonBaseInfoItem
//
//+ (ZJDebtPersonBaseInfoItem *)itemForDictionary:(NSDictionary *)dic{
//    
//    ZJDebtPersonBaseInfoItem *item = [[ZJDebtPersonBaseInfoItem alloc] init];
//    
//    return item;
//}
//@end
/**
 *  债事人管理主界面  个人资产信息
 */
@implementation ZJCapitalInfoItem

+ (ZJCapitalInfoItem *)itemForDictionary:(NSDictionary *)dic{
    
    ZJCapitalInfoItem *item = [[ZJCapitalInfoItem alloc] init];
    if ([dic objectForKey:@"id"]) {
        item.capitalid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
    }
    if ([dic objectForKey:@"assetNum"]) {
        item.assetNum=[NSString stringWithFormat:@"%@",[dic objectForKey:@"assetNum"]];
    }
    if ([dic objectForKey:@"name"]) {
        item.capitalname=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    }
    if ([dic objectForKey:@"totalAmout"]) {
        item.totalAmout=[NSString stringWithFormat:@"%@",[dic objectForKey:@"totalAmout"]];
    }
    if ([dic objectForKey:@"tradeableAssets"]) {
        item.tradeableAssets=[NSString stringWithFormat:@"%@",[dic objectForKey:@"tradeableAssets"]];
    }
    return item;
}
@end
/**
 *  债事人管理主界面  个人需求信息
 */
@implementation ZJDemandInfoItem

+ (ZJDemandInfoItem *)itemForDictionary:(NSDictionary *)dic{
    
    ZJDemandInfoItem *item = [[ZJDemandInfoItem alloc] init];
    if ([dic objectForKey:@"id"]) {
        item.demandid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
    }
    if ([dic objectForKey:@"assetNum"]) {
        item.demandNum=[NSString stringWithFormat:@"%@",[dic objectForKey:@"assetNum"]];
    }
    if ([dic objectForKey:@"name"]) {
        item.demandname=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    }
    if ([dic objectForKey:@"totalAmout"]) {
        item.totalAmout=[NSString stringWithFormat:@"%@",[dic objectForKey:@"totalAmout"]];
    }
    if ([dic objectForKey:@"tangible"]) {
        item.tangible=[NSString stringWithFormat:@"%@",[dic objectForKey:@"tangible"]];
    }
    return item;
}
@end
/**
 *  债事人管理主界面  股权信息
 */
@implementation ZJStockInfoItem

+ (ZJStockInfoItem *)itemForDictionary:(NSDictionary *)dic{
    
    ZJStockInfoItem *item = [[ZJStockInfoItem alloc] init];
    if ([dic objectForKey:@"id"]) {
        item.stockid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
    }
    if ([dic objectForKey:@"shareholderName"]) {
        item.shareholderName=[NSString stringWithFormat:@"%@",[dic objectForKey:@"shareholderName"]];
    }
    if ([dic objectForKey:@"shareholderCode"]) {
        item.shareholderCode=[NSString stringWithFormat:@"%@",[dic objectForKey:@"shareholderCode"]];
    }
    if ([dic objectForKey:@"address"]) {
        item.address=[NSString stringWithFormat:@"%@",[dic objectForKey:@"address"]];
    }
    if ([dic objectForKey:@"amount"]) {
        item.amount=[NSString stringWithFormat:@"%@",[dic objectForKey:@"amount"]];
    }
    if ([dic objectForKey:@"proportion"]) {
        item.proportion=[NSString stringWithFormat:@"%@",[dic objectForKey:@"proportion"]];
    }
    if ([dic objectForKey:@"registeredCapital"]) {
        item.registeredCapital=[NSString stringWithFormat:@"%@",[dic objectForKey:@"registeredCapital"]];
    }
    if ([dic objectForKey:@"actualCapital"]) {
        item.actualCapital=[NSString stringWithFormat:@"%@",[dic objectForKey:@"actualCapital"]];
    }
    return item;
}
@end
/**
 *  债事人管理主界面  经营信息
 */
@implementation ZJOperateInfoItem

+ (ZJOperateInfoItem *)itemForDictionary:(NSDictionary *)dic{
    
    
    ZJOperateInfoItem *item = [[ZJOperateInfoItem alloc] init];
    if ([dic objectForKey:@"id"]) {
        item.operateid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
    }
    if ([dic objectForKey:@"gross"]) {
        item.gross=[NSString stringWithFormat:@"%@",[dic objectForKey:@"gross"]];
    }
    if ([dic objectForKey:@"lastElectricityBills"]) {
        item.lastElectricityBills=[NSString stringWithFormat:@"%@",[dic objectForKey:@"lastElectricityBills"]];
    }
    if ([dic objectForKey:@"address"]) {
        item.address=[NSString stringWithFormat:@"%@",[dic objectForKey:@"address"]];
    }
    if ([dic objectForKey:@"lastSales"]) {
        item.lastSales=[NSString stringWithFormat:@"%@",[dic objectForKey:@"lastSales"]];
    }
    if ([dic objectForKey:@"legalPersonName"]) {
        item.legalPersonName=[NSString stringWithFormat:@"%@",[dic objectForKey:@"legalPersonName"]];
    }
    if ([dic objectForKey:@"phoneNumber"]) {
        item.phoneNumber=[NSString stringWithFormat:@"%@",[dic objectForKey:@"phoneNumber"]];
    }
    if ([dic objectForKey:@"profitMargin"]) {
        item.profitMargin=[NSString stringWithFormat:@"%@%@",[dic objectForKey:@"profitMargin"],@"%"];
    }
    if ([dic objectForKey:@"taxNumber"]) {
        item.taxNumber=[NSString stringWithFormat:@"%@",[dic objectForKey:@"taxNumber"]];
    }
    if ([dic objectForKey:@"totalInvestment"]) {
        item.totalInvestment=[NSString stringWithFormat:@"%@",[dic objectForKey:@"totalInvestment"]];
    }
    if ([dic objectForKey:@"year"]) {
        item.year=[NSString stringWithFormat:@"%@",[dic objectForKey:@"year"]];
    }
    return item;
}
@end
/**
 *  债事人管理主界面  新增需求信息
 */
@implementation ZJAddDemandInfoItem

+ (ZJAddDemandInfoItem *)itemForDictionary:(NSDictionary *)dic{
    
    
    ZJAddDemandInfoItem *item = [[ZJAddDemandInfoItem alloc] init];
    
    return item;
}
@end
