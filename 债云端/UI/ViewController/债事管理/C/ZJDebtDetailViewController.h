//
//  ZJDebtDetailViewController.h
//  债云端
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBaseViewController.h"
typedef NS_ENUM(NSInteger, ZJDebtDetailType) {
    ZJDebtDetailTypeCommit = 1,//已提交
    ZJDebtDetailTypeStructure = 2,//统筹中
    ZJDebtDetailTypeStructureSucc = 3,//解债中
    ZJDebtDetailTypeSolve = 4,//已解债
};

@interface ZJDebtDetailViewController : ZJBaseViewController
@property (nonatomic, assign)ZJDebtDetailType Btntype;
@property (nonatomic, strong)NSString * DetailID;
@end
