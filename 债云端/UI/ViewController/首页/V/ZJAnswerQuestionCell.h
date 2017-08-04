//
//  ZJTeacherGraceCell.h
//  债云端
//
//  Created by 赵凯强 on 2017/8/4.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJHomeItem.h"
@interface ZJAnswerQuestionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *textlabel;

@property (weak, nonatomic) IBOutlet UILabel *detialTextALabel;

@property (weak, nonatomic) IBOutlet UIImageView *pushImage;

@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@property (nonatomic, strong) ZJAnswerQuestionModel *item;

-(void)setitem:(ZJAnswerQuestionModel *)item;
+ (CGFloat)getCellHeight;
@end
