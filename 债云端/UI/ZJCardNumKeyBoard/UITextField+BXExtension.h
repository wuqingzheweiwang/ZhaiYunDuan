//
//  UITextField+BXExtension.h
//  债云端
//
//  Created by 赵凯强 on 2017/7/11.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (BXExtension)
- (NSRange)selectedRange;
- (void)setSelectedRange:(NSRange) range;
@end
