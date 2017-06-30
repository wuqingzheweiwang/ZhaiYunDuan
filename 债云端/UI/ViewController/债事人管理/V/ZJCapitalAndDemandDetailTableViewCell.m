//
//  ZJCapitalAndDemandDetailTableViewCell.m
//  债云端
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJCapitalAndDemandDetailTableViewCell.h"

@implementation ZJCapitalAndDemandDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setitem:(NSString *)item
{

    UILabel  * label=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, ZJAPPWidth-30, 0)];
    label.textColor=ZJColor_333333;
    label.font=ZJ_FONT(15);
    label.numberOfLines=0;
    NSString * textsring=item;
    
    NSMutableAttributedString * mastring = [[NSMutableAttributedString alloc]initWithString:textsring];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];//调整行间距
    
    [mastring addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textsring length])];
    [mastring addAttribute:NSFontAttributeName value:label.font range:NSMakeRange(0, mastring.length)];
    label.attributedText = mastring;
    
    CGFloat width = label.width;
    
    CGRect rect = [mastring boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    label.height = rect.size.height;
    [self addSubview:label];
}
+ (CGFloat)getCellHeight:(NSString *)item
{
    UILabel  * label=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, ZJAPPWidth-30, 0)];
    label.textColor=ZJColor_333333;
    label.font=ZJ_FONT(15);
    label.numberOfLines=0;
    NSString * textsring=item;
    
    NSMutableAttributedString * mastring = [[NSMutableAttributedString alloc]initWithString:textsring];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];//调整行间距
    
    [mastring addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textsring length])];
    [mastring addAttribute:NSFontAttributeName value:label.font range:NSMakeRange(0, mastring.length)];
    label.attributedText = mastring;
    
    CGFloat width = label.width;
    
    CGRect rect = [mastring boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    label.height = rect.size.height;
    return label.height+5;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
