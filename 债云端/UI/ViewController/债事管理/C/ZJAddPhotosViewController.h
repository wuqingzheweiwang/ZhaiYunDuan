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
    ZJAddPhotosDebtPerson = 2,//添加债事人
    ZJAddPhotosDebtCompany= 3,//添加债事公司
    ZJAddPhotosDebtAddEditCapital= 4,//新增编辑资产信息
};
@interface ZJAddPhotosViewController : ZJBaseViewController
@property (nonatomic, assign)ZJAddPhotosType Phototype;

//债事备案
@property (nonatomic,strong) NSMutableDictionary * debtRelation1Vo;
@property (nonatomic,strong) NSMutableDictionary * debtRelation2Vo;

//债事人和债事公司
@property (nonatomic,strong) NSMutableDictionary * debtPersonDict;
@property (nonatomic,strong) NSMutableDictionary * debtCompanyDict;
@property (nonatomic,strong) NSString * fromWhereto;  //从哪进来的
@property (nonatomic,strong) NSString * isower;      //是不是要增加自己这个债事人

//新增编辑资产信息
@property (nonatomic,strong) NSMutableDictionary * debtCapitalDic;
@property (nonatomic,strong) NSArray * debtCapitalimageDic;
@property (nonatomic,strong) NSString * debtCapitaltype;
@end
