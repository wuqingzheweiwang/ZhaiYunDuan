//
//  ZJBusinesscolledgTableViewCell.h
//  债云端
//
//  Created by apple on 2017/7/5.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJHomeItem.h"
@interface ZJBusinesscolledgTableViewCell : UITableViewCell
-(void)setitem:(ZJBusinessSchoolModel *)item;
+ (CGFloat)getCellHeight;
@end
