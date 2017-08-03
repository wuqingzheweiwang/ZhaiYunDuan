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
    headerImageView.left = 0;
    headerImageView.width = (ZJAPPWidth - TRUE_1(15)*3)/2;
    headerImageView.height = TRUE_1(100);
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.clipsToBounds = YES;
    [headerImageView sd_setImageWithURL:[NSURL URLWithString:item.img] placeholderImage:[UIImage imageNamed:@"backGroundDefault"]];
    
    titleTextLabel.top = headerImageView.bottom+TRUE_1(5);
    titleTextLabel.left = headerImageView.left;
    titleTextLabel.width = headerImageView.width;
    titleTextLabel.height = TRUE_1(20);
    titleTextLabel.font = ZJ_TRUE_FONT(15);
    titleTextLabel.text = item.title;
    
    detialTextLabel.top = titleTextLabel.bottom;
    detialTextLabel.left = titleTextLabel.left;
    detialTextLabel.width = titleTextLabel.width;
    detialTextLabel.numberOfLines =0;
    detialTextLabel.height = TRUE_1(150)-headerImageView.height - titleTextLabel.height;
    detialTextLabel.font = ZJ_TRUE_FONT(12);
    detialTextLabel.text = item.detialtitle;
}

+ (CGFloat)getCellHeight
{
    return TRUE_1(300)/2;
}
@end
