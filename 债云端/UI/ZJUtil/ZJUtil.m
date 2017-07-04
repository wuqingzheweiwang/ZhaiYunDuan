//
//  ZJUtil.m
//  债云端
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJUtil.h"

#import "AppDelegate.h"
#import "RegexKitLite.h"
#define  HUD_TAG  9999
#define DURATION    0.7


@implementation ZJUtil
+ (CGSize)calculateSingleStringSizeWithString:(NSString *)string andFont:(UIFont *)font {
    return [string sizeWithAttributes:@{NSFontAttributeName:font}];
}

+ (CGSize)calculateStringSizeWithString:(NSString *)string andFont:(UIFont *)font andSize:(CGSize)size {
    CGSize maxSize = CGSizeMake(size.width, MAXFLOAT);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:string];
    //  [paragraphStyle setLineSpacing:kSpace_H];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize retSize = [string boundingRectWithSize:maxSize
                                          options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:attributes
                                          context:nil].size;
    
    
    return retSize;
}

+ (NSString *)removeLineFormString:(NSString *)string {
    NSString *content = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return content;
}

//设置多行Label的行间距
+ (void)getLabelLineWithLabel:(UILabel *)label andContent:(NSString *)content andSize:(CGSize)size andLabelFont:(UIFont *)font andFrame:(CGRect)frame{
    
    label.frame = frame;
    label.numberOfLines = 0;
    label.font = font;
    label.textAlignment = NSTextAlignmentLeft;
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    //   [paragraphStyle1 setLineSpacing:kSpace_H];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [content length])];
    [label setAttributedText:attributedString1];
    [label sizeToFit];
}



#pragma mark
#pragma mark - 将dictionary转化为json字符串

+ (NSString*)getJsonWith:(NSDictionary*)dic {
    NSString *json = @"";
    if ([NSJSONSerialization isValidJSONObject:dic]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        if(!error) {
            json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    else
        NSLog(@"Not a valid JSON object: %@", dic);
    return json;
}

#pragma mark
#pragma mark-- 清除缓存
+ (NSString *)LibraryDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)DocumentDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)PreferencePanesDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)CachesDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}
// 按路径清除文件
+ (void)clearCachesWithFilePath:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
        NSLog(@"清除完成");
    }];
    
}


+ (double)sizeWithFilePaht:(NSString *)path
{
    // 1.获得文件夹管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.检测路径的合理性
    BOOL dir = NO;
    BOOL exits = [mgr fileExistsAtPath:path isDirectory:&dir];
    if (!exits) return 0;
    
    // 3.判断是否为文件夹
    if (dir) { // 文件夹, 遍历文件夹里面的所有文件
        // 这个方法能获得这个文件夹下面的所有子路径(直接\间接子路径)
        NSArray *subpaths = [mgr subpathsAtPath:path];
        int totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullsubpath = [path stringByAppendingPathComponent:subpath];
            
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullsubpath isDirectory:&dir];
            if (!dir) { // 子路径是个文件
                NSDictionary *attrs = [mgr attributesOfItemAtPath:fullsubpath error:nil];
                totalSize += [attrs[NSFileSize] intValue];
            }
        }
        return totalSize / (1024 * 1024.0);
    } else { // 文件
        NSDictionary *attrs = [mgr attributesOfItemAtPath:path error:nil];
        return [attrs[NSFileSize] intValue] / (1024.0 * 1024.0);
    }
}


+ (NSString *)removeSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    NSString *text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    return text;
}

///压缩图片质量
+ (UIImage *)reduceImage:(UIImage *)image percent:(float)percent
{
    NSData *imageData = UIImageJPEGRepresentation(image, percent);
    UIImage *newImage = [UIImage imageWithData:imageData];
    return newImage;
}
//压缩图片尺寸
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}
//上传标准图片
+ (UIImage *)uploadStandardImage:(UIImage *)image {
    CGSize newSize = image.size;
    if (image.size.width>image.size.height) {//宽图
        if (image.size.width>500) {
            newSize = CGSizeMake(500, newSize.height/(newSize.width/500));
        }
    }else{//长图或方图
        if (image.size.height>500) {
            newSize = CGSizeMake(newSize.width/(newSize.height/500), 500);
        }
    }
    if (newSize.width == image.size.width && newSize.height == image.size.height) {
        return image;
    }
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}



#pragma CATransition动画实现
+ (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = DURATION;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}
#pragma UIView实现动画
- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:DURATION animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

/**
 *  计算带有换行的字符串
 *
 *  @param text 文本
 *  @param font 文本字样
 *  @param size 容器尺寸
 */
+ (CGSize)sizeForNoticeTitle:(NSString*)text font:(UIFont*)font size:(CGSize)size{
    CGFloat maxWidth = size.width;
    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    
    CGSize textSize = CGSizeZero;
    // iOS7以后使用boundingRectWithSize，之前使用sizeWithFont
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
        NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
        NSStringDrawingUsesFontLeading;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        
        NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
        
        CGRect rect = [text boundingRectWithSize:maxSize
                                         options:opts
                                      attributes:attributes
                                         context:nil];
        textSize = rect.size;
    }
    else{
//        textSize = [text sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
        
    }
    
    return textSize;
}

+ (NSString *)somethingID:(NSString *)webURL importing:(NSString *)importSting
{
    NSRange range = [webURL rangeOfString:importSting];
    NSString * string = [webURL substringWithRange:NSMakeRange(range.location, webURL.length - range.location)];
    NSRange pointRange = [string rangeOfString:@"."];
    
    NSString * importing = [string substringWithRange:NSMakeRange(0, pointRange.location)];
    NSArray * array = [importing componentsSeparatedByString:@"/" ];
    if (array.count >=2) {
        return [array objectAtIndex:1];
    }else return @"";
}

// 判断登录
+(BOOL)getUserLogin
{
    BOOL islogin = NO;
    if ([[UserDeafult objectForKey:@"userloginstate"]boolValue]) {
        islogin = YES;
    }
//    if (islogin) {
//        if ([[ZJUserInfo getUserIDForUserInfo]length]<=0) {
//            islogin = NO;
//        }
//    }
    return islogin;
}

//退出
+ (void)logout
{
    [UserDeafult setObject:@"" forKey:@"userToken"];
    [UserDeafult synchronize];
    
    [ZJUserInfo changeUserLoginState:NO];
}


// 判断是否为债行
+(BOOL)getUserIsDebtBank
{
    if ([[ZJUserInfo getUserRoleForUserRole] isEqualToString:@"2"]||[[ZJUserInfo getUserRoleForUserRole] isEqualToString:@"3"]) {
        NSLog(@"非债行");
        return NO;
    }else{
        NSLog(@"债行");
        return YES;
    }
    return YES;
}

// 判断是否为会员
+(BOOL)getUserIsVip
{
    if ([[ZJUserInfo getUserRoleForUserRole] isEqualToString:@"3"]) {
        NSLog(@"非会员");
        return NO;
    }else{
        NSLog(@"会员");
        return YES;
    }
    return YES;
}
/**
 * Detect whether an account is a Chinese mobile No.
 *  1、手机号限制
 */
+ (BOOL)isMobileNo:(NSString *)accountName {
    if([ZJUtil isEmptyStr:accountName])
    {
        return NO;
    }
    if (accountName.length==11 || accountName.length == 13) {
        return [accountName isMatchedByRegex:@"1[0-9]{10}"]
        || [accountName isMatchedByRegex:@"861[0-9]{10}"];
    }
    return NO;
}

// 比较字符串
+ (BOOL)isEmptyStr:(NSString*)str{
    BOOL empty = NO;
    if(str == nil || [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length <=0 ){
        empty = YES;
    }
    return empty;
}

/*
    2、身份证限制
 ^d{15}|d{}18$
 */
+ (BOOL)isIDCard:(NSString *)idCard {
    BOOL flag;
    if (idCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:idCard];
}
//  3、邮箱
+ (BOOL) IsEmailAdress:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}

//   4、银行卡
+ (BOOL) IsBankCard:(NSString *)cardNumber
{
    if(cardNumber.length==0)
    {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++)
    {
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

/*
 * 菊花+提示框
 */
+ (void)showBottomToastWithMsg:(NSString *)msg
{
    NSString *temp = [msg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(temp.length>0 && temp.length<30)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"smallSlidView" object:[NSArray arrayWithObjects:@"200",@"25",temp,nil]];
    }
}


// 需要时调用(遍历字体)
+(void)forinAllFont
{
    // 遍历获取字体名称
    for(NSString *fontFamilyName in [UIFont familyNames])
    {
        NSLog(@"family:'%@'",fontFamilyName);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontFamilyName])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------");
    }
    
}

//判断是否全是空格
+ (BOOL)isKGEmpty:(NSString *) str {
    if (!str) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

@end
