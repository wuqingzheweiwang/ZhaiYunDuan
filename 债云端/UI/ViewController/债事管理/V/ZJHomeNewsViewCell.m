//
//  ZJHomeNewsViewCell.m
//  债云端
//
//  Created by 赵凯强 on 2017/5/19.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJHomeNewsViewCell.h"

@implementation ZJHomeNewsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

-(void)setitem:(ZJHomeNewsModel *)item
{
    
    _ImageFlag.top = TRUE_1(40/2);
    _ImageFlag.left = TRUE_1(45/2);
    _ImageFlag.width = TRUE_1(50);
    _ImageFlag.height =  _ImageFlag.width;
    _ImageFlag.contentMode = UIViewContentModeScaleAspectFill;
    _ImageFlag.clipsToBounds = YES;
    _ImageFlag.layer.masksToBounds=YES;
    _ImageFlag.layer.cornerRadius=4;
    [self.ImageFlag sd_setImageWithURL:[NSURL URLWithString:item.img] placeholderImage:[UIImage imageNamed:@"backGroundDefault"]];

    _ImageFlagLabel.top = _ImageFlag.top;
    _ImageFlagLabel.left = _ImageFlag.right + TRUE_1(25/2);
    _ImageFlagLabel.font=ZJ_TRUE_FONT(15);
    _ImageFlagLabel.width = ZJAPPWidth - _ImageFlag.right - TRUE_1(25);
    _ImageFlagLabel.numberOfLines =0;
    NSMutableAttributedString * mastring = [[NSMutableAttributedString alloc]initWithString:item.title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];//调整行间距
    
    [mastring addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [item.title length])];
    [mastring addAttribute:NSFontAttributeName value:_ImageFlagLabel.font range:NSMakeRange(0, mastring.length)];
    _ImageFlagLabel.attributedText = mastring;
    
    CGFloat width = _ImageFlagLabel.width; 
    
    CGRect rect = [mastring boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    _ImageFlagLabel.height = rect.size.height;
    
    
    self.Lurushijian1.text = item.updateTime;
    self.Lurushijian1.top=TRUE_1(60);
    self.Lurushijian1.font=ZJ_TRUE_FONT(10);
    self.Lurushijian1.left=_ImageFlagLabel.left;
    self.Lurushijian1.height=TRUE_1(10);
    self.Lurushijian1.width=ZJAPPWidth-TRUE_1(45/2)-TRUE_1(50)-TRUE_1(25/2);
}

+ (CGFloat)getCellHeight
{
    return TRUE_1(70);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
