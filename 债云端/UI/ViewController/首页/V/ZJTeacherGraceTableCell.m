//
//  ZJTeacherGraceTableCell.m
//  债云端
//
//  Created by 赵凯强 on 2017/8/4.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJTeacherGraceTableCell.h"
#define  Kheight  TRUE_1(15)
#define  Kwidth1  TRUE_1(50)
#define  Kwidth2  ZJAPPWidth-TRUE_1(150)-TRUE_1(30)-TRUE_1(50)

@implementation ZJTeacherGraceTableCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setitem:(ZJTeacherGraceModel *)item
{
    _item = item;
    //标志
    self.ImageFlag.top=TRUE_1(15);
    self.ImageFlag.left=TRUE_1(15);
    self.ImageFlag.width=TRUE_1(150);
    self.ImageFlag.height=TRUE_1(350/2);
    [self.ImageFlag sd_setImageWithURL:[NSURL URLWithString:item.img] placeholderImage:[UIImage imageNamed:@"backGroundDefault"]];

    //第一排
    self.NameLabel.top=self.ImageFlag.top;
    self.NameLabel.left=self.ImageFlag.right+TRUE_1(15);
    self.NameLabel.width=TRUE_1(40);
    self.NameLabel.height=TRUE_1(15);
    
    self.technicaltitleLabel.top=TRUE_1(40);
    self.technicaltitleLabel.left=self.NameLabel.left;
    self.technicaltitleLabel.width=Kwidth1;
    self.technicaltitleLabel.height=Kheight;
    
    self.introduceLabel.top=TRUE_1(65);
    self.introduceLabel.left=self.technicaltitleLabel.left;
    self.introduceLabel.width=Kwidth1;
    self.introduceLabel.height=Kheight;
    
    //第二排
    self.NameTextLabel.top=self.NameLabel.top;
    self.NameTextLabel.left=self.NameLabel.right;
    self.NameTextLabel.width=Kwidth2;
    self.NameTextLabel.height=Kheight;
    self.NameTextLabel.text=item.title;

    self.technicaltitleLabelTextLabel.top=self.technicaltitleLabel.top;
    self.technicaltitleLabelTextLabel.left=self.NameTextLabel.left;
    self.technicaltitleLabelTextLabel.width=Kwidth2;
    self.technicaltitleLabelTextLabel.height=Kheight;
    self.technicaltitleLabelTextLabel.text=item.detialtitle;

    
    self.introduceTextLabel.top=self.introduceLabel.top;
    self.introduceTextLabel.left=self.technicaltitleLabelTextLabel.left;
    self.introduceTextLabel.width=Kwidth2;
    self.introduceTextLabel.height=TRUE_1(100);
    self.introduceTextLabel.numberOfLines = 0;
    if (item.introduceText.length>0) {
        
        NSMutableAttributedString * mastring = [[NSMutableAttributedString alloc]initWithString:item.introduceText];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3];//调整行间距
        
        [mastring addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [item.introduceText length])];
        [mastring addAttribute:NSFontAttributeName value:self.introduceTextLabel
         .font range:NSMakeRange(0, mastring.length)];
        self.introduceTextLabel.attributedText = mastring;
        
        CGFloat width = self.introduceTextLabel.width;
        
        CGRect rect = [mastring boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        
        self.introduceTextLabel.height = rect.size.height;
        self.introduceTextLabel.text=item.introduceText;

        if (self.introduceTextLabel.height>self.ImageFlag.height) {
            self.introduceTextLabel.height = self.ImageFlag.height;
        }
    }

    
}

+ (CGFloat)getCellHeight
{
    return TRUE_1(380/2);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
