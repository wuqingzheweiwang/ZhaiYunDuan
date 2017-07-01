//
//  ZJShareAlertView.m
//  债云端
//
//  Created by 赵凯强 on 2017/6/24.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJShareAlertView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@implementation ZJShareAlertView
{
    NSMutableArray *_imageArr;
    NSMutableArray *_titleArr;
    UIImageView *QRImageView;
}
- (id)initWithHeaderImage:(NSURL *)imageUrl withPersonName:(NSString *)name withCommandCode:(NSString *)recommandecode withQRUrl:(NSURL *)QRurl
{
    if (self) {
        self = [super init];

        self.frame = CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight);
        self.backgroundColor = [UIColor clearColor];
        
        [self resetWithHeaderImage:imageUrl withPersonName:name withCommandCode:recommandecode withQRUrl:QRurl];
    }
    return self;
}

- (void)resetWithHeaderImage:(NSURL *)imageUrl withPersonName:(NSString *)name withCommandCode:(NSString *)recommandecode withQRUrl:(NSURL *)QRurl
{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight)];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.4;
    
    UIView *sammallView = [[UIView alloc]init];
    sammallView.top = TRUE_1(140/2);
    sammallView.left = TRUE_1(75/2);
    sammallView.width = ZJAPPWidth-TRUE_1(75);
    sammallView.height =  TRUE_1(450);
    sammallView.layer.cornerRadius = TRUE_1(5);
    sammallView.backgroundColor=[UIColor whiteColor];
    sammallView.layer.shadowOffset= CGSizeMake(0, 2);
    sammallView.layer.shadowColor=[UIColor blackColor].CGColor;
    sammallView.layer.shadowOpacity=0.5;
    sammallView.layer.shadowRadius=2;
    [self addSubview:sammallView];
    
    UIImageView * headerImageView = [[UIImageView alloc]init];
    headerImageView.top = TRUE_1(15);
    headerImageView.centerX = sammallView.width/2-TRUE_1(35);
    headerImageView.width = TRUE_1(70);
    headerImageView.height = headerImageView.width;
    headerImageView.clipsToBounds=YES;
    headerImageView.contentMode=UIViewContentModeScaleAspectFill;
    headerImageView.layer.masksToBounds = YES;
    headerImageView.layer.cornerRadius = TRUE_1(70/2);
    //  给头像加一个圆形边框
    headerImageView.layer.borderWidth = 1.5f;
    headerImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [headerImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"head-portrait"]];
    [sammallView addSubview:headerImageView];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.top = headerImageView.bottom+TRUE_1(10);
    nameLabel.width = TRUE_1(70);
    nameLabel.height = TRUE_1(12);
    nameLabel.left = sammallView.width/2 - nameLabel.width;
    nameLabel.text = @"姓名:";
    nameLabel.textColor = ZJColor_333333;
    nameLabel.textAlignment = NSTextAlignmentRight;
    nameLabel.font = ZJ_TRUE_FONT(12);
    [sammallView addSubview:nameLabel];

    UILabel *nameTextLabel = [[UILabel alloc]init];
    nameTextLabel.top = nameLabel.top;
    nameTextLabel.left = nameLabel.right;
    nameTextLabel.width = TRUE_1(100);
    nameTextLabel.height = nameLabel.height;
    nameTextLabel.textColor = ZJColor_333333;
    nameTextLabel.textAlignment = NSTextAlignmentLeft;
    nameTextLabel.font = ZJ_TRUE_FONT(12);
    nameTextLabel.text = name;
    [sammallView addSubview:nameTextLabel];

    UILabel *myRecommandCodeLabel = [[UILabel alloc]init];
    myRecommandCodeLabel.top = nameLabel.bottom+TRUE_1(10);
    myRecommandCodeLabel.left = nameLabel.left;
    myRecommandCodeLabel.width = nameLabel.width;
    myRecommandCodeLabel.height = nameLabel.height;
    myRecommandCodeLabel.text = @"我的推荐码:";
    myRecommandCodeLabel.textColor = ZJColor_333333;
    myRecommandCodeLabel.textAlignment = NSTextAlignmentRight;
    myRecommandCodeLabel.font = ZJ_TRUE_FONT(12);
    [sammallView addSubview:myRecommandCodeLabel];

    UILabel *myCommandCodeTextLabel = [[UILabel alloc]init];
    myCommandCodeTextLabel.top = myRecommandCodeLabel.top;
    myCommandCodeTextLabel.left = myRecommandCodeLabel.right;
    myCommandCodeTextLabel.width = nameTextLabel.width;
    myCommandCodeTextLabel.height = myRecommandCodeLabel.height;
    myCommandCodeTextLabel.font = ZJ_TRUE_FONT(12);
    myCommandCodeTextLabel.text = recommandecode;
    myCommandCodeTextLabel.textColor = ZJColor_red;
    myCommandCodeTextLabel.textAlignment = NSTextAlignmentLeft;
    [sammallView addSubview:myCommandCodeTextLabel];

    QRImageView = [[UIImageView alloc]init];
    QRImageView.top = myRecommandCodeLabel.bottom+TRUE_1(15);
    QRImageView.width = TRUE_1(150);
    QRImageView.height = QRImageView.width;
    QRImageView.left = sammallView.width/2 - QRImageView.width/2;
    
    [self qrSetIamge:imageUrl codeString:recommandecode];

    [sammallView addSubview:QRImageView];

    UIView *downView = [[UIView alloc]init];
    downView.top = QRImageView.bottom+TRUE_1(15);
    downView.width = TRUE_1(160);
    downView.height = TRUE_1(12);
    downView.left = sammallView.width/2 - downView.width/2;
    [sammallView addSubview:downView];

    UILabel *downloadAPPLabel = [[UILabel alloc]init];
    downloadAPPLabel.top = 0;
    downloadAPPLabel.left = 0;
    downloadAPPLabel.width = TRUE_1(230/2);
    downloadAPPLabel.height = downView.height;
    downloadAPPLabel.font = ZJ_TRUE_FONT(12);
    downloadAPPLabel.text = @"扫一扫二维码，下载";
    downloadAPPLabel.textColor = ZJColor_666666;
    downloadAPPLabel.textAlignment = NSTextAlignmentRight;
    [downView addSubview:downloadAPPLabel];

    UIButton *appNameBut = [UIButton buttonWithType:UIButtonTypeCustom];
    appNameBut.top = downloadAPPLabel.top;
    appNameBut.left = downloadAPPLabel.right;
    appNameBut.width = downView.width - downloadAPPLabel.width;
    appNameBut.height = downView.height;
    [appNameBut setTitle:@"债云端" forState:UIControlStateNormal];
    [appNameBut setTitleColor:ZJColor_red forState:UIControlStateNormal];
    appNameBut.titleLabel.font = ZJ_TRUE_FONT(12);
    appNameBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    [downView addSubview:appNameBut];

    UILabel *shareLabel = [[UILabel alloc]init];
    shareLabel.top = downView.bottom +TRUE_1(15);
    shareLabel.width = TRUE_1(90);
    shareLabel.height = TRUE_1(25/2);
    shareLabel.left = sammallView.width/2 - shareLabel.width/2;
       shareLabel.font = ZJ_TRUE_FONT(14);
    shareLabel.text = @"分享到";
    shareLabel.textAlignment = NSTextAlignmentCenter;
    shareLabel.textColor = ZJColor_333333;
    [sammallView addSubview:shareLabel];

    UIView *leftLineView = [[UIView alloc]init];
    leftLineView.top = shareLabel.top+TRUE_1(25/4);
    leftLineView.left = 0;
    leftLineView.width = (sammallView.width - shareLabel.width)/2;
    leftLineView.height = 1;
    leftLineView.backgroundColor = ZJColor_efefef;
    [sammallView addSubview:leftLineView];

    UIView *rightLineView = [[UIView alloc]init];
    rightLineView.top = leftLineView.top;
    rightLineView.left = shareLabel.right;
    rightLineView.width = leftLineView.width;
    rightLineView.height = leftLineView.height;
    rightLineView.backgroundColor = ZJColor_efefef;
    [sammallView addSubview:rightLineView];

    UIScrollView *bottomScrollView = [[UIScrollView alloc]init];
    bottomScrollView.top = shareLabel.bottom;
    bottomScrollView.left = 0;
    bottomScrollView.width = sammallView.width;
    bottomScrollView.height = sammallView.height - shareLabel.bottom;
    _imageArr = [NSMutableArray arrayWithObjects:@"wechat-moments",@"wechat-friends",@"sina", nil];
    _titleArr = [NSMutableArray arrayWithObjects:@"微信朋友圈",@"微信好友",@"新浪微博", nil];
    
    for (int a = 0; a <_imageArr.count; a++) {
        
        UIButton *scorllShareView = [UIButton buttonWithType:UIButtonTypeCustom];
        scorllShareView.frame = CGRectMake((sammallView.width/3) * a, 0, sammallView.width/3, bottomScrollView.height);
        scorllShareView.tag = a;
        [scorllShareView addTarget:self action:@selector(touchShareToBut:) forControlEvents:UIControlEventTouchUpInside];
        [bottomScrollView addSubview:scorllShareView];
        
        UIButton *shareToBut = [UIButton buttonWithType:UIButtonTypeCustom];
        shareToBut.top = TRUE_1(15);
        shareToBut.width = TRUE_1(34);
        shareToBut.height = shareToBut.width;
        shareToBut.left = scorllShareView.width/2 - shareToBut.width/2;
        shareToBut.layer.masksToBounds = YES;
        shareToBut.layer.cornerRadius = shareToBut.width/2;
        [shareToBut setImage:[UIImage imageNamed:_imageArr[a]] forState:UIControlStateNormal];
        shareToBut.tag = a;
        [shareToBut addTarget:self action:@selector(touchShareToBut:) forControlEvents:UIControlEventTouchUpInside];
        [scorllShareView addSubview:shareToBut];

        UIButton *shareToLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        shareToLabel.top = shareToBut.bottom+TRUE_1(10);
        shareToLabel.left = 0;
        shareToLabel.width = scorllShareView.width;
        shareToLabel.height = TRUE_1(12);
        shareToLabel.titleLabel.font = ZJ_TRUE_FONT(12);
        shareToLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [shareToLabel setTitle:_titleArr[a] forState:UIControlStateNormal];
        [shareToLabel setTitleColor:ZJColor_666666 forState:UIControlStateNormal];
        shareToLabel.tag = a;
        [shareToLabel addTarget:self action:@selector(touchShareToBut:) forControlEvents:UIControlEventTouchUpInside];

        [scorllShareView addSubview:shareToLabel];
        
        
    }

    bottomScrollView.bounces = NO;
    bottomScrollView.pagingEnabled = NO;
    bottomScrollView.contentSize = CGSizeMake(bottomScrollView.width *(_imageArr.count/3), 0);

    [sammallView addSubview:bottomScrollView];

    UIButton *cancleDismissBut = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleDismissBut.top = sammallView.bottom+TRUE_1(15);
    cancleDismissBut.width = TRUE_1(30);
    cancleDismissBut.height = cancleDismissBut.width;
    cancleDismissBut.left = self.width/2 - cancleDismissBut.width/2;
    cancleDismissBut.layer.masksToBounds = YES;
    cancleDismissBut.layer.cornerRadius = TRUE_1(30/2);
    [bgView addSubview:cancleDismissBut];
    [cancleDismissBut setImage:[UIImage imageNamed:@"_close"] forState:UIControlStateNormal];
    [cancleDismissBut addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark  生成二维码
-(void)qrSetIamge:(NSURL *)imageUrl codeString:(NSString *)codeStr
{
    //     创建用于生成二维码滤镜
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    NSData *messageData = [[NSString stringWithFormat:@"%@%@",imageUrl,codeStr] dataUsingEncoding:NSUTF8StringEncoding];
    //  1.2 设置二维滤镜的输入
    [qrFilter setValue:messageData forKey:@"inputMessage"];
    //  1.3取出图片
    CIImage *ciImage = qrFilter.outputImage;
    //  1.4 放大图片
    ciImage = [ciImage imageByApplyingTransform:CGAffineTransformMakeScale(8, 8)];
    
#pragma mark - 修改二维码的前景色和背景色
    //  修改二维码的前景色和背景色,当你修改了前景色或背景色都会降低图片的识别度
    CIFilter *falseColorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    //    inputImage, 图片
    //    inputColor0, 前景颜色
    //    inputColor1  背景色
    //    这三个参数都是CoreImage中的对象
    //     NSLog(@"%@",falseColorFilter.inputKeys);
    //  图片
    [falseColorFilter setValue:ciImage forKey:@"inputImage"];
    //  前景色
    [falseColorFilter setValue:[CIColor colorWithRed:0 green:0 blue:0] forKey:@"inputColor0"];
    //  背景色
    [falseColorFilter setValue:[CIColor colorWithRed:255 green:255 blue:255] forKey:@"inputColor1"];
    
    
    
    //  取出滤镜中的图片
    ciImage = falseColorFilter.outputImage;
    
    //  二维码上面添加头像,也会降低二维码的识别度
    UIImage *qrImage = [UIImage imageWithCIImage:ciImage];
    
#pragma mark - 在原来的二维码的图片上画一个头像
    //  在原来的二维码的图片上画一个头像
    //  开启图片上下文
    UIGraphicsBeginImageContext(qrImage.size);
    //  绘制二维码图片
    [qrImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
    //  绘制头像
    UIImage *headImage = [UIImage imageNamed:@"cang"];
    CGFloat headW = qrImage.size.width * 0.2;
    CGFloat headH = qrImage.size.height * 0.2;
    CGFloat headX = (qrImage.size.width - headW) * 0.5;
    CGFloat headY = (qrImage.size.height - headH) * 0.5;
    [headImage drawInRect:CGRectMake(headX, headY, headW, headH)];
    //  从图片上下文中取出图片
    qrImage  = UIGraphicsGetImageFromCurrentImageContext();
    
    //  关闭图片上下文
    UIGraphicsEndImageContext();
    
    //  1.6 把CIImage转换为UIImage
    QRImageView.image = qrImage;
}

- (void)touchShareToBut:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(zjProtocolAlertClikButtonIndex:alert:)]) {
        
        [self.delegate zjProtocolAlertClikButtonIndex:button.tag alert:self];
        
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}


@end
