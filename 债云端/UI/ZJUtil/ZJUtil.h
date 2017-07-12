//
//  ZJUtil.h
//  债云端
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^finish)(NSString * userid);
@interface ZJUtil : NSObject
/**
 *  计算string的宽度 - 单行
 *
 *  @param string string
 *  @param font   字体大小
 *
 *  @return CGSize
 */
+ (CGSize)calculateSingleStringSizeWithString:(NSString *)string andFont:(UIFont *)font;

/**
 *  计算string的宽度和高度  - 多行
 *
 *  @param string  string
 *
 *  @param size    CGSize
 *
 *  @return CGSize
 */
+ (CGSize)calculateStringSizeWithString:(NSString *)string andFont:(UIFont *)font andSize:(CGSize)size;

+ (NSString *)removeLineFormString:(NSString *)string;
/**
 *  设置多行Label的行间距
 *
 *  @param label   <#label description#>
 *  @param content <#content description#>
 *  @param size    <#size description#>
 *  @param font    <#font description#>
 *  @param frame   <#frame description#>
 */
+ (void)getLabelLineWithLabel:(UILabel *)label andContent:(NSString *)content andSize:(CGSize)size andLabelFont:(UIFont *)font andFrame:(CGRect)frame;

#pragma mark-- 清除缓存
+ (NSString *)LibraryDirectory;
+ (NSString *)DocumentDirectory;
+ (NSString *)PreferencePanesDirectory;
+ (NSString *)CachesDirectory;
// 按路径清除文件
+ (void)clearCachesWithFilePath:(NSString *)path;
+ (double)sizeWithFilePaht:(NSString *)path;

+ (NSString *)removeSpaceAndNewline:(NSString *)str;


//压缩图片质量
+ (UIImage *)reduceImage:(UIImage *)image percent:(float)percent;
//压缩图片尺寸
+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
//上传标准图片
+ (UIImage *)uploadStandardImage:(UIImage *)image;


/**
 *  计算带有换行的字符串
 *
 *  @param text 文本
 *  @param font 文本字样
 *  @param size 容器尺寸
 */
+ (CGSize)sizeForNoticeTitle:(NSString*)text font:(UIFont*)font size:(CGSize)size;

/**
 *  网页包含的敏感字符串 相对应的项分类id
 *
 *  @param webURL      网络路径
 *
 *  @param importSting 敏感字符串
 *
 *  @return 分类id
 */
+ (NSString *)somethingID:(NSString *)webURL importing:(NSString *)importSting;

//判断是否全是空格
+ (BOOL)isKGEmpty:(NSString *) str;
// 判断登录
+(BOOL)getUserLogin;
//退出
+ (void)logout;
// 需要时调用(遍历字体)
+(void)forinAllFont;
// 判断是否为债行
+(BOOL)getUserIsDebtBank;
// 判断是否为会员
+(BOOL)getUserIsDebtVip;
/*
 * 菊花+提示框相关
 */
+(void)showBottomToastWithMsg:(NSString *)msg;

/*
 * 1、手机号相关
 */
+ (BOOL)isMobileNo:(NSString *)accountName;
// 2、身份证
+ (BOOL)isIDCard:(NSString *)idCard;
//
+ (BOOL)isEmptyStr:(NSString*)str;
// 3、邮箱
+ (BOOL) IsEmailAdress:(NSString *)Email;
// 4、银行卡
+ (BOOL) IsBankCard:(NSString *)cardNumber;

@end
