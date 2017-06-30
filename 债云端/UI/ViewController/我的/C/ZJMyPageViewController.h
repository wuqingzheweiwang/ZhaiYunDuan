//
//  ZJMyPageViewController.h
//  债云端
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBaseViewController.h"

@interface ZJMyPageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;
@property (weak, nonatomic) IBOutlet UIImageView *isVIPImageView;
@property (weak, nonatomic) IBOutlet UILabel *isVIPLabel;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *QRcodeView;
@property (weak, nonatomic) IBOutlet UIButton *onQRcodeBut;

@end
