//
//  ZJDebtMangerItem.h
//  债云端
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJDebtMangerItem : NSObject

@end
/**
 *  债事管理主界面cell的model
 */
@interface ZJDebtMangerHomeItem : NSObject

@property (nonatomic, strong) NSString *debtcreateTime;
@property (nonatomic, strong) NSString *debtfromPerson;
@property (nonatomic, strong) NSString *debttoPeson;
@property (nonatomic, strong) NSString *debtamout;
@property (nonatomic, assign) NSString *debtisSolution;
@property (nonatomic, assign) NSString *debtisPay;
@property (nonatomic, strong) NSString *debtdebtid;
@property (nonatomic, strong) NSString *debtorderid;
@property (nonatomic, strong) NSString *otherPerson;
@property (nonatomic, strong) NSString *qianshu;

+ (ZJDebtMangerHomeItem *)itemForDictionary:(NSDictionary *)dic;
@end
