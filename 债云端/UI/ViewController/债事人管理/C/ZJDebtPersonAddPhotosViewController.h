//
//  ZJDebtPersonAddPhotosViewController.h
//  债云端
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBaseViewController.h"
typedef NS_ENUM(NSInteger, ZJDebtPersonAddPhotosType) {

    ZJDebtPersonAddPhotosTypeDebtPerson = 1,//添加债事人
    ZJDebtPersonAddPhotosTypeDebtCompany= 2,//添加债事公司

};
@interface ZJDebtPersonAddPhotosViewController : ZJBaseViewController
@property (nonatomic, assign)ZJDebtPersonAddPhotosType Phototype;


//债事人和债事公司
@property (nonatomic,strong) NSMutableDictionary * debtPersonDict;
@property (nonatomic,strong) NSMutableDictionary * debtCompanyDict;
@property (nonatomic,strong) NSString * fromWhereto;  //从哪进来的
@property (nonatomic,strong) NSString * isower;      //是不是要增加自己这个债事人

@end
