//
//  CityModelData.h
//  ProvinceAndCityAndTown
//
//  Created by Jivan on 16/12/27.
//  Copyright © 2016年 Jivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@class Province,City,District;

@interface CityModelData : NSObject
/**
 *  省份模型数组
 */
@property (nonatomic, strong) NSArray<Province *> *data;

@end
@interface Province : NSObject
/**
 *  省份名字
 */
@property (nonatomic, copy) NSString *value;
/**
 *  省ID
 */
@property (nonatomic, copy) NSString *ID;

/**
 *  城市模型数组
 */
@property (nonatomic, strong) NSArray<City *> *child;


@end

@interface City : NSObject
/**
 *  城市名字
 */
@property (nonatomic, copy) NSString *value;
/**
 *  市ID
 */
@property (nonatomic, copy) NSString *ID;

/**
 *  县级模型数组
 */
@property (nonatomic, strong) NSArray<District *> *child;

@end

@interface District : NSObject
/**
 *  县级名字
 */
@property (nonatomic, copy) NSString *value;
/**
 *  县ID
 */
@property (nonatomic, copy) NSString *ID;


@end


