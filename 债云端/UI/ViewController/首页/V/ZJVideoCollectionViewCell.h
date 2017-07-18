//
//  ZJVideoCollectionViewCell.h
//  债云端
//
//  Created by 赵凯强 on 2017/7/18.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJVideoCollectionViewCell : UICollectionViewCell
{
    
    __weak IBOutlet UIImageView *headerImageView;
    
    __weak IBOutlet UILabel *titleTextLabel;
    
    __weak IBOutlet UILabel *detialTextLabel;
    
}
@end
