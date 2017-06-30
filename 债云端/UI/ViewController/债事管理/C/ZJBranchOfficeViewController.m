//
//  ZJBranchOfficeViewController.m
//  债云端
//
//  Created by apple on 2017/5/4.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBranchOfficeViewController.h"

@interface ZJBranchOfficeViewController ()

@end

@implementation ZJBranchOfficeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([_typeTitle isEqualToString:@"xinjiang"]) {
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"新疆"];
    }else if ([_typeTitle isEqualToString:@"xizang"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"西藏"];
    }else if ([_typeTitle isEqualToString:@"beijing"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"北京"];
    }else if ([_typeTitle isEqualToString:@"tianjin"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"天津"];
    }else if ([_typeTitle isEqualToString:@"heilongjiang"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"黑龙江"];
    }else if ([_typeTitle isEqualToString:@"jilin"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"吉林"];
    }else if ([_typeTitle isEqualToString:@"liaoning"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"辽宁"];
    }else if ([_typeTitle isEqualToString:@"neimenggu"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"内蒙古"];
    }else if ([_typeTitle isEqualToString:@"hebei"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"河北"];
    }else if ([_typeTitle isEqualToString:@"henan"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"河南"];
    }else if ([_typeTitle isEqualToString:@"shandong"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"山东"];
    }else if ([_typeTitle isEqualToString:@"shanxitaiyuan"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"山西"];
    }else if ([_typeTitle isEqualToString:@"shanxixian"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"陕西"];
    }else if ([_typeTitle isEqualToString:@"ningxia"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"宁夏"];
    }else if ([_typeTitle isEqualToString:@"gansu"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"甘肃"];
    }else if ([_typeTitle isEqualToString:@"qinghai"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"青海"];
    }else if ([_typeTitle isEqualToString:@"sichuan"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"四川"];
    }else if ([_typeTitle isEqualToString:@"yunnan"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"云南"];
    }else if ([_typeTitle isEqualToString:@"chongqing"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"重庆"];
    }else if ([_typeTitle isEqualToString:@"hubei"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"湖北"];
    }else if ([_typeTitle isEqualToString:@"hunan"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"湖南"];
    }else if ([_typeTitle isEqualToString:@"guizhou"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"贵州"];
    }else if ([_typeTitle isEqualToString:@"jiangsu"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"江苏"];
    }else if ([_typeTitle isEqualToString:@"anhui"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"安徽"];
    }else if ([_typeTitle isEqualToString:@"shanghai"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"上海"];
    }else if ([_typeTitle isEqualToString:@"zhejiang"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"浙江"];
    }else if ([_typeTitle isEqualToString:@"jiangxi"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"江西"];
    }else if ([_typeTitle isEqualToString:@"fujian"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"福建"];
    }else if ([_typeTitle isEqualToString:@"guangdong"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"广东"];
    }else if ([_typeTitle isEqualToString:@"guangxi"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"广西"];
    }else if ([_typeTitle isEqualToString:@"hainan"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"海南"];
    }else if ([_typeTitle isEqualToString:@"xianggang"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"香港"];
    }else if ([_typeTitle isEqualToString:@"aomen"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"澳门"];
    }else if ([_typeTitle isEqualToString:@"taiwan"]){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"台湾"];
    }
    
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
