//
//  LMWebProgressLayer.h
//  LMWebViewLoadProgress
//
//  Created by limin on 17/1/16.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface LMWebProgressLayer : CAShapeLayer
- (void)finishedLoad;
- (void)startLoad;

- (void)closeTimer;
@end
