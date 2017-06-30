//
//  ZJProtocolAlterView.m
//  债云端
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJProtocolAlterView.h"

@implementation ZJProtocolAlterView
- (id)initWithProtocoltype:(NSString *)type withTitle:(NSString *)title
{
    if (self) {
        self = [super init];
        self.isAgree=NO;
        self.frame = CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight);
        self.backgroundColor = [UIColor clearColor];
        [self resetWithtype:type  title:title];
    }
    return self;
}

- (void)resetWithtype:(NSString *)type  title:(NSString*)title
{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight)];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.4;
    
    UIView *backView=[[UIView alloc]init];
    backView.frame = CGRectMake(0, 0, ZJAPPWidth-TRUE_1(75),TRUE_1(450));
    backView.center = self.center;
    backView.layer.cornerRadius = TRUE_1(5);
    backView.backgroundColor=[UIColor whiteColor];
    backView.layer.shadowOffset= CGSizeMake(0, 2);
    backView.layer.shadowColor=[UIColor blackColor].CGColor;
    backView.layer.shadowOpacity=0.5;
    backView.layer.shadowRadius=2;
    [self addSubview:backView];
    
    UILabel * Onelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, backView.width, TRUE_1(40))];
    Onelabel.textAlignment=NSTextAlignmentCenter;
    Onelabel.text=@"用户协议";
    Onelabel.textColor=ZJColor_333333;
    Onelabel.font=ZJ_FONT(TRUE_1(15));
    [backView addSubview:Onelabel];
    
    UIView * TwoView=[[UIView alloc]initWithFrame:CGRectMake(0, TRUE_1(40), backView.width, TRUE_1(325))];
    TwoView.backgroundColor=HexRGB(colorLong(@"efefef"));
    [backView addSubview:TwoView];
    
    UITextView * textView=[[UITextView alloc]initWithFrame:CGRectMake(TRUE_1(20),TRUE_1(50), backView.width-TRUE_1(40), TRUE_1(305))];
    textView.textColor=ZJColor_666666;
    textView.backgroundColor=HexRGB(colorLong(@"efefef"));
    textView.font=ZJ_FONT(TRUE_1(10));
    textView.showsVerticalScrollIndicator=NO;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2.5;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:10],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    textView.attributedText = [[NSAttributedString alloc] initWithString:title attributes:attributes];
    [backView addSubview:textView];
    textView.editable=NO;
    
    UIView * threeView=[[UIView alloc]initWithFrame:CGRectMake(0, TwoView.bottom, backView.width, TRUE_1(85))];
    threeView.layer.cornerRadius = TRUE_1(5);
    threeView.backgroundColor=[UIColor whiteColor];
    [backView addSubview:threeView];
    
    UIButton * agreeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.frame=CGRectMake(TRUE_1(10), TRUE_1(10), backView.width-TRUE_1(20), TRUE_1(13));
    if (self.isAgree) {
       [agreeBtn setImage:[UIImage imageNamed:@"agreeyes"] forState:UIControlStateNormal];
    }else{
       [agreeBtn setImage:[UIImage imageNamed:@"agreeno"] forState:UIControlStateNormal];
    }
    
    agreeBtn.tag=2000;
    agreeBtn.titleLabel.font=ZJ_FONT(TRUE_1(12));
     [agreeBtn setTitleColor:ZJColor_666666 forState:UIControlStateNormal];;
    [agreeBtn setTitle:[NSString stringWithFormat:@"阅读并同意《%@用户协议》",type] forState:UIControlStateNormal];
    [agreeBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,5)];
    [agreeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,5,0,0)];
    [threeView addSubview:agreeBtn];
    [agreeBtn addTarget:self action:@selector(touchAgree:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * quitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame=CGRectMake(TRUE_1(20), TRUE_1(30), (backView.width-TRUE_1(80))/2,TRUE_1(27));
    [quitBtn setTitle:@"取消" forState:UIControlStateNormal];
    quitBtn.titleLabel.font=ZJ_FONT(TRUE_1(13));
    quitBtn.tag=2001;
    [quitBtn setTitleColor:ZJColor_666666 forState:UIControlStateNormal];
    quitBtn.backgroundColor=HexRGB(colorLong(@"efefef"));
    quitBtn.layer.cornerRadius=TRUE_1(3);
    quitBtn.layer.masksToBounds=YES;
    [threeView addSubview:quitBtn];
    [quitBtn addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * okBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame=CGRectMake(TRUE_1(20)+backView.width/2, TRUE_1(30), (backView.width-TRUE_1(80))/2, TRUE_1(27));
    [okBtn setTitle:@"确认" forState:UIControlStateNormal];
    okBtn.titleLabel.font=ZJ_FONT(TRUE_1(13));
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    okBtn.tag=2002;
    okBtn.backgroundColor=ZJColor_red;
    okBtn.layer.cornerRadius=TRUE_1(3);
    okBtn.layer.masksToBounds=YES;
    [threeView addSubview:okBtn];
    [okBtn addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)touchCancel:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(zjProtocolAlertClikButtonIndex:alert:)]) {
        [self.delegate zjProtocolAlertClikButtonIndex:button.tag alert:self];
    }
}
- (void)touchAgree:(UIButton *)button
{
    self.isAgree=!self.isAgree;
    if (button.tag==2000) {
        if (self.isAgree) {
            [button setImage:[UIImage imageNamed:@"agreeyes"] forState:UIControlStateNormal];
        }else{
            [button setImage:[UIImage imageNamed:@"agreeno"] forState:UIControlStateNormal];
        }
    }
}
- (void)show
{
    [[[[[UIApplication sharedApplication]keyWindow]subviews]objectAtIndex:0]addSubview:self];
    
}
- (void)dismiss
{
    [self removeFromSuperview];
}


@end
