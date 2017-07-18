//
//  ZJHomeItem.m
//  债云端
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJHomeItem.h"

@implementation ZJHomeItem

@end
//新闻
@implementation ZJHomeNewsModel

+ (ZJHomeNewsModel *)itemForDictionary:(NSDictionary *)dic
{
    ZJHomeNewsModel * item=[[ZJHomeNewsModel alloc]init];
    if ([dic objectForKey:@"img"]) {
       item.img=[NSString stringWithFormat:@"%@",[dic objectForKey:@"img"]];
    }
    if ([dic objectForKey:@"subTitle"]) {
        item.subTitle=[NSString stringWithFormat:@"%@",[dic objectForKey:@"subTitle"]];
    }
    if ([dic objectForKey:@"title"]) {
        item.title=[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
    }
    if ([dic objectForKey:@"updateTime"]) {
        item.updateTime=[NSString stringWithFormat:@"%@",[dic objectForKey:@"updateTime"]];
    }
    if ([dic objectForKey:@"url"]) {
        item.url=[NSString stringWithFormat:@"%@",[dic objectForKey:@"url"]];
    }
    return item;
    
}
@end

@implementation ZJHomeScrollerModel

+ (ZJHomeScrollerModel *)itemForDictionary:(NSDictionary *)dic{
    
    ZJHomeScrollerModel * item=[[ZJHomeScrollerModel alloc]init];
    if ([dic objectForKey:@"url"]) {
        item.url=[NSString stringWithFormat:@"%@",[dic objectForKey:@"url"]];
    }
    if ([dic objectForKey:@"openUrl"]) {
        item.openUrl=[NSString stringWithFormat:@"%@",[dic objectForKey:@"openUrl"]];
    }
    return item;
}

@end
@implementation ZJMakePayModel

@end

@implementation ZJBusinessSchoolModel

+ (ZJBusinessSchoolModel *)itemForDictionary:(NSDictionary *)dic{
    
    ZJBusinessSchoolModel * item=[[ZJBusinessSchoolModel alloc]init];
    if ([dic objectForKey:@"img"]) {
        item.img=[NSString stringWithFormat:@"%@",[dic objectForKey:@"img"]];
    }
    if ([dic objectForKey:@"Title"]) {
        item.title=[NSString stringWithFormat:@"%@",[dic objectForKey:@"Title"]];
    }
    if ([dic objectForKey:@"detialtitle"]) {
        item.detialtitle=[NSString stringWithFormat:@"%@",[dic objectForKey:@"detialtitle"]];
    }
    if ([dic objectForKey:@"updateTime"]) {
        item.updateTime=[NSString stringWithFormat:@"%@",[dic objectForKey:@"updateTime"]];
    }
    if ([dic objectForKey:@"url"]) {
        item.url=[NSString stringWithFormat:@"%@",[dic objectForKey:@"url"]];
    }
    return item;
}

@end
