//
//  ZJDebtMangerViewController.h
//  债云端
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBaseViewController.h"
typedef NS_ENUM(NSInteger, ZJDebtMangerType) {
    ZJDebtMangerUnsolved = 1,//未解决
    ZJDebtMangerResolved = 2,//已解决
};
@interface ZJDebtMangerViewController : UIViewController
@property (nonatomic, assign)ZJDebtMangerType Btntype;
@end
