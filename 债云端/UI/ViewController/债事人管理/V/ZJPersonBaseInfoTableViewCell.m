//
//  ZJPersonBaseInfoTableViewCell.m
//  债云端
//
//  Created by apple on 2017/5/5.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJPersonBaseInfoTableViewCell.h"

@implementation ZJPersonBaseInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setitem:(NSDictionary *)item
{
    self.InfoLabel.top=15;
    self.InfoLabel.left=15;
    self.InfoLabel.height=15;
    if ([[item objectForKey:@"type"]isEqualToString:@"human"]) {
        self.InfoLabel.width=80;
    }else{
        self.InfoLabel.width=110;
    }
    
    self.InfoLabel.text=[NSString stringWithFormat:@"%@:",[item objectForKey:@"title"]];
    self.InfoTextLabel.left=self.InfoLabel.right;
    self.InfoTextLabel.top=15;
    self.InfoTextLabel.height=15;
    if ([[item objectForKey:@"type"]isEqualToString:@"human"]) {
        self.InfoTextLabel.width=ZJAPPWidth-80-30;
    }else{
        self.InfoTextLabel.width=ZJAPPWidth-110-30;
    }
    
    self.InfoTextLabel.text=[NSString stringWithFormat:@"%@",[item objectForKey:@"text"]];
}
+ (CGFloat)getCellHeight
{
    return 30;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
