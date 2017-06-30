//
//  ZJMyPageItem.m
//  债云端
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJMyPageItem.h"

@implementation ZJMyPageItem


@end
@implementation ZJMyMemberHomeItem

+ (ZJMyMemberHomeItem *)itemForDictionary:(NSDictionary *)dic{
    
    
    ZJMyMemberHomeItem *item = [[ZJMyMemberHomeItem alloc] init];
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

@implementation ZJRecomBankHomeItem

+ (ZJRecomBankHomeItem *)itemForDictionary:(NSDictionary *)dic{
    
    
    ZJRecomBankHomeItem *item = [[ZJRecomBankHomeItem alloc] init];
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
