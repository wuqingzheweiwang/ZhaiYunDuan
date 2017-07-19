//
//  ZJVideoCollectionViewCell.m
//  债云端
//
//  Created by 赵凯强 on 2017/7/18.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJVideoCollectionViewCell.h"

@implementation ZJVideoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

   
}

-(void)setitem:(ZJVideoCollectionModel *)item
{
    headerImageView.top = 0;
    headerImageView.left = TRUE_1(15);
    headerImageView.width = (ZJAPPWidth - TRUE_1(15)*3)/2;
    headerImageView.height = TRUE_1(100);
    [headerImageView sd_setImageWithURL:[NSURL URLWithString:item.img] placeholderImage:[UIImage imageNamed:@"backGroundDefault"]];
    NSLog(@"%@",item.img);
    
    titleTextLabel.top = headerImageView.bottom+TRUE_1(10);
    titleTextLabel.left = headerImageView.left;
    titleTextLabel.width = headerImageView.width;
    titleTextLabel.numberOfLines =0;
    NSMutableAttributedString * mastring_1 = [[NSMutableAttributedString alloc]initWithString:item.title];
    NSMutableParagraphStyle *paragraphStyle_1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle_1 setLineSpacing:3];//调整行间距
    
    [mastring_1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle_1 range:NSMakeRange(0, [item.title length])];
    [mastring_1 addAttribute:NSFontAttributeName value:titleTextLabel.font range:NSMakeRange(0, mastring_1.length)];
    titleTextLabel.attributedText = mastring_1;
    
    CGFloat width_1 = titleTextLabel.width; // whatever your desired width is
    
    CGRect rect_1 = [mastring_1 boundingRectWithSize:CGSizeMake(width_1, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    titleTextLabel.height = rect_1.size.height;
    titleTextLabel.font = ZJ_TRUE_FONT(15);
    
    detialTextLabel.top = titleTextLabel.bottom+TRUE_1(5);
    detialTextLabel.left = titleTextLabel.left;
    detialTextLabel.width = titleTextLabel.width;
    detialTextLabel.numberOfLines =0;
//    NSMutableAttributedString * mastring_2 = [[NSMutableAttributedString alloc]initWithString:item.detialtitle];
//    NSMutableParagraphStyle *paragraphStyle_2 = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle_2 setLineSpacing:3];//调整行间距
//    
//    [mastring_2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle_2 range:NSMakeRange(0, [item.detialtitle length])];
//    [mastring_2 addAttribute:NSFontAttributeName value:detialTextLabel.font range:NSMakeRange(0, mastring_2.length)];
//    detialTextLabel.attributedText = mastring_1;
//    
//    CGFloat width_2 = detialTextLabel.width; // whatever your desired width is
//    
//    CGRect rect_2 = [mastring_1 boundingRectWithSize:CGSizeMake(width_2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
//    
//    detialTextLabel.height = rect_2.size.height;
//    detialTextLabel.font = ZJ_TRUE_FONT(12);

}

+ (CGFloat)getCellHeight
{
    return TRUE_1(350)/2;
}
@end
