//
//  UIView+BXExtension.h
//  债云端
//
//  Created by 赵凯强 on 2017/7/11.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZJCardExtension)
/// 查找子视图且不会保存
///
/// @param view      要查找的视图
/// @param clazzName 子控件类名
///
/// @return 找到的第一个子视图
+ (UIView *)ff_foundViewInView:(UIView *)view clazzName:(NSString *)clazzName;
@end
