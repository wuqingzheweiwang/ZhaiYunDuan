//
//  NPPicPreviewController.m
//  NaiPai
//
//  Created by xiaoqiang on 15/5/28.
//  Copyright (c) 2015年 NaiPai. All rights reserved.
//

#import "NPPicPreviewController.h"
#import "DDPhotoScrollView.h"
@interface NPPicPreviewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger indexx;
@property (nonatomic, strong) UILabel * label;


@end

@implementation NPPicPreviewController
{
    CGFloat lastScale;
    UIImageView *imageViewww;
}
- (void)viewDidLoad {
    
//            for (int i = 0;i<self.images.count;i++) {
//                if ([[self.images objectAtIndex:i]isEqual:[NSString class]]) {
//                    NSString * imageName = [self.images objectAtIndex:i];
//                    NSMutableString * mstr = [[NSMutableString alloc]initWithString:imageName];
//                    NSString * markString = @"_thumb.";
//                    
//                    if ([mstr rangeOfString:markString].location != NSNotFound) {
//                        NSRange range = [imageName rangeOfString:markString];
//                        [mstr deleteCharactersInRange:NSMakeRange(range.location, range.length-1)];
//                        [self.images setObject:mstr atIndexedSubscript:i];
//                    }
//                }
//

    [super viewDidLoad];

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.scrollView.delegate=self;
    [self.view addSubview:self.scrollView];
    self.label=[[UILabel alloc]initWithFrame:CGRectMake((ZJAPPWidth-60)/2, 20, 60, 24)];
    self.label.textAlignment=NSTextAlignmentCenter;
    self.label.alpha=0.4;
    self.label.layer.masksToBounds=YES;
    self.label.layer.cornerRadius=25/2;
    self.label.backgroundColor=[UIColor blackColor];
    self.label.textColor=[UIColor whiteColor];
    self.label.text=[NSString stringWithFormat:@"1/%ld",(unsigned long)self.images.count];
   
    [self.view addSubview:self.label];
    

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
   
    NSUInteger i = 0;
    if (self.images.count>0) {
        for (UIImage *imageName in self.images) {
            i = [self.images indexOfObject:imageName];
            DDPhotoScrollView *scrollView = [[DDPhotoScrollView alloc] initWithFrame:CGRectMake(ZJAPPWidth * i, 0, ZJAPPWidth, ZJAPPHeight) urlString:nil image:imageName showInVC:self];
            scrollView.singleTapBlock = ^{
                
                [self.navigationController popViewControllerAnimated:NO];
                
            };
            [self.scrollView addSubview:scrollView];
        }
        self.scrollView.contentSize = CGSizeMake(ZJAPPWidth * self.images.count, ZJAPPHeight/2);
    }
    if (self.urlimages.count>0) {
        for (NSString * imageName in self.urlimages) {
            i = [self.urlimages indexOfObject:imageName];
            DDPhotoScrollView *scrollView = [[DDPhotoScrollView alloc] initWithFrame:CGRectMake(ZJAPPWidth * i, 0, ZJAPPWidth, ZJAPPHeight) urlString:imageName image:nil showInVC:self];
            scrollView.singleTapBlock = ^{
                
                [self.navigationController popViewControllerAnimated:NO];
                
            };
            [self.scrollView addSubview:scrollView];
        }
        self.scrollView.contentSize = CGSizeMake(ZJAPPWidth * self.urlimages.count, ZJAPPHeight/2);
    }
    
    self.scrollView.contentOffset = CGPointMake(self.offsetX, self.scrollView.contentOffset.y);
 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.indexx=self.scrollView.contentOffset.x/ZJAPPWidth;
    if (self.images.count>0) {
        self.label.text=[NSString stringWithFormat:@"%ld/%ld",(unsigned long)(self.indexx+1),(unsigned long)self.images.count];
    }
    if (self.urlimages.count>0) {
        self.label.text=[NSString stringWithFormat:@"%ld/%ld",(unsigned long)(self.indexx+1),(unsigned long)self.urlimages.count];
    }
}
- (void)tapAction {
    [self.navigationController popViewControllerAnimated:NO];
    
}


@end
