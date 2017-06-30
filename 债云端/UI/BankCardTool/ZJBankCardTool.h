//
//  ZJBankCardTool.h
//  债云端
//
//  Created by 赵凯强 on 2017/5/12.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface ZJBankCardTool : NSObject
SingletonH(BankCardTool);  // 单例
-(NSString *)getBankName:(NSString*) cardId;

@end
