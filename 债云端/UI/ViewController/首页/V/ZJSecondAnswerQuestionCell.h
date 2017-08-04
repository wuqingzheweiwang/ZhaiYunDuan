//
//  ZJSecondAnswerQuestionCell.h
//  债云端
//
//  Created by 赵凯强 on 2017/8/4.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJHomeItem.h"
@interface ZJSecondAnswerQuestionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *textLanbel;
@property (weak, nonatomic) IBOutlet UIImageView *pushImageV;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (nonatomic, strong) ZJAnswerQuestionModel *item;


-(void)setitem:(ZJAnswerQuestionModel *)item;
+ (CGFloat)getCellHeight;
@end
