//
//  ZJActionSheet.m
//  
//
//  Created by 赵凯强 on 17/5/04.
//  Copyright © 2017年 All rights reserved.
//

#import "ZJActionSheet.h"
#define kScreenCenter self.window.center
@interface ZJActionSheet ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy)   NSString  *title;
@property (nonatomic, strong) NSMutableArray *confirms;
@property (nonatomic, strong) NSString *cancel;
@property (nonatomic, strong) NSString *typeClass;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) ZJActionSheetStyle style;
@end

@implementation ZJActionSheet
{
    // 添加银行卡
    UIButton *addcard;
    // 账户余额
    UIButton *balanceBut;
    // 对勾
    UIButton *agreeBut;
}
+ (ZJActionSheet *)actionSheetWithTitle:(NSString *)title confirms:(NSMutableArray *)confirms cancel:(NSString *)cancel withType:(NSString *)ytpe style:(ZJActionSheetStyle)style
{
    return [[self alloc] initWithTitle:title confirms:confirms cancel:cancel type:ytpe style:style];
}
#pragma mark - 初始化控件
- (instancetype)initWithTitle:(NSString *)title confirms:(NSMutableArray *)confirms cancel:(NSString *)cancel type:(NSString *)type style:(ZJActionSheetStyle)style
{
    self = [super init];
    if (self) {
        self.title = title;
        self.confirms = confirms;
        self.cancel = cancel;
        self.style = style;
        self.typeClass=type;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, TRUE_1(200/2)+64, ZJAPPWidth, ZJAPPHeight - TRUE_1(200/2)+64);

        [self addSubview:self.tableView];
    }
    return self;
}

// 阴影/蒙版
- (UIView *)shadowView
{
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.frame = CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight);
        _shadowView.backgroundColor = [UIColor blackColor];
        _shadowView.alpha = 0.4;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(tapAction)];
        [_shadowView addGestureRecognizer:tap];
    }
    return _shadowView;
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ZJAPPWidth, ZJAPPHeight - TRUE_1(200/2)+64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        addcard = [[UIButton alloc]init];
        balanceBut = [[UIButton alloc]init];
        addcard.tag = 2000;
        [addcard addTarget:self action:@selector(addcardBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        balanceBut.tag = 2001;
        [balanceBut addTarget:self action:@selector(balanceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.typeClass isEqualToString:@"chongzhi"]) {
            
            UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, TRUE_1(100))];

            UIImageView *imageV = [[UIImageView alloc]init];
            imageV.centerY = TRUE_1(25/2);
            imageV.left = TRUE_1(35/2);
            imageV.width = TRUE_1(50/2);
            imageV.height = TRUE_1(50/2);
            imageV.image = [UIImage imageNamed:@"bankcard"];
            
            UILabel *label = [[UILabel alloc]init];
            label.top = imageV.top;
            label.left = imageV.right + TRUE_1(30/2);
            label.width = ZJAPPWidth - imageV.right - TRUE_1(35);
            label.height = imageV.height;
            label.text = @"添加银行卡支付";
            label.font = ZJ_TRUE_FONT(15);
            
            UIImageView *nextImage = [[UIImageView alloc]init];
            nextImage.top = TRUE_1(20);
            nextImage.width = TRUE_1(6);
            nextImage.height = TRUE_1(11);
            nextImage.right = ZJAPPWidth - TRUE_1(35/2) - nextImage.width;
            nextImage.image = [UIImage imageNamed:@"more"];
            
            
            UIView *bottomLine =[[UIView alloc]init];
            bottomLine.top = view.bottom/2;
            bottomLine.left = 0;
            bottomLine.width = ZJAPPWidth;
            bottomLine.height = 1;
            bottomLine.backgroundColor = ZJColor_dddddd;
            
            addcard.top = 0;
            addcard.left = 0;
            addcard.width = ZJAPPWidth;
            addcard.height = view.height/2;
            
            UIImageView *imageV_1 = [[UIImageView alloc]init];
            imageV_1.centerY = TRUE_1(25/2)+TRUE_1(50);
            imageV_1.left = TRUE_1(35/2);
            imageV_1.width = TRUE_1(50/2);
            imageV_1.height = TRUE_1(50/2);
            imageV_1.image = [UIImage imageNamed:@"account-balance"];
            
            UILabel *label_1 = [[UILabel alloc]init];
            label_1.top = imageV_1.top;
            label_1.left = imageV_1.right + TRUE_1(30/2);
            label_1.width = ZJAPPWidth - imageV_1.right - TRUE_1(35);
            label_1.height = imageV_1.height;

            label_1.text = @"账户余额支付";
            label_1.font = ZJ_TRUE_FONT(15);
            
            UIView *bottomLine_1 =[[UIView alloc]init];
            bottomLine_1.top = view.bottom;
            bottomLine_1.left = 0;
            bottomLine_1.width = ZJAPPWidth;
            bottomLine_1.height = 1;
            bottomLine_1.backgroundColor = ZJColor_dddddd;
            
            balanceBut.top = addcard.bottom;
            balanceBut.left = 0;
            balanceBut.width = ZJAPPWidth;
            balanceBut.height = view.height/2;

            [view addSubview:imageV];
            [view addSubview:label];
            [view addSubview:nextImage];
            [view addSubview:bottomLine];
            [view addSubview:addcard];

            [view addSubview:imageV_1];
            [view addSubview:label_1];
            [view addSubview:bottomLine_1];
            [view addSubview:balanceBut];

            _tableView.tableFooterView=view;
        }else if ([self.typeClass isEqualToString:@"tixian"]){
           
            UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, TRUE_1(100/2))];
            UIImageView *imageV = [[UIImageView alloc]init];
            imageV.top = TRUE_1(25/2);
            imageV.left = TRUE_1(30/2);
            imageV.width = TRUE_1(50/2);
            imageV.height = TRUE_1(50/2);
            imageV.image = [UIImage imageNamed:@"bankcard"];
            
            UILabel *label = [[UILabel alloc]init];
            label.top = imageV.top;
            label.left = imageV.right + TRUE_1(30/2);
            label.width = ZJAPPWidth - imageV.right - TRUE_1(35);
            label.height = imageV.height;
            label.text = @"添加银行卡支付";
            label.font = ZJ_TRUE_FONT(15);
            
            UIImageView *nextImage = [[UIImageView alloc]init];
            nextImage.top = TRUE_1(20);
            nextImage.width = TRUE_1(6);
            nextImage.height = TRUE_1(11);
            nextImage.right = ZJAPPWidth - TRUE_1(35/2) - nextImage.width;
            nextImage.image = [UIImage imageNamed:@"more"];
            
            addcard.top = 0;
            addcard.left = 0;
            addcard.width = ZJAPPWidth;
            addcard.height = view.height;
            
            UIView *bottomLine =[[UIView alloc]init];
            bottomLine.top = view.bottom;
            bottomLine.left = 0;
            bottomLine.width = ZJAPPWidth;
            bottomLine.height = 1;
            bottomLine.backgroundColor = ZJColor_dddddd;
            
            [view addSubview:imageV];
            [view addSubview:label];
            [view addSubview:nextImage];
            [view addSubview:addcard];
            [view addSubview:bottomLine];
            
            _tableView.tableFooterView=view;
        }
        
    }
    
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.confirms.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.confirms[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str  =@"vsd";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    移除cell.contentView 上的子视图（解决重影效果）
    for (UIView *subView in cell.contentView.subviews) {
        
        [subView removeFromSuperview];
        
    }
    
    UIImageView *imahe = [[UIImageView alloc]init];
    imahe.top = TRUE_1(25/2);
    imahe.left = TRUE_1(30/2);
    imahe.width = TRUE_1(50/2);
    imahe.height = imahe.width;
    imahe.image = [UIImage imageNamed:self.confirms[indexPath.section][indexPath.row][0]];

    UILabel *label = [[UILabel alloc]init];
    label.top = imahe.top;
    label.left = imahe.right+TRUE_1(30/2);
    label.width = TRUE_1(200);
    label.height = TRUE_1(30/2);
    label.font = ZJ_TRUE_FONT(28/2);
    label.text = self.confirms[indexPath.section][indexPath.row][1];
    label.font=ZJ_TRUE_FONT(15);
    
    UILabel *detailabel = [[UILabel alloc]init];
    detailabel.top = label.bottom;
    detailabel.left = imahe.right+TRUE_1(30/2);
    detailabel.width = TRUE_1(200);
    detailabel.height = TRUE_1(30/2);
    detailabel.font = ZJ_TRUE_FONT(28/2);
    detailabel.text = self.confirms[indexPath.section][indexPath.row][2];
    detailabel.font = ZJ_TRUE_FONT(12);
    detailabel.textColor = ZJColor_666666;
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.top = TRUE_1(100/2);
    bottomLine.left = 0;
    bottomLine.width = ZJAPPWidth;
    bottomLine.height = 1;
    bottomLine.backgroundColor = ZJColor_dddddd;

    [cell.contentView addSubview:imahe];
    [cell.contentView addSubview:label];
    [cell.contentView addSubview:detailabel];
    [cell.contentView addSubview:bottomLine];
    
    agreeBut = [[UIButton alloc]init];
    agreeBut.centerY = cell.imageView.centerY;
    agreeBut.top = TRUE_1(44/2);
    agreeBut.width = TRUE_1(10);
    agreeBut.height = agreeBut.width;
    agreeBut.right = ZJAPPWidth - TRUE_1(35/2) - agreeBut.width;
    [agreeBut setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    agreeBut.hidden = YES;
    [cell.contentView addSubview:agreeBut];

   
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        agreeBut.hidden = NO;
    }
  if (self.delegate && [self.delegate respondsToSelector:@selector(ZJActionSheetAlertClikButtonIndex:alert:)]) {
            [self.delegate ZJActionSheetAlertClikButtonIndex:indexPath.row alert:self];
        }   

}
-(void)addcardBtnAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZJActionSheetFootviewClikButtonIndex:alert:)]) {
        [self.delegate ZJActionSheetFootviewClikButtonIndex:sender.tag alert:self];
    }
}
-(void)balanceBtnAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZJActionSheetFootviewClikButtonIndex:alert:)]) {
        [self.delegate ZJActionSheetFootviewClikButtonIndex:sender.tag alert:self];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, TRUE_1(80/2))];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *closeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBut.top = TRUE_1(30/2);
    closeBut.left = TRUE_1(20/2);
    closeBut.width = TRUE_1(30/2);
    closeBut.height = TRUE_1(30/2);
    [closeBut setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBut addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, view.height)];
    label.text = self.title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = ZJ_TRUE_FONT(15);
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.top = view.bottom;
    bottomLine.left = 0;
    bottomLine.width = ZJAPPWidth;
    bottomLine.height = 1;
    bottomLine.backgroundColor = ZJColor_dddddd;
    
    [view addSubview:closeBut];
    [view addSubview:label];
    [view addSubview:bottomLine];
    return view;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TRUE_1(80/2);
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TRUE_1(100/2);
}

#pragma mark - 显示界面
- (void)showInView:(id)obj
{
    [obj addSubview:self.shadowView];
    [obj addSubview:self];
    
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.fromValue = @(0);
    opacity.duration = 0.2;
    [self.shadowView.layer addAnimation:opacity forKey:nil];

    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
    move.fromValue = [NSValue valueWithCGPoint:CGPointMake(kScreenCenter.x, ZJAPPHeight)];
    move.duration = 0.2;
    [self.layer addAnimation:move forKey:nil];
}

#pragma mark - 背景点击事件
- (void)tapAction
{
    [self animationHideShadowView];
    [self animationHideActionSheet];
}

#pragma mark - 取消
- (void)cancelButtonClick
{
    [self animationHideShadowView];
    [self animationHideActionSheet];
}

#pragma mark - 隐藏动画
- (void)animationHideShadowView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.shadowView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.shadowView removeFromSuperview];
    }];
}
- (void)animationHideActionSheet
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.frame = CGRectMake(0, ZJAPPHeight, ZJAPPWidth, self.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (CGFloat) height
{
    return self.frame.size.height;
}




@end
