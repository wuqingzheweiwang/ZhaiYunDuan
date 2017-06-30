//
//  ANAlert.h
//  AssessUploading
//
//  Created by napai on 15/6/22.
//  Copyright (c) 2015年 napai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANAlert : NSObject<UIAlertViewDelegate>
/**
 *   只能在控制器里调用此方法
 */
+ (void)showAlertWithString:(NSString *)string andTarget:(UIViewController *)target;


@end
