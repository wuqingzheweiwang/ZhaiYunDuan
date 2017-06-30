//
//  CityModelData.m
//  ProvinceAndCityAndTown
//
//  Created by Jivan on 16/12/27.
//  Copyright © 2016年 Jivan. All rights reserved.
//

#import "CityModelData.h"

@implementation CityModelData


+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data" : [Province class]};
}


@end
@implementation Province

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"sonAddressList" : [City class]};
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}
@end


@implementation City

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"sonAddressList" : [District class]};
    
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}

@end


@implementation District

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}

@end
