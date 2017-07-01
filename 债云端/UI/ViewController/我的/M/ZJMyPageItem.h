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
 *  推荐行长主界面cell的model
 */
@interface ZJRecomBankHomeItem : NSObject
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *type;

+ (ZJRecomBankHomeItem *)itemForDictionary:(NSDictionary *)dic;

@end


/**
 *  我的会员主界面cell的model
 */
@interface ZJReMyMemberHomeItem : NSObject
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *phoneNumber;

+ (ZJReMyMemberHomeItem *)itemForDictionary:(NSDictionary *)dic;

@end




