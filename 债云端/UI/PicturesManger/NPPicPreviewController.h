//
//  NPPicPreviewController.h
//  NaiPai
//
//  Created by xiaoqiang on 15/5/28.
//  Copyright (c) 2015年 NaiPai. All rights reserved.
//
#import "NPPicPreviewController.h"

@interface NPPicPreviewController : UIViewController

@property (nonatomic, strong) NSMutableArray *images;  //存放uiimage
@property (nonatomic, strong) NSMutableArray *urlimages;//存放imageurl地址
@property (nonatomic, unsafe_unretained) CGFloat offsetX;

@end
