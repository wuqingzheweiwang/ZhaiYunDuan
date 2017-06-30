//
//  ZJHomeNewsViewCell.h
//  债云端
//
//  Created by 赵凯强 on 2017/5/19.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJHomeItem.h"
@interface ZJHomeNewsViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ImageFlag;
@property (weak, nonatomic) IBOutlet UILabel *ImageFlagLabel;

@property (weak, nonatomic) IBOutlet UILabel *Lurushijian1;





-(void)setitem:(ZJHomeNewsModel *)item;
+ (CGFloat)getCellHeight;
@end
