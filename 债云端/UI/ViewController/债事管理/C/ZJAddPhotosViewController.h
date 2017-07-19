//
//  ZJAddPhotosViewController.h
//  债云端
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBaseViewController.h"
typedef NS_ENUM(NSInteger, ZJAddPhotosType) {
    ZJAddPhotosDebtRecord = 1,//债事备案
    ZJAddPhotosDebtAddEditCapital= 2,//新增编辑资产信息
};
@interface ZJAddPhotosViewController : ZJBaseViewController
@property (nonatomic, assign)ZJAddPhotosType Phototype;

//债事备案
@property (nonatomic,strong) NSMutableDictionary * debtRelation1Vo;
@property (nonatomic,strong) NSMutableDictionary * debtRelation2Vo;


//新增编辑资产信息
@property (nonatomic,strong) NSMutableDictionary * debtCapitalDic;
@property (nonatomic,strong) NSArray * debtCapitalimageDic;
@property (nonatomic,strong) NSString * debtCapitaltype;
@end
