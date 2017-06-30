//
//  ZJCapitalAndDemandInfoDetailViewController.h
//  债云端
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBaseViewController.h"
typedef NS_ENUM(NSInteger, ZJCapitalAndDemandType) {
    ZJCapitalAndDemandTypeCapital = 1,//资产
    ZJCapitalAndDemandTypeDemand = 2,//需求
};
@interface ZJCapitalAndDemandInfoDetailViewController : ZJBaseViewController
@property (nonatomic, assign)ZJCapitalAndDemandType Btntype;
@property (nonatomic, strong)NSString * capitalID;
@end
