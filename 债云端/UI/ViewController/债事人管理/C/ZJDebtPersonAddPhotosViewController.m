//
//  ZJDebtPersonAddPhotosViewController.m
//  债云端
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJDebtPersonAddPhotosViewController.h"
#import "TakePhoto.h"     //选取照片
#import "NPPicPreviewController.h"   //图片预览
#import "QBImagePickerController.h"
#import "ZJDataRequest.h"
#import "ZJAddDebtPersonController.h"
#import "ZJPersonDebtInfomationViewController.h"
#import "ZJCompanyDebtInfomationViewController.h"
#import "ZJAddDebtInformationViewController.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <Photos/Photos.h>
#import "ZJAddPhotosViewController.h"
#define kImageView_W   (ZJAPPWidth - 45 - 30) / 3
#define kImageToImageWidth   45/2
@interface ZJDebtPersonAddPhotosViewController ()<TakePhotoDelegate,QBImagePickerControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *BigScrollview;
@end

@implementation ZJDebtPersonAddPhotosViewController
{
    NSMutableArray * images;  //图片数组
    NSMutableArray * urlimages;  //图片url数组
    UIButton *selectPicForShineIV;
    UIButton *SaveBtn;
    
    NSMutableDictionary * addDebtVoDic;   //增加债事人
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"添加照片"];
    [ZJNavigationPublic setRightButtonOnTargetNav:self action:@selector(backHomePage) image:[UIImage imageNamed:@"return-home"] HighImage:[UIImage imageNamed:@"return-home"]];
    images=[NSMutableArray array];
    urlimages=[NSMutableArray array];
    
    addDebtVoDic=[NSMutableDictionary dictionary];
    [self createHeaderView];
    
}
// 返回首页
-(void)backHomePage
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
/**
 *  创建UI
 */
- (void)createHeaderView {
    
    _BigScrollview.top=0;
    _BigScrollview.left=0;
    _BigScrollview.width=ZJAPPWidth;
    _BigScrollview.height=ZJAPPHeight;
    
    selectPicForShineIV = [UIButton buttonWithType:UIButtonTypeCustom];
    selectPicForShineIV.frame=CGRectMake(15,20, kImageView_W, kImageView_W);
    [selectPicForShineIV addTarget:self action:@selector(selectPicForShineButtonAction) forControlEvents:UIControlEventTouchUpInside];
    selectPicForShineIV.tag = 1000;
    if (_Phototype==1){
        [selectPicForShineIV setBackgroundImage:[UIImage imageNamed:@"ZJAddPhotosDebtPerson"] forState:UIControlStateNormal];
    }else if (_Phototype==2){
        [selectPicForShineIV setBackgroundImage:[UIImage imageNamed:@"ZJAddPhotosDebtCompany"] forState:UIControlStateNormal];
    }
    
    [_BigScrollview addSubview:selectPicForShineIV];
    
    
    _BigScrollview.contentSize = CGSizeMake(ZJAPPWidth,selectPicForShineIV.bottom+10);
    
    SaveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    SaveBtn.frame=CGRectMake(45, selectPicForShineIV.bottom+50, ZJAPPWidth-90, 35);
    [SaveBtn addTarget:self action:@selector(savePhotosAction) forControlEvents:UIControlEventTouchUpInside];
    SaveBtn.tag = 1001;
    SaveBtn.backgroundColor=ZJColor_red;
    [SaveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [SaveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    SaveBtn.layer.masksToBounds=YES;
    SaveBtn.layer.cornerRadius=4;
    SaveBtn.titleLabel.font=ZJ_FONT(15);
    [_BigScrollview addSubview:SaveBtn];
}

/**
 *  九宫格
 *
 */
- (void)createNineImageView:(NSArray *)imageArr {
    for (UIView *subView in _BigScrollview.subviews) {
        if ([subView isKindOfClass:[UIButton class]] && subView.tag != 1000&& subView.tag != 1001) {
            [subView removeFromSuperview];
        }
    }
    for (UIView *subView in _BigScrollview.subviews) {
        if ([subView isKindOfClass:[UIImageView class]] && subView.tag != 1000&& subView.tag != 1001) {
            [subView removeFromSuperview];
        }
    }
    
    for (UIImage *newImage in imageArr) {
        NSUInteger i = [imageArr indexOfObject:newImage];
        UIImageView * imageView=[[UIImageView alloc] initWithFrame:CGRectMake(15 + (i % 3) * (kImageView_W + kImageToImageWidth), 20 + (i / 3) * (kImageView_W + kImageToImageWidth), kImageView_W, kImageView_W)];
        UIButton *imageButton = [[UIButton alloc] initWithFrame:CGRectMake(15 + (i % 3) * (kImageView_W + kImageToImageWidth), 20 + (i / 3) * (kImageView_W + kImageToImageWidth), kImageView_W, kImageView_W)];
        imageView.image=newImage;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [imageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        imageButton.backgroundColor=[UIColor clearColor];
        imageButton.tag = 250 + i;
        [_BigScrollview addSubview:imageView];
        [_BigScrollview addSubview:imageButton];
        UIButton *delegateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        delegateBtn.frame =CGRectMake(15 + (i % 3) * (kImageView_W + kImageToImageWidth)+(kImageView_W-25/2), 20 + (i / 3) * (kImageView_W + kImageToImageWidth)-25/2, 25, 25);
        [delegateBtn setImage:[UIImage imageNamed:@"loadIamgeDelete"] forState:UIControlStateNormal];
        delegateBtn.tag = 100000+i;
        [delegateBtn addTarget:self action:@selector(touchDelegateBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_BigScrollview addSubview:delegateBtn];
        
        
    }
    if (imageArr.count % 3 == 0) {
        selectPicForShineIV.frame = CGRectMake(15,20 + imageArr.count / 3 * (kImageView_W + kImageToImageWidth), kImageView_W, kImageView_W);
    } else {
        selectPicForShineIV.frame = CGRectMake(15 + (imageArr.count % 3) * (kImageView_W + kImageToImageWidth), 20 + imageArr.count / 3 * (kImageView_W + kImageToImageWidth), kImageView_W, kImageView_W);
    }
    if (images.count==9) {
        selectPicForShineIV.hidden=YES;
        _BigScrollview.contentSize=CGSizeMake(0, selectPicForShineIV.top);
        SaveBtn.top=selectPicForShineIV.top+30;
    }else{
        selectPicForShineIV.hidden=NO;
        _BigScrollview.contentSize=CGSizeMake(0, selectPicForShineIV.bottom+10);
        SaveBtn.top=selectPicForShineIV.bottom+50;
    }
    
    
}
/**
 *  删除图片
 */
-(void)touchDelegateBtn:(UIButton *)button
{
    [images removeObjectAtIndex:button.tag-100000];
    [self createNineImageView:images];
}
/**
 *  图片点击事件
 */
- (void)imageButtonAction:(UIButton *)button
{
    NPPicPreviewController *picPreviewVC = [[NPPicPreviewController alloc] init];
    picPreviewVC.images = images;
    picPreviewVC.offsetX = ZJAPPWidth*(button.tag-250);
    [self.navigationController pushViewController:picPreviewVC animated:NO];
}

//添加照片
-(void)selectPicForShineButtonAction
{
    UIActionSheet * act =[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择相册",@"选择相机", nil];
    
    [act showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        if (![self isCanUsePhotos]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"相册访问权限受限" message:@"请在iPhone的\"设置->隐私->相册\"选项中,允许\"债云端\"访问您的相册." delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:@"取消",nil];
            [alert show];
            return;
        }else{
            QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.allowsMultipleSelection =YES;
            imagePickerController.maximumNumberOfSelection = 9;
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
            [self presentViewController:navigationController animated:YES completion:NULL];
        }
        
    }else if (buttonIndex==1){
        if (![self isCanUsevideos]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"相机访问权限受限" message:@"请在iPhone的\"设置->隐私->相机\"选项中,允许\"债云端\"访问您的相机." delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
            return;
        }else{
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController * pickerImage=[[UIImagePickerController alloc]init];
                pickerImage.delegate = self;
                pickerImage.allowsEditing=NO;
                pickerImage.sourceType=UIImagePickerControllerSourceTypeCamera;//指定使用相机
                ;
                
                [self presentViewController:pickerImage animated:YES completion:nil];
                
            }
        }
    }
}

- (BOOL)isCanUsePhotos {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
        if (author == kCLAuthorizationStatusRestricted || author == kCLAuthorizationStatusDenied) {
            //无权限
            return NO;
        }
    }
    else {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted ||
            status == PHAuthorizationStatusDenied) {
            //无权限
            return NO;
        }
    }
    return YES;
}
- (BOOL)isCanUsevideos {
    
    AVAuthorizationStatus authorStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authorStatus == AVAuthorizationStatusRestricted ||authorStatus == AVAuthorizationStatusDenied){
        //获取权限
        return NO;
    }
    return YES;
}
#pragma mark - QBImagePickerControllerDelegate
#pragma mark  该方法在调用相册选取照片、调用相机拍摄完照片或者视频点击use时都会执行
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    //获得拍摄或者通过相册选取的原始照片
    UIImage * originalImage=[info valueForKey:UIImagePickerControllerOriginalImage];
    //把原始或者经过编辑的照片存于相机胶卷册(if判断确保了不会把从相册里面拿出的照片再次保存到相册)
    if (picker.sourceType==UIImagePickerControllerSourceTypeCamera) {
        //保存照片
        if ([[info valueForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeImage]) {
            
            UIImageWriteToSavedPhotosAlbum(originalImage,self , @selector(image:didFinishSavingWithError:contextInfo:), nil);//在你存入相册完成后不需要有任何操作时，后面三个参数可以为空,nil为可选参数，即contextInfo
        }
        
    }
    if (images.count>8) {
        UIAlertView * alteview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"最多只能添加九张图片" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alteview show];
        return;
    }
    [images addObject:originalImage];
    [self createNineImageView:images];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)image:(UIImage *)image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    
    
}

#pragma mark - QBImagePickerControllerDelegate
//单张选取图片调用
- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(ALAsset *)asset
{
    [self dismissImagePickerController];
}
//多张选取图片回调
- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    DLog(@"%@",assets);
    if (assets.count+images.count>9) {
        UIAlertView * alteview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"最多只能添加九张图片" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alteview show];
        return;
    }
    for (ALAsset * asset in assets) {
        //获取图片的路径
        //        NSString * nsALAssetPropertyAssetURL = [ asset    valueForProperty:ALAssetPropertyAssetURL ] ;
        ALAssetRepresentation *assetRep = [asset defaultRepresentation];
        CGImageRef imgRef = [assetRep fullResolutionImage];   //获取高清图片
        UIImage *img = [UIImage imageWithCGImage:imgRef  scale:assetRep.scale                        orientation:(UIImageOrientation)assetRep.orientation];
        // 压缩图片
        //        UIImage * newiamge=[ZJUtil uploadStandardImage:img];
        [images addObject:img];
    }
    [self createNineImageView:images];
    [self dismissImagePickerController];
}
//取消按钮
- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [self dismissImagePickerController];
}
- (void)dismissImagePickerController
{
    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else {
        [self.navigationController popToViewController:self animated:YES];
    }
}
#pragma mark  takephoto
/**
 *  单个选取照片的delegate
 */
- (void)takePhotoFinish:(UIImage *)image
{
    
    [images addObject:image];
    [self createNineImageView:images];
    
}

//保存
- (void)savePhotosAction
{
    if (images.count>0) {
        [self showProgress];
        [[ZJDataRequest shareInstance]imagepostDataWithURLString:@"api/image" andParameters:nil imageArray:images timeOut:20 requestSecret:YES resultSecret:YES resultWithBlock:^(BOOL success, id responseData) {
            [self dismissProgress];
            if (success) {
                if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"] ) {
                    urlimages=[responseData objectForKey:@"data"];
                    [self postinfoDebtPerson];
                }else{
                    [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
                }
            }else{
                [ZJUtil showBottomToastWithMsg:@"上传失败"];
            }
        }];
    }else{
        [self postinfoDebtPerson];
    }
}
//添加债事人
- (void)postinfoDebtPerson
{
    if (_Phototype==1) {
        [self.debtPersonDict setObject:urlimages forKey:@"picList"];
        [addDebtVoDic setObject:self.debtPersonDict forKey:@"debtPerson"];
        [addDebtVoDic setObject:@"1" forKey:@"type"];
        if ([_isower isEqualToString:@"1"]) {
            [addDebtVoDic setObject:@"1" forKey:@"isOwer"];
        }else{
            [addDebtVoDic setObject:@"2" forKey:@"isOwer"];
        }
    }else if (_Phototype==2){
        [self.debtCompanyDict setObject:urlimages forKey:@"picList"];
        [addDebtVoDic setObject:self.debtCompanyDict forKey:@"debtCompany"];
        [addDebtVoDic setObject:@"2" forKey:@"type"];
        if ([_isower isEqualToString:@"1"]) {
            [addDebtVoDic setObject:@"1" forKey:@"isOwer"];
        }else{
            [addDebtVoDic setObject:@"2" forKey:@"isOwer"];
        }
    }
    [self showProgress];
    [ZJDebtPersonRequest postAddDebtPersonInfoRequestWithParms:addDebtVoDic result:^(BOOL success, id responseData) {
        [self dismissProgress];
        if (success) {
            DLog(@"%@",responseData);
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                //刷新债事人管理列表
                NSNotification *notication=[NSNotification notificationWithName:@"AddDebtPerson" object:nil];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notication];
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
                if ([self.fromWhereto isEqualToString:@"addDebtInfo"]) {
                    [ZJUtil showBottomToastWithMsg:@"创建债事人成功，返回到债事备案"];
                    
                    if ([_isower isEqualToString:@"1"]) {
                        ZJAddPhotosViewController * homeVC=[[ZJAddPhotosViewController alloc]init];
                        for (ZJBaseViewController * controller in self.navigationController.viewControllers) { //遍历
                            if ([controller isKindOfClass:[homeVC class]]) { //这里判断是否为你想要跳转的页面
                                [self.navigationController popToViewController:controller animated:YES]; //跳转
                            }
                        }
                    }else{
                        ZJAddDebtInformationViewController * homeVC=[[ZJAddDebtInformationViewController alloc]init];
                        for (ZJBaseViewController * controller in self.navigationController.viewControllers) { //遍历
                            if ([controller isKindOfClass:[homeVC class]]) { //这里判断是否为你想要跳转的页面
                                [self.navigationController popToViewController:controller animated:YES]; //跳转
                            }
                        }
                    }
                    
                }else{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }else{
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:responseData];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
