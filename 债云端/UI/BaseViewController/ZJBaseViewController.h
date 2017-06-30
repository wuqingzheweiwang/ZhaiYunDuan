//
//  ZJBaseViewController.h
//  债云端
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJBaseViewController : UIViewController

@property (nonatomic,assign)BOOL isPushPresent;
- (void)showProgress;
- (void)dismissProgress;

@end
