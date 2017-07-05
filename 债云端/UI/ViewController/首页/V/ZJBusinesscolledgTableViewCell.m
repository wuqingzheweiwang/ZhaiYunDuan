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
    __weak IBOutlet UIView *backView;

    __weak IBOutlet UILabel *tdfdlabel;
    __weak IBOutlet UIImageView *playeriamge;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setitem:(UIImage *)item
{

    backView.top=10;
    backView.left=15;
    backView.width=ZJAPPWidth-30;
    backView.height=90;
    backView.layer.cornerRadius=4;
    backView.layer.masksToBounds=YES;
    backView.backgroundColor=HexRGB(colorLong(@"42b6d9"));
    
    tdfdlabel.top=0;
    tdfdlabel.left=15;
    tdfdlabel.width=150;
    tdfdlabel.height=90;
    tdfdlabel.text=[NSString stringWithFormat:@"讲座视频 %@",item];
    
    playeriamge.top=45/2;
    playeriamge.left=ZJAPPWidth-30-15-45;
    playeriamge.width=45;
    playeriamge.height=45;
    
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
