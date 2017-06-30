//
//  ZJDataRequest.h
//  债云端
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^result)(BOOL success, id responseData);
@interface ZJDataRequest : NSObject
/*
 *   Description 单例方法  创建此类的对象时请不要手动调用init方法 该类始终调用此单例方法进行创建
 *
 *  @return 单例对象
 */
+(id)shareInstance;

-(void)getDataWithURLString:(NSString*) _urlStr
              andParameters:(NSDictionary*) _para
                    timeOut:(double) _timeOut
              requestSecret:(BOOL)isRequestSecret
               resultSecret:(BOOL)isResultSecret
            resultWithBlock:(result) _finishBlock;

-(void)postDataWithURLString:(NSString*) _urlStr
               andParameters:(NSDictionary*) _para
                   andIsJson:(BOOL)_isjosn
                     timeOut:(double) _timeOut
               requestSecret:(BOOL)isRequestSecret
                resultSecret:(BOOL)isResultSecret
             resultWithBlock:(result) _finishBlock;

-(void)imagepostDataWithURLString:(NSString*) _action
                    andParameters:(NSDictionary*) _para
                       imageArray:(NSArray * )_imageArray
                          timeOut:(double) _timeOut
                    requestSecret:(BOOL)isRequestSecret
                     resultSecret:(BOOL)isResultSecret
                  resultWithBlock:(result) _finishBlock;
@end
