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

    backImage.top=TRUE_1(10);
    backImage.left=TRUE_1(15);
    backImage.width=TRUE_1(250/2);
    backImage.height=TRUE_1(380/2);
    [backImage sd_setImageWithURL:[NSURL URLWithString:item.img] placeholderImage:[UIImage imageNamed:@"backGroundDefault"]];

    titileText.top = backImage.top;
    titileText.left = backImage.right+TRUE_1(15);
    titileText.width = ZJAPPWidth - titileText.left -backImage.left;
    titileText.numberOfLines =0;
    NSMutableAttributedString * mastring_1 = [[NSMutableAttributedString alloc]initWithString:item.title];
    NSMutableParagraphStyle *paragraphStyle_1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle_1 setLineSpacing:3];//调整行间距
    
    [mastring_1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle_1 range:NSMakeRange(0, [item.title length])];
    [mastring_1 addAttribute:NSFontAttributeName value:titileText.font range:NSMakeRange(0, mastring_1.length)];
    titileText.attributedText = mastring_1;
    
    CGFloat width_1 = titileText.width; // whatever your desired width is
    
    CGRect rect_1 = [mastring_1 boundingRectWithSize:CGSizeMake(width_1, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    titileText.height = rect_1.size.height;
    titileText.font = ZJ_TRUE_FONT(15);
    
    detialText.top = titileText.bottom+TRUE_1(10);
    detialText.left = titileText.left;
    detialText.width = titileText.width;
    detialText.numberOfLines =0;
    NSMutableAttributedString * mastring_2 = [[NSMutableAttributedString alloc]initWithString:item.detialtitle];
    NSMutableParagraphStyle *paragraphStyle_2 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle_2 setLineSpacing:3];//调整行间距
    
    [mastring_2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle_2 range:NSMakeRange(0, [item.detialtitle length])];
    [mastring_2 addAttribute:NSFontAttributeName value:detialText.font range:NSMakeRange(0, mastring_2.length)];
    detialText.attributedText = mastring_2;
    
    CGFloat width_2 = detialText.width; // whatever your desired width is
    
    CGRect rect_2 = [mastring_2 boundingRectWithSize:CGSizeMake(width_2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    detialText.height = rect_2.size.height;
    
    
    timeText.top = detialText.bottom+TRUE_1(10);
    timeText.left = detialText.left;
    timeText.width = detialText.width;
    timeText.height = TRUE_1(15);
    timeText.font = ZJ_TRUE_FONT(15);
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
