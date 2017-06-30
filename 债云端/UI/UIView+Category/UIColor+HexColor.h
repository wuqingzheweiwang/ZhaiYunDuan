//
//  UIColor+HexColor.h
//  NaPai
//
//  Created by 徐海燕 on 15/12/1.
//  Copyright © 2015年 NP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

+ (UIColor *)colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

@end
