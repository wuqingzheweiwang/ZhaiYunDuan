//
//  ZJAddEditCapitalViewController.h
//  债云端
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBaseViewController.h"
typedef NS_ENUM(NSInteger, ZJCapitalType) {
    ZJCapitalAdd = 1,//新增
    ZJCapitalEdit = 2,//编辑
};
@interface ZJAddEditCapitalViewController : ZJBaseViewController
@property (nonatomic, assign)ZJCapitalType Btntype;
@property (nonatomic, strong)NSString * personId;
@property (nonatomic, strong)NSString * companyId;
@property (nonatomic, strong)NSString * capitalId;
@end
