//
//  ZJHomeItem.h
//  债云端
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJHomeItem : NSObject

@end
//新闻
@interface ZJHomeNewsModel : NSObject
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *url;

+ (ZJHomeNewsModel *)itemForDictionary:(NSDictionary *)dic;
@end

@interface ZJHomeScrollerModel : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *openUrl;
+ (ZJHomeScrollerModel *)itemForDictionary:(NSDictionary *)dic;
@end

//支付
@interface ZJMakePayModel : NSObject

@end
