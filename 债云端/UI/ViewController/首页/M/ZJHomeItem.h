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

//商学院
@interface ZJBusinessSchoolModel : NSObject
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detialtitle;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *url;

+ (ZJBusinessSchoolModel *)itemForDictionary:(NSDictionary *)dic;
@end

//视频课程
@interface ZJVideoCollectionModel : NSObject
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detialtitle;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *updateTime;

+ (ZJVideoCollectionModel *)itemForDictionary:(NSDictionary *)dic;
@end

