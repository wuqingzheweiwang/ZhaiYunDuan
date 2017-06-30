//
//  ZJCapitalAndDemandInfoDetailViewController.m
//  债云端
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJCapitalAndDemandInfoDetailViewController.h"
#import "ZJCapitalAndDemandDetailTableViewCell.h"
#define kImageView_W   (ZJAPPWidth - 45 - 30) / 3
#define kImageToImageWidth   45/2
@interface ZJCapitalAndDemandInfoDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZJCapitalAndDemandInfoDetailViewController
{
    __weak IBOutlet UITableView *DebtTableview;
    NSMutableArray * keyArray;
    NSMutableArray * imageArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (_Btntype==ZJCapitalAndDemandTypeCapital) {
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"资产详细信息"];
    }else if (_Btntype==ZJCapitalAndDemandTypeDemand){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"需求详细信息"];
    }
    imageArray=[NSMutableArray array];
    keyArray=[NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    DebtTableview.top=0;
    DebtTableview.left=0;
    DebtTableview.width=ZJAPPWidth;
    DebtTableview.height=ZJAPPHeight;
    DebtTableview.showsVerticalScrollIndicator = NO;
    DebtTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [DebtTableview setTableHeaderView:[[UIView alloc] initWithFrame:CGRectZero]];
    [DebtTableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
  
    [self requestData];
}
#pragma mark  tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return keyArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZJCapitalAndDemandDetailTableViewCell getCellHeight:[keyArray objectAtIndex:indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"identity_ID";
    
    ZJCapitalAndDemandDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJCapitalAndDemandDetailTableViewCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    [cell setitem:[keyArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)requestData
{
    NSString * action=[NSString string];
    if (_Btntype==ZJCapitalAndDemandTypeCapital) {
        action=[NSString stringWithFormat:@"api/asset/detail?id=%@&flag=%@",self.capitalID,@"0"];
    }else if (_Btntype==ZJCapitalAndDemandTypeDemand){
        action=[NSString stringWithFormat:@"api/demand/detail?demandid=%@",self.capitalID];
    }
    [self showProgress];
    [ZJDebtPersonRequest GetDebtPersonCapitalDetailRequestWithActions:action result:^(BOOL success, id responseData) {
        NSLog(@"%@",responseData);
        [self dismissProgress];
        if (success) {
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                
                if (_Btntype==ZJCapitalAndDemandTypeCapital) {
                    NSDictionary * dict=[responseData objectForKey:@"data"];
                    if ([dict objectForKey:@"name"]) {  //资产名称
                        [keyArray removeObjectAtIndex:0];
                        [keyArray insertObject:[NSString stringWithFormat:@"资产名称：%@",[dict objectForKey:@"name"]] atIndex:0];
                    }
                    if ([dict objectForKey:@"tangible"]) {   //资产性质分类
                        if ([[dict objectForKey:@"tangible"] integerValue]==1) {
                            [keyArray removeObjectAtIndex:1];
                            [keyArray insertObject:[NSString stringWithFormat:@"资产性质分类：有形资产"] atIndex:1];
                        }else if ([[dict objectForKey:@"tangible"] integerValue]==0){
                            [keyArray removeObjectAtIndex:1];
                            [keyArray insertObject:[NSString stringWithFormat:@"资产性质分类：无形资产"] atIndex:1];
                        }
                    }
                    if ([dict objectForKey:@"totalAmout"]) {   //总价值
                        [keyArray removeObjectAtIndex:2];
                        [keyArray insertObject:[NSString stringWithFormat:@"总价值：%@",[dict objectForKey:@"totalAmout"]] atIndex:2];
                    }
                    if ([dict objectForKey:@"assetNum"]) {   //资产数量
                        [keyArray removeObjectAtIndex:3];
                        [keyArray insertObject:[NSString stringWithFormat:@"资产数量：%@",[dict objectForKey:@"assetNum"]] atIndex:3];
                    }
                    if ([dict objectForKey:@"tradeableAssets"]) {   //可流通资产价值
                        [keyArray removeObjectAtIndex:4];
                        [keyArray insertObject:[NSString stringWithFormat:@"可流通资产价值：%@",[dict objectForKey:@"tradeableAssets"]] atIndex:4];
                    }
                    if ([dict objectForKey:@"assetCredential"]) {   //资产凭证
                        [keyArray removeObjectAtIndex:5];
                        [keyArray insertObject:[NSString stringWithFormat:@"资产凭证：%@",[dict objectForKey:@"assetCredential"]] atIndex:5];
                    }
                    if ([dict objectForKey:@"assetDetails"]) {    //资产详情
                        [keyArray removeObjectAtIndex:6];
                        [keyArray insertObject:[NSString stringWithFormat:@"资产详情：%@",[dict objectForKey:@"assetDetails"]] atIndex:6];
                    }
                    if ([dict objectForKey:@"mortgage"]) {   //抵押等数量和价值
                        [keyArray removeObjectAtIndex:7];
                        [keyArray insertObject:[NSString stringWithFormat:@"抵押等数量和价值：%@",[dict objectForKey:@"mortgage"]] atIndex:7];
                    }
                    if ([dict objectForKey:@"isLawsuit"]) {   //是否已诉讼
                        if ([[dict objectForKey:@"isLawsuit"] integerValue]==1) {
                            [keyArray removeObjectAtIndex:8];
                            [keyArray insertObject:@"诉讼情况：已诉讼" atIndex:8];
                        }else if ([[dict objectForKey:@"isLawsuit"] integerValue]==0){
                            [keyArray removeObjectAtIndex:8];
                            [keyArray insertObject:@"诉讼情况：未诉讼" atIndex:8];
                        }
                    }
                    if ([dict objectForKey:@"currentAsset"]) {   //流通资产
                        [keyArray removeObjectAtIndex:9];
                        [keyArray insertObject:[NSString stringWithFormat:@"流通资产：%@",[dict objectForKey:@"currentAsset"]] atIndex:9];
                    }
                    if ([dict objectForKey:@"belongTo"]) {   //归属人
                        [keyArray removeObjectAtIndex:10];
                        [keyArray insertObject:[NSString stringWithFormat:@"归属人：%@",[dict objectForKey:@"belongTo"]] atIndex:10];
                    }
                    if ([dict objectForKey:@"location"]) {   //所在位置
                        [keyArray removeObjectAtIndex:11];
                        [keyArray insertObject:[NSString stringWithFormat:@"所在位置：%@",[dict objectForKey:@"location"]] atIndex:11];
                    }
                    if ([dict objectForKey:@"phoneNumber"]) {   //联系电话
                        [keyArray removeObjectAtIndex:12];
                        [keyArray insertObject:[NSString stringWithFormat:@"联系电话：%@",[dict objectForKey:@"phoneNumber"]] atIndex:12];
                    }
                    if ([dict objectForKey:@"restrictReasion"]) {   //限制流通原因
                        [keyArray removeObjectAtIndex:13];
                        [keyArray insertObject:[NSString stringWithFormat:@"限制流通原因：%@",[dict objectForKey:@"restrictReasion"]] atIndex:13];
                    }
                    if ([dict objectForKey:@"mortgageTarget"]) {   //质押对象
                        [keyArray removeObjectAtIndex:14];
                        [keyArray insertObject:[NSString stringWithFormat:@"质押对象：%@",[dict objectForKey:@"mortgageTarget"]] atIndex:14];
                    }
                    if ([dict objectForKey:@"restrictWorth"]) {   //限制流通价值
                        [keyArray removeObjectAtIndex:15];
                        [keyArray insertObject:[NSString stringWithFormat:@"限制流通价值：%@",[dict objectForKey:@"restrictWorth"]] atIndex:15];
                    }
                    if ([dict objectForKey:@"restrictNum"]) {   //限制流通负债量
                        [keyArray removeObjectAtIndex:16];
                        [keyArray insertObject:[NSString stringWithFormat:@"限制流通负债量：%@",[dict objectForKey:@"restrictNum"]] atIndex:16];
                    }
                    if ([dict objectForKey:@"picList"]) {
                        imageArray=[dict objectForKey:@"picList"];
                    }
                    if (imageArray.count>0) {
                        UIView * imageBackView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, 0)];
                        for (int i=0; i<imageArray.count; i++) {
                            NSString * newImage=[imageArray objectAtIndex:i];
                            UIImageView * imageView=[[UIImageView alloc] initWithFrame:CGRectMake(15 + (i % 3) * (kImageView_W + kImageToImageWidth), 20 + (i / 3) * (kImageView_W + kImageToImageWidth), kImageView_W, kImageView_W)];
                            [imageView sd_setImageWithURL:[NSURL URLWithString:newImage] placeholderImage:[UIImage imageNamed:@"backGroundDefault"]];
                            imageView.contentMode = UIViewContentModeScaleAspectFill;
                            imageView.clipsToBounds = YES;
                            [imageBackView addSubview:imageView];
                            imageBackView.bottom=imageView.bottom+20;
                        }
                        DebtTableview.tableFooterView=imageBackView;
                    }
                    [DebtTableview reloadData];
                }else if (_Btntype==ZJCapitalAndDemandTypeDemand){
                    NSDictionary * dict=[[responseData objectForKey:@"data"] objectForKey:@"item"];
                    if ([dict objectForKey:@"name"]) {  //资产名称
                        [keyArray removeObjectAtIndex:0];
                        [keyArray insertObject:[NSString stringWithFormat:@"资产名称：%@",[dict objectForKey:@"name"]] atIndex:0];
                    }
                    if ([dict objectForKey:@"tangible"]) {   //资产性质分类
                        if ([[dict objectForKey:@"tangible"] integerValue]==1) {
                            [keyArray removeObjectAtIndex:1];
                            [keyArray insertObject:[NSString stringWithFormat:@"资产性质分类：有形资产"] atIndex:1];
                        }else if ([[dict objectForKey:@"tangible"] integerValue]==0){
                            [keyArray removeObjectAtIndex:1];
                            [keyArray insertObject:[NSString stringWithFormat:@"资产性质分类：无形资产"] atIndex:1];
                        }
                    }
                    if ([dict objectForKey:@"totalAmout"]) {   //总价值
                        [keyArray removeObjectAtIndex:2];
                        [keyArray insertObject:[NSString stringWithFormat:@"总价值：%@",[dict objectForKey:@"totalAmout"]] atIndex:2];
                    }
                    if ([dict objectForKey:@"assetNum"]) {   //资产数量
                        [keyArray removeObjectAtIndex:3];
                        [keyArray insertObject:[NSString stringWithFormat:@"资产数量：%@",[dict objectForKey:@"assetNum"]] atIndex:3];
                    }
                    [DebtTableview reloadData];
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
