//
//  ZJDebtMangerItem.m
//  债云端
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJDebtMangerItem.h"

@implementation ZJDebtMangerItem

@end
/**
 *  债事管理主界面cell的model
 */
@implementation ZJDebtMangerHomeItem

+ (ZJDebtMangerHomeItem *)itemForDictionary:(NSDictionary *)dic{
    
    ZJDebtMangerHomeItem *item = [[ZJDebtMangerHomeItem alloc] init];
    if ([dic objectForKey:@"amout"]) {
        item.debtamout=[NSString stringWithFormat:@"%@",[dic objectForKey:@"amout"]];
    }
    if ([dic objectForKey:@"createTime"]) {
        item.debtcreateTime=[NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]];
    }
    if ([dic objectForKey:@"from"]) {
        item.debtfromPerson=[NSString stringWithFormat:@"%@",[dic objectForKey:@"from"]];
    }
    if ([dic objectForKey:@"to"]) {
        item.debttoPeson=[NSString stringWithFormat:@"%@",[dic objectForKey:@"to"]];
    }
    if ([dic objectForKey:@"id"]) {
        item.debtdebtid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
    }
    if ([dic objectForKey:@"isSolution"]) {
        item.debtisSolution=[NSString stringWithFormat:@"%@",[dic objectForKey:@"isSolution"]];
    }
    if ([dic objectForKey:@"orderId"]) {
        item.debtorderid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"orderId"]];
    }
    if ([dic objectForKey:@"payStatus"]) {
        item.debtisPay=[NSString stringWithFormat:@"%@",[dic objectForKey:@"payStatus"]];
    }
    if ([dic objectForKey:@"otherPerson"]) {
        item.otherPerson=[NSString stringWithFormat:@"%@",[dic objectForKey:@"otherPerson"]];
    }
    
    

    return item;
}
@end
