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

@implementation ZJRecomBankHomeItem

+ (ZJRecomBankHomeItem *)itemForDictionary:(NSDictionary *)dic{
    
    ZJRecomBankHomeItem *item = [[ZJRecomBankHomeItem alloc] init];
    if ([dic objectForKey:@"name"]) {
        item.realName=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    }
    if ([dic objectForKey:@"phonenumber"]) {
        item.phoneNumber=[NSString stringWithFormat:@"%@",[dic objectForKey:@"phonenumber"]];
    }
    if ([dic objectForKey:@"address"]) {
        item.address=[NSString stringWithFormat:@"%@",[dic objectForKey:@"address"]];
    }
    if ([dic objectForKey:@"type"]) {

       NSString *type =[NSString stringWithFormat:@"%@",[dic objectForKey:@"type"]];
        if ([type isEqualToString:@"1"]) {
            item.type = @"总公司";
        }
        else if ([type isEqualToString:@"2"]) {
            item.type = @"省公司代表";
        }
        else if ([type isEqualToString:@"3"]) {
            item.type = @"市公司代表";
        }
        else if ([type isEqualToString:@"4"]) {
            item.type = @"服务行代表";
        }
        else if ([type isEqualToString:@"5"]) {
            item.type = @"拓展行";
        }
        else if ([type isEqualToString:@"6"]) {
            item.type = @"云债行";
        }
    }
    
    return item;
}

@end


@implementation ZJReMyMemberHomeItem

+ (ZJReMyMemberHomeItem *)itemForDictionary:(NSDictionary *)dic{
    
    
    ZJReMyMemberHomeItem *item = [[ZJReMyMemberHomeItem alloc] init];
    if ([dic objectForKey:@"name"]) {
        item.realName=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    }
    if ([dic objectForKey:@"phonenumber"]) {
        item.phoneNumber=[NSString stringWithFormat:@"%@",[dic objectForKey:@"phonenumber"]];
    }
    
    return item;
}


@end

@implementation ZJMyZhangDanHomeItem

+ (ZJMyZhangDanHomeItem *)itemForDictionary:(NSDictionary *)dic{
    
    
    ZJMyZhangDanHomeItem *item = [[ZJMyZhangDanHomeItem alloc] init];
    if ([dic objectForKey:@"name"]) {
        item.amount=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    }
    if ([dic objectForKey:@"phonenumber"]) {
        item.phoneNumber=[NSString stringWithFormat:@"%@",[dic objectForKey:@"phonenumber"]];
    }
    
    return item;
}


@end




