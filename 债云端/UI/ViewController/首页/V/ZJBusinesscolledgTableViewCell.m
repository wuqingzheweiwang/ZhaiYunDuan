//
//  ZJBusinesscolledgTableViewCell.m
//  债云端
//
//  Created by apple on 2017/7/5.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBusinesscolledgTableViewCell.h"

@implementation ZJBusinesscolledgTableViewCell
{

    __weak IBOutlet UIImageView *backImage;
        
    __weak IBOutlet UILabel *titileText;
    
    __weak IBOutlet UILabel *detialText;
    
    __weak IBOutlet UILabel *timeText;
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setitem:(ZJHomeNewsModel *)item
{

    backImage.top=TRUE_1(15);
    backImage.left=TRUE_1(15);
    backImage.width=TRUE_1(250/2);
    backImage.height=TRUE_1(70);
    [backImage sd_setImageWithURL:[NSURL URLWithString:item.img] placeholderImage:[UIImage imageNamed:@"backGroundDefault"]];

    titileText.top = TRUE_1(10);
    titileText.left = backImage.right+TRUE_1(15);
    titileText.width = ZJAPPWidth - titileText.left -backImage.left;
    titileText.numberOfLines =2;
    titileText.height = backImage.height/3;
    titileText.font = ZJ_TRUE_FONT(14);
    titileText.text = item.title;
    
    detialText.top = titileText.bottom+TRUE_1(7);
    detialText.left = titileText.left;
    detialText.width = titileText.width;
    detialText.height = backImage.height/3;
    detialText.numberOfLines =2;
    detialText.text = item.title;
    detialText.font = ZJ_TRUE_FONT(9);
    
    timeText.top = detialText.bottom+TRUE_1(5);
    timeText.left = detialText.left;
    timeText.width = detialText.width;
    timeText.height = backImage.height/3;
    timeText.font = ZJ_TRUE_FONT(9);
    timeText.text = item.updateTime;
}

+ (CGFloat)getCellHeight
{
    return 100;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
