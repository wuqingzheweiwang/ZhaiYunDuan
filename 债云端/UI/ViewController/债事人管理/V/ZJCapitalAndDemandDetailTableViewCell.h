//
//  ZJCapitalAndDemandDetailTableViewCell.h
//  债云端
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJCapitalAndDemandDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *InfotextLabel;
-(void)setitem:(NSString *)item;
+ (CGFloat)getCellHeight:(NSString *)item;
@end
