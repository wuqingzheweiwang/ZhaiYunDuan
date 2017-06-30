//
//  ZJAddDebtPersonController.h
//  债云端
//
//  Created by 赵凯强 on 2017/4/23.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBaseViewController.h"
typedef NS_ENUM(NSInteger, ZJDebtPersonType) {
    ZJDebtPersonCompany = 1,//债事企业
    ZJDebtPersonPerson = 2,//债事自然人
};
@interface ZJAddDebtPersonController : ZJBaseViewController
@property (nonatomic, assign)ZJDebtPersonType Btntype;
@property (nonatomic, strong)NSString * DebtPersonNumString;
@property (nonatomic, strong)NSString * formwhere;//从哪里进来的
@property (nonatomic, strong)NSString * isOwer;//是不是备自己的债事人
@end
