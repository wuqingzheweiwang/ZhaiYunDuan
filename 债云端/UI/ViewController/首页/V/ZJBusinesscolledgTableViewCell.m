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
-(void)setitem:(ZJBusinessSchoolModel *)item
{

    backImage.top=TRUE_1(20);
    backImage.left=TRUE_1(15);
    backImage.width=TRUE_1(250/2);
    backImage.height=TRUE_1(70);
    backImage.contentMode = UIViewContentModeScaleAspectFill;
    backImage.clipsToBounds = YES;
    [backImage sd_setImageWithURL:[NSURL URLWithString:item.img] placeholderImage:[UIImage imageNamed:@"backGroundDefault"]];
    
    titileText.top = TRUE_1(20);
    titileText.left = backImage.right+TRUE_1(15);
    titileText.width = ZJAPPWidth - TRUE_1(45) -backImage.width;
    titileText.font=ZJ_TRUE_FONT(14);
    titileText.text=item.title;
    titileText.height = TRUE_1(20);
    
    detialText.top = TRUE_1(40);
    detialText.left = titileText.left;
    detialText.width = titileText.width;
    detialText.font=ZJ_TRUE_FONT(10);
    detialText.numberOfLines = 0;
    detialText.text=item.detialtitle;
    detialText.height = TRUE_1(30);
    
    timeText.top = TRUE_1(80);
    timeText.left = titileText.left;
    timeText.width = titileText.width;
    timeText.height = TRUE_1(10);
    timeText.font = ZJ_TRUE_FONT(10);
    timeText.text = item.updateTime;
}

+ (CGFloat)getCellHeight
{
    return TRUE_1(90);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
