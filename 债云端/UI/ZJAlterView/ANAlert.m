//
//  ANAlert.m
//  AssessUploading
//
//  Created by napai on 15/6/22.
//  Copyright (c) 2015年 napai. All rights reserved.
//

#import "ANAlert.h"

@implementation ANAlert

+ (void)showAlertWithString:(NSString *)string andTarget:(UIViewController *)target
{
    if (string.length<=0) {
        string = @"数据返回不正确";
    }
    
    [ANAlert performSelectorOnMainThread:@selector(an_showAlert:) withObject:[NSArray arrayWithObjects:string,target, nil] waitUntilDone:YES];
}
+ (void)an_showAlert:(NSArray *)par
{
    NSString * string = [par objectAtIndex:0];
    UIViewController * target = [par objectAtIndex:1];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:string preferredStyle:UIAlertControllerStyleAlert];
        
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        if (popover)
        {
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
        [target presentViewController:alertController animated:YES completion:nil];
        
        [ANAlert loadedAlertView:target];
        [ANAlert performSelector:@selector(loadedAlertView:) withObject:alertController afterDelay:0.2f];
    } else{
#endif
        UIAlertView * loadingAlertView = [[UIAlertView alloc] initWithTitle:nil message:string delegate:target cancelButtonTitle:nil otherButtonTitles: nil];
        loadingAlertView.delegate=self;
        loadingAlertView.tag = 1;
        loadingAlertView.alpha = 0.1;
        [ANAlert willPresentAlertView:loadingAlertView ];
        [loadingAlertView show];
        [ANAlert performSelector:@selector(loadedAlertView:) withObject:loadingAlertView afterDelay:0.2f];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    }
#endif
}
+ (void)loadedAlertView:(id) alertView {
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
        UIAlertController * alert = (UIAlertController *)alertView;
        [ANAlert performSelector:@selector(removeAlertView:) withObject:alert afterDelay:1.0f];
    } else{
#endif
        UIAlertView * alert = (UIAlertView *)alertView;
        if (alert.tag ==1)
        {
            [ANAlert performSelector:@selector(removeAlertView:) withObject:alert afterDelay:1.0f];
        }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    }
#endif
    

}
+ (void)removeAlertView:(id) alertView {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
        UIViewController * alert = (UIViewController *)alertView;
        [alert dismissViewControllerAnimated:YES completion:nil];
    } else{
#endif
        UIAlertView * alert = (UIAlertView *)alertView;
        if (alert.tag ==1)
        {
            [alert dismissWithClickedButtonIndex:0 animated:YES];
        }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    }
#endif

}
+(void)willPresentAlertView:(id)alertView
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
        
    } else{
#endif
        UIAlertView * alert = (UIAlertView *)alertView;
        if (alert.tag ==1) {
            [alert setBounds:CGRectMake(30, 0, 230,80 )];
        }
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    }
#endif
}
@end
