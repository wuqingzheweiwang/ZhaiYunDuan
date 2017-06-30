//
//  ZJShareAlertView.h
//  债云端
//
//  Created by 赵凯强 on 2017/6/24.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJShareAlertView;
@protocol ZJShareAlterViewDelegate <NSObject>

- (void)zjProtocolAlertClikButtonIndex:(NSInteger)index alert:(ZJShareAlertView *)alert;

@end
@interface ZJShareAlertView : UIView

@property (assign, nonatomic) id<ZJShareAlterViewDelegate> delegate;

- (id)initWithHeaderImage:(NSURL *)imageUrl withPersonName:(NSString *)name withCommandCode:(NSString *)recommandecode withQRUrl:(NSURL *)QRurl;
- (void)show; 

- (void)dismiss;


@end
