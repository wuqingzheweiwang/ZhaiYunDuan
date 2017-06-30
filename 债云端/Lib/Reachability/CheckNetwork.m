//
//  AppDelegate.h
//  TestJSON
//
//  Created by 刘璇 on 13-7-15.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "CheckNetwork.h"
#import "Reachability.h"
@implementation CheckNetwork
+(BOOL)isExistenceNetwork
{
	BOOL isExistenceNetwork;
	Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
			isExistenceNetwork=FALSE;
               NSLog(@"没有可用网络");
            break;
        case ReachableViaWWAN:
			isExistenceNetwork=TRUE;
               NSLog(@"有3G网络数据");
            break;
        case ReachableViaWiFi:
			isExistenceNetwork=TRUE;
              NSLog(@"连接到Wi-Fi");
            break;
    }
	return isExistenceNetwork;
}




@end
