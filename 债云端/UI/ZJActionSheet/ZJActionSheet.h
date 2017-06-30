//
//  ZJActionSheet.h
//
//
//  Created by 赵凯强 on 17/5/04.
//  Copyright © 2017年  All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJActionSheet;
@protocol ZJActionSheetAlterDelegate <NSObject>

- (void)ZJActionSheetAlertClikButtonIndex:(NSInteger)index alert:(ZJActionSheet *)alert;//选择银行卡的代理

- (void)ZJActionSheetFootviewClikButtonIndex:(NSInteger)index alert:(ZJActionSheet *)alert;//footview的代理

@end
typedef enum {
    ZJActionSheetStyleDefault, // 正常字体样式
    ZJActionSheettyleCancel,  // 粗体字样式
    ZJActionSheetStyleDestructive // 红色字体样式
} ZJActionSheetStyle;


@interface ZJActionSheet : UIView
@property (nonatomic, strong) UIView *shadowView;

/**
 *  设置代理
 */
@property (nonatomic, weak) id<ZJActionSheetAlterDelegate> delegate;
/**
 *  初始化方法
 *
 *  @param title    提示内容
 *  @param confirms 选项标题数组
 *  @param cancel   取消按钮标题
 *  @param style    显示样式
 *
 *  @return         actionSheet
 */
+ (ZJActionSheet *)actionSheetWithTitle:(NSString *)title confirms:(NSMutableArray *)confirms cancel:(NSString *)cancel withType:(NSString *)ytpe style:(ZJActionSheetStyle)style;
/**
 *  显示方法
 *
 *  @param obj UIView或者UIWindow类型
 */
- (void)showInView:(id)obj;
@end
