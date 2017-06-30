//
//  ZJProtocolAlterView.h
//  债云端
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJProtocolAlterView;
@protocol ZJProtocolAlterDelegate <NSObject>

- (void)zjProtocolAlertClikButtonIndex:(NSInteger)index alert:(ZJProtocolAlterView *)alert;

@end
@interface ZJProtocolAlterView : UIView
- (id)initWithProtocoltype:(NSString *)type withTitle:(NSString *)title;
- (void)show;  //出现

- (void)dismiss;

@property (assign, nonatomic) id<ZJProtocolAlterDelegate> delegate;
@property (nonatomic,assign)BOOL isAgree;


@end
