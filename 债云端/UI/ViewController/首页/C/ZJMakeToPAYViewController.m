//
//  ZJMakeToPAYViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/5/2.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

//
//  ZJMakePayViewController.m
//  债云端
//
//  Created by 赵凯强 on 17/05/02.
//  Copyright © 2017年 赵凯强. All rights reserved.
//

#import "ZJMakeToPAYViewController.h"
//#import "PayView.h"
//#import "DetailPayView.h"
//#import "SPModel.h"
//#import "UserInfoModel.h"
//#import "AddAdressVC.h"
//#import "ModelProtected.h"
//#import "LGRequestTool.h"
//#import <MJExtension.h>
//#import "GetShippingAddressesModel.h"
//#import "Otryin.h"
#import "Order.h"
//#import "OrderDataModel.h"
//#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
//#import "DataSigner.h"

@interface ZJMakeToPAYViewController ()
{
    //    NSArray *_modelArr;
    //    NSMutableArray *idArr;
    //    //订单号model
    //    OrderDataModel *orderDataModel;
    //    //订单号
    //    NSString *theUserOrder;
}
//@property (nonatomic, strong) UITableView *tableV;
//
//@property (nonatomic, strong) PayView *payView;
//
//@property (nonatomic, strong) DetailPayView *detailPayView;
//
//

@end

@implementation ZJMakeToPAYViewController


//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self clcikPayBtn];
//    [self requestSaveShippingAdressData];
//    [self getThePathOfTheFile];
//
//  // http://api.otryin.com/otryin-api/getProductPayPage?sign=ef370ef8d2a5c5062261bdf4839b1ad4&goodsNum=1&token=2f3a5ebd7ea543508d32470c2abcb696&timestamp=1479520260590&crowFoundId=239&packageId=175&version=105000
//
//    NSString *goodsNum = self.theSpModel.price;
//    NSString *crowFoundId = self.theSpModel.crowfoundId;
//    NSString *packageId = self.theSpModel.ID;
//
//   NSMutableDictionary *theDicM = [self requestTheNetData];
//
//    [theDicM setValue:goodsNum forKey:@"goodsNum"];
//    [theDicM setValue:crowFoundId forKey:@"crowFoundId"];
//    [theDicM setValue:packageId forKey:@"packageId"];
//
//    [LGRequestTool GET:Otryin_successProductPay_api parameters:theDicM success:^(id result) {
//        NSLog(@"%@",result);
//
//        [self.tableV reloadData];
//
//
//    } failure:^(NSError *error) {
//
//
//    }];
//
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    
    
    // Do any additional setup after loading the view from its nib.
}


////点击支付按钮
//- (void)clcikPayBtn
//{
//        // 债行 和  备案的价格
//        NSString *goodsNum = self.theSpModel.price;
//        NSString *crowFoundId = self.theSpModel.crowfoundId;
//        // 债行 1 备案 2
//        NSString *packageId = self.theSpModel.ID;
//
//
//        NSMutableDictionary *theGenerateOrderDic= [self requestThePayMoneyData];
//
//        [theGenerateOrderDic setValue:goodsNum forKey:@"totalPrice"];
//        [theGenerateOrderDic setValue:crowFoundId forKey:@"crowFoundId"];
//        [theGenerateOrderDic setValue:crowFoundId forKey:@"goodsId"];
//        [theGenerateOrderDic setValue:goodsNum forKey:@"goodsType"];
//        [theGenerateOrderDic setValue:@"" forKey:@"orderRemark"];
//        [theGenerateOrderDic setValue:goodsNum forKey:@"goodsNum"];
//        [theGenerateOrderDic setValue:packageId forKey:@"packageId"];
//        [theGenerateOrderDic setValue:@"72" forKey:@"filmId"];
//        //请求订单号 接口
//        [LGRequestTool GET:@"http://api.otryin.com/otryin-api/generateOrder" parameters:theGenerateOrderDic success:^(id result) {
//            NSLog(@"%@",result);
//            NSDictionary *orderDic = result;
//            NSDictionary *orderDataDic = orderDic[@"data"];
//            //
//            theUserOrder = [orderDataDic objectForKey:@"orderCode"];
//
//            //
//           orderDataModel =  [OrderDataModel mj_objectWithKeyValues:orderDataDic];
//            [self.tableV reloadData];
//            //组装支付请求信息
//            [self getTheAliPayInfo];
//
//        } failure:^(NSError *error) {
//
//
//        }];
//
//
//    }
//
//
////
////- (void)requestSaveShippingAdressData
////{
////
////    NSDictionary *dic = [self getThePathOfTheFile];
////    NSDictionary *personalSettingsDic = dic[@"data"];
////
////    //获取token
////    NSString *token = [personalSettingsDic objectForKey:@"token"];
////    //1.获取当前时间戳
////
////    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
////    NSString *timeStr = [NSString stringWithFormat:@"%llu",recordTime];
////    NSLog(@"&&&&%@",timeStr);
////
////
////    //字符串加密
////    NSString *allStr = [NSString stringWithFormat:@"POSThttp://api.otryin.com/otryin-api/getShippingAddresses%@%@",timeStr,token];
////    NSLog(@"%@",allStr);
////    NSString *protectStr = [ModelProtected md5:allStr];
////    NSLog(@"=====%@",protectStr);
////    NSMutableDictionary *dicM = [[NSMutableDictionary alloc]initWithObjectsAndKeys:protectStr,@"sign",timeStr,@"timestamp",token,@"token",@"104030",@"version", nil];
////    [LGRequestTool POST:@"http://api.otryin.com/otryin-api/getShippingAddresses" parameters:dicM success:^(id result) {
////        NSLog(@"%@",result);
////        NSDictionary *dic = result;
//
////}
////
//////
////- (NSMutableDictionary *)requestTheNetData
////{
////    NSDictionary *dic = [self getThePathOfTheFile];
////
////    NSDictionary *personalSettingsDic = dic[@"data"];
////
////    //获取token
////    NSString *token = [personalSettingsDic objectForKey:@"token"];
////    //1.获取当前时间戳
////
////    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
////    NSString *timeStr = [NSString stringWithFormat:@"%llu",recordTime];
////    NSLog(@"&&&&%@",timeStr);
////
////    //字符串加密
////    NSString *allStr = [NSString stringWithFormat:@"GEThttp://api.otryin.com/otryin-api/getProductPayPage%@%@",timeStr,token];
////    NSLog(@"%@",allStr);
////    NSString *protectStr = [ModelProtected md5:allStr];
////    NSLog(@"=====%@",protectStr);
////    NSMutableDictionary *dicM = [[NSMutableDictionary alloc]initWithObjectsAndKeys:timeStr,@"timestamp",@"104030",@"version",token,@"token",protectStr,@"sign", nil];
////    return dicM;
////}
//- (NSMutableDictionary *)requestThePayMoneyData
//{
//    NSDictionary *dic = [self getThePathOfTheFile];
//
//    NSDictionary *personalSettingsDic = dic[@"data"];
//
//    //获取token
//    NSString *token = [personalSettingsDic objectForKey:@"token"];
//    //1.获取当前时间戳
//
//    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
//    NSString *timeStr = [NSString stringWithFormat:@"%llu",recordTime];
//    NSLog(@"&&&&%@",timeStr);
//
//    //字符串加密
//    NSString *allStr = [NSString stringWithFormat:@"GEThttp://api.otryin.com/otryin-api/generateOrder%@%@",timeStr,token];
//    NSLog(@"%@",allStr);
//    NSString *protectStr = [ModelProtected md5:allStr];
//    NSLog(@"=====%@",protectStr);
//    NSMutableDictionary *dicM = [[NSMutableDictionary alloc]initWithObjectsAndKeys:timeStr,@"timestamp",@"104030",@"version",token,@"token",protectStr,@"sign", nil];
//    return dicM;
//}
//
////- (SPModel *)unArchiveObject
////{
////    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
////    NSString *filePath = [path stringByAppendingPathComponent:@"object"];
////    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
////   NSData *data = [handle readDataToEndOfFile];
////
////    SPModel *paySpModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
////    return paySpModel;
////}
////
////本地存储的登录成功后的信息
//- (NSDictionary *)getThePathOfTheFile
//{
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    NSString *filePath = [path stringByAppendingPathComponent:@"lv.data"];
//    NSLog(@"%@",filePath);
//    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
//    NSData *data = [handle readDataToEndOfFile];
//    NSDictionary *loginSuccessDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    return loginSuccessDic;
//}
////组装请求信息
- (void)getTheAliPayInfo
{
//    NSString *privateKey = @"MIICXQIBAAKBgQCyh5Q3BVk2HoQDnqKf3YtA/mI2rYrexe6a1qJvhZsg5vyZksOgYJdrPlBOqljByDmOfFV5o56VNbNwwUslFCroLuFH0Z0f+ySEA+rGH4BPuQorMp4kNOxKVv9JwLPus26NTviiRv/2kPmx/0ehdhUqM2bBHHSXLVS30Z8TeoOx4wIDAQABAoGBAKg5bQXzej6uvoKSpnaxUZhqm60eFe8Y317zxJgFc0mrnnYvfzrOCaA6VX3qsjvXKbUDn59A+BttQKqM2PwVZt9Q5PYarVU4sq8HXiPEKwpRkv0zOnx0dWiNYxU//a3uPbHVDa40I4KsD/vcxE9yEMeLspVwcBp7OZThhD4e5pBBAkEA7J8C2pcW16h23ZRRKCHUWZYFZcoUG/zTNmNG5aEGUaDwP0/liP3XEYdxawvE9f3NwKMeiBcRF7m3fwLm/r9B0QJBAMEmn4lxvFbdMpuswteNpa3Y/MaJbdCDsftLFrdpG/PAIdI7wXPFr9ZCG2H3C6Ql0Fqcsi3MvCLN7qRN9VXmUXMCQAl5VGPsKL35wMieZ6FzuUzc9NpefO+h79L9ppkLGXWrO/NM/6O8hh/tjFz826X9w38zCMXqJoUMqowrUZRhlAECQA2fObUpzkyaAQ21m3A0TzD5kqo12wbPoufEHfAFe7EvJbN7/2K42HPV6bR5Bdsnx4/8aRyNyd7ygxgXX2wVeD0CQQDlxfZ1vWG9Twz2xKaCWlwWQoMaHY9LMaUq6KzqkrjGsFAZXdnIA9e6+pua479x/FVt7xDMoT9bmq1gtyhduyOl";
//    Order *order = [[Order alloc] init];
    
//    order.appID = @"1097011769";
//    NSString *partner = @"2088121412219915";
//    NSString *seller = @"cfmedia@otryin.com";
//    order.partner = partner;
//    order.sellerID = seller;
//    order.outTradeNO = theUserOrder; //订单ID（由商家?自?行制定）
//    order.subject = @"雏鹰"; //商品标题
//    order.body = @"ssss"; //商品描述
//    order.totalFee = [NSString stringWithFormat:@"%.2f",orderDataModel.totalPrice]; //商品价格
//    order.notifyURL = @"http://www.test.com"; //回调URL
//    
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = @"alisdkdemo";
//
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
//
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderSpec];
//
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            //【callback处理支付结果】
//            NSLog(@"reslut = %@",resultDic);
//        }];
//
//    }
//
//
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

