//
//  ZJDataRequest.m
//  债云端
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJDataRequest.h"
#import "AFNetWorking.h"
#import "CheckNetwork.h"
#import "DESEncryptFile.h"
#import "AFHTTPSessionManager.h"
#define NAPAIURL      @"http://www.wdcsoc.com/"
#define APP_SYSTEM    @"4"
#define NAPAIVERSION  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

@implementation ZJDataRequest

//  单例模式
+(id)shareInstance
{
    static ZJDataRequest* dataCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (dataCenter == nil)
        {
            dataCenter = [[ZJDataRequest alloc] init];
        }
    });
    return dataCenter;
}

#pragma mark
#pragma mark ========== 基本请求方法

-(void)getDataWithURLString:(NSString*) _action
              andParameters:(NSDictionary*) _para
                    timeOut:(double) _timeOut
              requestSecret:(BOOL)isRequestSecret
               resultSecret:(BOOL)isResultSecret
            resultWithBlock:(result) _finishBlock

{
    if (![CheckNetwork isExistenceNetwork]) {
        _finishBlock(NO,@"当前没有可用网络");
        return;
    }
    if (!_action || [_action length] == 0)
    {
        _finishBlock(NO,@"请求地址不能为空");
        return;
    }
    UIApplication * app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    NSDictionary * parameter = _para;
    if (isRequestSecret) {
        parameter = [self encoding:_para];
    }
    NSString * requestHTTP = [self requestHttpURL:_action];
    AFHTTPSessionManager * ma = [AFHTTPSessionManager manager];
    
//    [ma setSecurityPolicy:[self customSecurityPolicy]];    //验证https证书
   
    ma.requestSerializer = [AFJSONRequestSerializer serializer];
    ma.responseSerializer = [AFJSONResponseSerializer serializer];
    ma.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"application/json", @"text/html", @"text/plain", nil];
    [ma.requestSerializer setValue:[ZJUserInfo getUserIDForUserToken] forHTTPHeaderField:@"Authorization"];
    [ma GET:requestHTTP parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        app.networkActivityIndicatorVisible = NO;
        if (isResultSecret) {
            _finishBlock(YES,responseObject);
        }else _finishBlock(YES,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        app.networkActivityIndicatorVisible = NO;
        _finishBlock(NO,@"网络请求数据错误");
    }];
    
}

-(void)postDataWithURLString:(NSString*) _action
               andParameters:(NSDictionary*) _para
                   andIsJson:(BOOL)_isjosn
                     timeOut:(double) _timeOut
               requestSecret:(BOOL)isRequestSecret
                resultSecret:(BOOL)isResultSecret
             resultWithBlock:(result) _finishBlock
{
    if (![CheckNetwork isExistenceNetwork]) {
        _finishBlock(NO,@"当前没有可用网络");
        return;
    }
    if (!_action || [_action length] == 0)
    {
        _finishBlock(NO,@"请求地址不能为空");
        return;
    }
    
    UIApplication * app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    NSDictionary * parameter = _para;
    
    if (isRequestSecret) {
        parameter = [self encoding:_para];
    }
    NSString * requestHTTP = [self requestHttpURL:_action];
    
    
    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:requestHTTP parameters:parameter error:nil];
    
    AFHTTPSessionManager * manage = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:requestHTTP]];
    
//    [manage setSecurityPolicy:[self customSecurityPolicy]];
    if (_isjosn) {
        manage.requestSerializer = [AFJSONRequestSerializer serializer];
    }else{
        manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    [manage.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"application/json", @"text/html",@"text/plain", nil];
    [manage.requestSerializer setValue:[ZJUserInfo getUserIDForUserToken] forHTTPHeaderField:@"Authorization"];
    [manage POST:@"" parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        app.networkActivityIndicatorVisible = NO;
        if (isResultSecret) {
            _finishBlock(YES,responseObject);
        }else _finishBlock(YES,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _finishBlock(NO,@"网络请求数据错误");
    }];
}

//图片上传
-(void)imagepostDataWithURLString:(NSString*) _action
               andParameters:(NSDictionary*) _para
                  imageArray:(NSArray * )_imageArray
                     timeOut:(double) _timeOut
               requestSecret:(BOOL)isRequestSecret
                resultSecret:(BOOL)isResultSecret
             resultWithBlock:(result) _finishBlock
{

    if (![CheckNetwork isExistenceNetwork]) {
        _finishBlock(NO,@"当前没有可用网络");
        return;
    }
    if (!_action || [_action length] == 0)
    {
        _finishBlock(NO,@"请求地址不能为空");
        return;
    }
    UIApplication * app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    NSDictionary * parameter = _para;

    NSString * requestHTTP = [self requestHttpURL:_action];

    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:requestHTTP parameters:parameter error:nil];
   
    AFHTTPSessionManager * manage = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:requestHTTP]];
    //调出请求头
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    //json
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/octet-stream",@"image/jpg",@"image/png",@"text/plain",@"multipart/form-data",@"text/json",nil];
    //将token封装入请求头
    [manage.requestSerializer setValue:[ZJUserInfo getUserIDForUserToken] forHTTPHeaderField:@"Authorization"];
   //parameter为nil
    [manage POST:@"" parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<_imageArray.count; i++) {
            UIImage * _image=[_imageArray objectAtIndex:i];
            NSData *imageData = UIImageJPEGRepresentation(_image, 1);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg"];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _finishBlock(YES,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _finishBlock(NO,@"网络请求数据错误");
    }];
    
}



#pragma 拼接http
- (NSString *)requestHttpURL:(NSString *)action
{
    return [NSString stringWithFormat:@"http://192.168.2.11:8056/%@",action];
}


#pragma
#pragma 参数编解码
- (NSDictionary *)encoding:(NSDictionary *)dic
{
    NSMutableDictionary* paramters = [NSMutableDictionary dictionaryWithDictionary:dic];
    [paramters setObject:@"encodind" forKey:@"encodind"];
    return paramters;
}

#pragma mark
#pragma mark - 解码

+ (NSDictionary*)dictionaryWithEncodingData:(NSData*)data {
    NSString* base64Str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSMutableDictionary* dic = [[NSJSONSerialization JSONObjectWithData:[base64Str dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:NSJSONReadingAllowFragments
                                                                  error:&error] mutableCopy];
    return dic;
}

#pragma mark
#pragma mark - 编码

+ (NSString*)getEncodingStr:(NSDictionary*)dictionary {
    NSString* jsonParameters = [self getJsonWith:dictionary];
    
    NSString* finialStr = [DESEncryptFile base64StringFromText:jsonParameters withKey:@"napai505"];
    return finialStr;
}

#pragma mark
#pragma mark - 将dictionary转化为json字符串

+ (NSString*)getJsonWith:(NSDictionary*)dic {
    NSString *json = @"";
    if ([NSJSONSerialization isValidJSONObject:dic]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        if(!error) {
            json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    
    return json;
}

// https
//- (AFSecurityPolicy *)customSecurityPolicy
//{
//    //先导入证书，找到证书的路径
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"api.napai.cn" ofType:@"cer"];
//    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
//    
//    //AFSSLPinningModeCertificate 使用证书验证模式
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    
//    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
//    //如果是需要验证自建证书，需要设置为YES
//    securityPolicy.allowInvalidCertificates = NO;
//    
//    //validatesDomainName 是否需要验证域名，默认为YES；
//    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
//    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
//    //如置为NO，建议自己添加对应域名的校验逻辑。
//    securityPolicy.validatesDomainName = YES;
//    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
//    securityPolicy.pinnedCertificates = set;
//    
//    return securityPolicy;
//}
//
@end
