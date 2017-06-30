//
//  ZJAddStockInfoViewController.h
//  债云端
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBaseViewController.h"

@interface ZJAddStockInfoViewController : ZJBaseViewController
@property (nonatomic, strong)NSString * companyId;
@property (nonatomic, copy) void (^block)(NSString *);//为了返回刷新
@end
