//
//  ZJAddEditDemandViewController.h
//  债云端
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBaseViewController.h"
typedef NS_ENUM(NSInteger, ZJDemandType) {
    ZJDemandAdd = 1,//新增
    ZJDemandEdit = 2,//编辑
};

@interface ZJAddEditDemandViewController : ZJBaseViewController
@property (nonatomic, assign)ZJDemandType Btntype;
@property (nonatomic, strong)NSString * personId;   //债事人的id
@property (nonatomic, strong)NSString * demandId;  //需求的id

@property (nonatomic, copy) void (^block)(NSString *);//为了返回刷新
@end
