//
//  UIImage+ColorAtPixel.h
//  ZhuoJiaRenWRF
//
//  Created by 徐海燕 on 15/8/27.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorAtPixel)

/**
 * 由图片位置取到颜色
 */
- (UIColor *)colorAtPixel:(CGPoint)point;

/**
 * 颜色生成图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color;
@end
