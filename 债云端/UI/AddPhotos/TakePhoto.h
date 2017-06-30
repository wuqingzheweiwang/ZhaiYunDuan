//
//  TakePhoto.h
//  ZhuoJiaRenWRF
//
//  Created by napai on 15/7/26.
//
//

@protocol TakePhotoDelegate <NSObject>

- (void)takePhotoFinish:(UIImage *)image;

@end

#import <Foundation/Foundation.h>

@interface TakePhoto : NSObject<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,strong)id<TakePhotoDelegate> delegate;

+ (id)instance;
-(void)showInViewContorller:(UIViewController *)VC;

-(void)openCamera:(UIViewController *)VC;

@end
