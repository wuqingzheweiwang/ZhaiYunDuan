//
//  ZJAddDebtInformationViewController.h
//  债云端
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBaseViewController.h"
typedef NS_ENUM(NSInteger, ZJDebtRecordType) {
    ZJDebtRecordTypeVip = 1,//行长
    ZJDebtRecordTypeNoVip = 2,//普通用户
};
@interface ZJAddDebtInformationViewController : ZJBaseViewController
@property (nonatomic, assign)ZJDebtRecordType Btntype;
@end
