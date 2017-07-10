//
//  ZJPayMoneyViewController.h
//  债云端
//
//  Created by 赵凯强 on 2017/5/5.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBaseViewController.h"

typedef NS_ENUM(NSInteger, ZJisBankManeger) {
    ZJisBankManegerYes = 1,//备案
    ZJisBankManegerNo = 2,//行长
};

@interface ZJPayMoneyViewController : ZJBaseViewController

@property (nonatomic , assign) ZJisBankManeger isManager;
@property (nonatomic , strong) NSString * orderid;
@property (nonatomic , strong) NSString * type;
@property (nonatomic , strong) NSString * payAmount;

@end
