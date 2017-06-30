//
//  ZJMyPageItem.h
//  债云端
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJMyPageItem : NSObject


@end

/**
 *  债事人管理主界面cell的model
 */
@interface ZJMyMemberHomeItem : NSObject
@property (nonatomic, strong) NSString *deptid;
@property (nonatomic, strong) NSString *deptidCode;
@property (nonatomic, strong) NSString *deptname;
+ (ZJMyMemberHomeItem *)itemForDictionary:(NSDictionary *)dic;

@end

/**
 *  推荐行长主界面cell的model
 */
@interface ZJRecomBankHomeItem : NSObject
@property (nonatomic, strong) NSString *deptid;
@property (nonatomic, strong) NSString *deptidCode;
@property (nonatomic, strong) NSString *deptname;
+ (ZJRecomBankHomeItem *)itemForDictionary:(NSDictionary *)dic;

@end

