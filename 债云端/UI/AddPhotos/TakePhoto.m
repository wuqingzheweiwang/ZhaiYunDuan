//
//  TakePhoto.m
//  ZhuoJiaRenWRF
//
//  Created by napai on 15/7/26.
//
//

#import "TakePhoto.h"
#import <MobileCoreServices/MobileCoreServices.h>


@implementation TakePhoto
{
    UIViewController * currentVC;
    TakePhoto * take;
}
+(id)instance
{
    static TakePhoto* take = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (take == nil)
        {
            take = [[TakePhoto alloc] init];
        }
    });
    return take;
}
- (void)showInViewContorller:(UIViewController *)VC 
{
    currentVC = VC;
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"图片选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"拍照", nil];
    [sheet showInView:VC.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //相册
    if (buttonIndex == 0) {
        [self openPhotos];
    }
    //拍照
    if (buttonIndex == 1) {
        [self openCamera:currentVC];
    }
}
//打开相机拍照
-(void)openCamera:(UIViewController *)VC
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * pickerImage=[[UIImagePickerController alloc]init];
        pickerImage.delegate=self;
        pickerImage.allowsEditing=YES;
        //pickerImage.mediaTypes//默认是获取静态图片,指定摄像头获取数据的类型
        
        pickerImage.sourceType=UIImagePickerControllerSourceTypeCamera;//指定使用相机
        ;
        
        [currentVC presentViewController:pickerImage animated:YES completion:nil];
        
    }
    
    else {
//        [ANAlert showAlertWithString:@"摄像头不存在或已经损坏" andTarget:self];
    }
}

//打开相册
-(void)openPhotos
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController * pickerImage=[[UIImagePickerController alloc]init];
        pickerImage.delegate=self;
        //        pickerImage.allowsEditing=YES;
        
        //关键步骤
        pickerImage.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;//指定打开的是什么，这里打开的是照片库,不设置默认打开它
        
        [currentVC presentViewController:pickerImage animated:YES completion:nil];
    }
    
    else {
//        [ANAlert showAlertWithString:@"照片库不存在或已经损坏" andTarget:self];
    }
    
}

#pragma mark  该方法在调用相册选取照片、调用相机拍摄完照片或者视频点击use时都会执行
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    //获得拍摄或者通过相册选取的原始照片
    UIImage * originalImage=[info valueForKey:UIImagePickerControllerOriginalImage];
    
    //获得拍摄或者通过相册选取的经过编辑(move、scale)后的照片
    UIImage * editedImage=[info valueForKey:UIImagePickerControllerEditedImage];
    UIImage * savedImage=nil;
    //判断照片是否经过编辑
    if (editedImage) {
        savedImage=editedImage;
    }
    else {
        savedImage=originalImage;
    }
    
    //把原始或者经过编辑的照片显示
//    currentTX.image=savedImage;
//    currenTXImage = savedImage;
    if (self.delegate && [self.delegate respondsToSelector:@selector(takePhotoFinish:)]) {
        [self.delegate takePhotoFinish:savedImage];
    }
    
//    [ZZPublicClass setNavRightViewOnTargetNav:currentVC With:@"保存头像" action:@selector(saveImage)];
    
    //    currentTX.image=originalImage;
    
//    NSDictionary * dict=[info valueForKey:UIImagePickerControllerMediaMetadata];//当是照相机时，且是拍照时，可以获得照片相关的一些信息
    
    //把原始或者经过编辑的照片存于相机胶卷册(if判断确保了不会把从相册里面拿出的照片再次保存到相册)
    if (picker.sourceType==UIImagePickerControllerSourceTypeCamera) {
        //保存照片
        if ([[info valueForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeImage]) {
            
            UIImageWriteToSavedPhotosAlbum(originalImage,self , @selector(image:didFinishSavingWithError:contextInfo:), nil);//在你存入相册完成后不需要有任何操作时，后面三个参数可以为空,nil为可选参数，即contextInfo
        }
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark 照片保存至相机胶卷册后执行的方法(在上面的selector中调用)(帮助文档里面声明)
- (void)image:(UIImage *)image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
//    [ANAlert showAlertWithString:@"照片已保存至相册" andTarget:self];
}


#pragma mark 点击了cancel按钮后执行的方法(默认的cancel按钮是可以用的，一旦我们自己实现了该方法，就得自己调用:dismissViewControllerAnimated:YES completion:nil方法实现收回相机视图)
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
