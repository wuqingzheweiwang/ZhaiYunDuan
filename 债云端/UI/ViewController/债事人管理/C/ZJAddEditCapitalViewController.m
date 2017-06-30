//
//  ZJAddEditCapitalViewController.m
//  债云端
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJAddEditCapitalViewController.h"
#import "ZJAddEditCapitalTableViewCell.h"
#import "ZJAddPhotosViewController.h"
@interface ZJAddEditCapitalViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation ZJAddEditCapitalViewController
{
    __weak IBOutlet UITableView *DebtTable;
    
    __weak IBOutlet UIView *tableFooterview;
    __weak IBOutlet UIButton *SaveBtn;
    
    NSMutableArray * keyArray;
    NSMutableArray * valueArray;
    
    
    CGFloat scrollViewOffSetY;
    CGFloat remainingDistanceY;
    CGFloat beforeMigrationY;//键盘
    
    NSArray * iamgeArray;//用来接收编辑的图片
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (_Btntype==1) {
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"新增资产信息"];
    }else if (_Btntype==2){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"编辑资产信息"];
    }
    [self createUI];
    iamgeArray=[NSArray array];
    keyArray=[NSMutableArray arrayWithObjects:@"资产名称：",@"资产性质分类：",@"总价值：",@"资产数量：",@"可流通资产价值：",@"资产凭证：",@"资产详情：",@"抵押等数量和价值：",@"诉讼情况：",@"流通资产：",@"归属人：",@"所在位置：",@"联系电话：",@"限制流通原因：",@"质押对象：",@"限制流通价值：",@"限制流通负债量：", nil];
    valueArray=[NSMutableArray arrayWithObjects:@"",@"0",@"",@"",@"",@"",@"",@"",@"0",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    if (_Btntype==ZJCapitalEdit) {
        [self requestData];
    }
    
    
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [DebtTable addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;//加上这句不会影响你 tableview
    
}
//编辑   资产详情
- (void)requestData
{
    NSString * action=[NSString stringWithFormat:@"api/asset/detail?id=%@&flag=%@",self.capitalId,@"0"];
    [self showProgress];
    [ZJDebtPersonRequest GetDebtPersonCapitalDetailRequestWithActions:action result:^(BOOL success, id responseData) {
        [self dismissProgress];
        if (success) {
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                NSDictionary * dict=[responseData objectForKey:@"data"];
                if ([dict objectForKey:@"name"]) {  //资产名称
                    [valueArray removeObjectAtIndex:0];
                    [valueArray insertObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]] atIndex:0];
                }
                if ([dict objectForKey:@"tangible"]) {   //资产性质分类
                    if ([[dict objectForKey:@"tangible"] integerValue]==1) {
                        [valueArray removeObjectAtIndex:1];
                        [valueArray insertObject:@"1" atIndex:1];
                    }else if ([[dict objectForKey:@"tangible"] integerValue]==0){
                        [valueArray removeObjectAtIndex:1];
                        [valueArray insertObject:@"0" atIndex:1];
                    }
                }
                if ([dict objectForKey:@"totalAmout"]) {   //总价值
                    [valueArray removeObjectAtIndex:2];
                    [valueArray insertObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"totalAmout"]] atIndex:2];
                }
                if ([dict objectForKey:@"assetNum"]) {   //资产数量
                    [valueArray removeObjectAtIndex:3];
                    [valueArray insertObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"assetNum"]] atIndex:3];
                }
                if ([dict objectForKey:@"tradeableAssets"]) {   //可流通资产价值
                    [valueArray removeObjectAtIndex:4];
                    [valueArray insertObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"tradeableAssets"]] atIndex:4];
                }
                if ([dict objectForKey:@"assetCredential"]) {   //资产凭证
                    [valueArray removeObjectAtIndex:5];
                    [valueArray insertObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"assetCredential"]] atIndex:5];
                }
                if ([dict objectForKey:@"assetDetails"]) {    //资产详情
                    [valueArray removeObjectAtIndex:6];
                    [valueArray insertObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"assetDetails"]] atIndex:6];
                }
                if ([dict objectForKey:@"mortgage"]) {   //抵押等数量和价值
                    [valueArray removeObjectAtIndex:7];
                    [valueArray insertObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"mortgage"]] atIndex:7];
                }
                if ([dict objectForKey:@"isLawsuit"]) {   //是否已诉讼
                    if ([[dict objectForKey:@"isLawsuit"] integerValue]==1) {
                        [valueArray removeObjectAtIndex:8];
                        [valueArray insertObject:@"1" atIndex:8];
                    }else if ([[dict objectForKey:@"isLawsuit"] integerValue]==0){
                        [valueArray removeObjectAtIndex:8];
                        [valueArray insertObject:@"0" atIndex:8];
                    }
                }
                if ([dict objectForKey:@"currentAsset"]) {   //流通资产
                    [valueArray removeObjectAtIndex:9];
                    [valueArray insertObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"currentAsset"]] atIndex:9];
                }
                if ([dict objectForKey:@"belongTo"]) {   //归属人
                    [valueArray removeObjectAtIndex:10];
                    [valueArray insertObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"belongTo"]] atIndex:10];
                }
                if ([dict objectForKey:@"location"]) {   //所在位置
                    [valueArray removeObjectAtIndex:11];
                    [valueArray insertObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"location"]] atIndex:11];
                }
                if ([dict objectForKey:@"phoneNumber"]) {   //联系电话
                    [valueArray removeObjectAtIndex:12];
                    [valueArray insertObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"phoneNumber"]] atIndex:12];
                }
                if ([dict objectForKey:@"restrictReasion"]) {   //限制流通原因
                    [valueArray removeObjectAtIndex:13];
                    [valueArray insertObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"restrictReasion"]] atIndex:13];
                }
                if ([dict objectForKey:@"mortgageTarget"]) {   //质押对象
                    [valueArray removeObjectAtIndex:14];
                    [valueArray insertObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"mortgageTarget"]] atIndex:14];
                }
                if ([dict objectForKey:@"restrictWorth"]) {   //限制流通价值
                    [valueArray removeObjectAtIndex:15];
                    [valueArray insertObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"restrictWorth"]] atIndex:15];
                }
                if ([dict objectForKey:@"restrictNum"]) {   //限制流通负债量
                    [valueArray removeObjectAtIndex:16];
                    [valueArray insertObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"restrictNum"]] atIndex:16];
                }
                if ([[dict objectForKey:@"picList"] count]>0) {
                    iamgeArray=[dict objectForKey:@"picList"];
                }
                
                [DebtTable reloadData];
            }else{
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:responseData];
        }
    }];
}

//下一步
- (IBAction)TouchSaveBtnAction:(id)sender {
    if ([[valueArray objectAtIndex:0]isEqualToString:@""]) {
        [ZJUtil showBottomToastWithMsg:@"请输入资产名称"];
        return;
    }else if ([[valueArray objectAtIndex:2]isEqualToString:@""]){
        [ZJUtil showBottomToastWithMsg:@"请输入总价值"];
        return;
    }else if ([[valueArray objectAtIndex:3]isEqualToString:@""]){
        [ZJUtil showBottomToastWithMsg:@"请输入资产数量"];
        return;
    }else if ([[valueArray objectAtIndex:4]isEqualToString:@""]){
        [ZJUtil showBottomToastWithMsg:@"请输入可流通资产价值"];
        return;
    }else if ([[valueArray objectAtIndex:5]isEqualToString:@""]){
        [ZJUtil showBottomToastWithMsg:@"请输入资产凭证"];
        return;
    }else if ([[valueArray objectAtIndex:6]isEqualToString:@""]){
        [ZJUtil showBottomToastWithMsg:@"请输入资产详情"];
        return;
    }

    NSMutableDictionary * dict=[NSMutableDictionary dictionary];
    
    if (self.personId.length>0) {
        [dict setValue:self.personId forKey:@"debtId"];
    }else if (self.companyId.length>0){
        [dict setValue:self.companyId forKey:@"debtId"];
    }
    [dict setValue:[valueArray objectAtIndex:0] forKey:@"name"];//资产名称
    [dict setValue:[valueArray objectAtIndex:1] forKey:@"tangible"];//资产性质分类
    [dict setValue:[valueArray objectAtIndex:2] forKey:@"totalAmout"];//总价值
    [dict setValue:[valueArray objectAtIndex:3] forKey:@"assetNum"];//资产数量
    [dict setValue:[valueArray objectAtIndex:4] forKey:@"tradeableAssets"];//可流通资产价值
    [dict setValue:[valueArray objectAtIndex:5] forKey:@"assetCredential"];//资产凭证
    [dict setValue:[valueArray objectAtIndex:6] forKey:@"assetDetails"];//资产详情
    [dict setValue:[valueArray objectAtIndex:7] forKey:@"mortgage"];//抵押等数量和价值
    [dict setValue:[valueArray objectAtIndex:8] forKey:@"isLawsuit"];//是否已诉讼
    [dict setValue:[valueArray objectAtIndex:9] forKey:@"currentAsset"];//流通资产
    [dict setValue:[valueArray objectAtIndex:10] forKey:@"belongTo"];//归属人
    [dict setValue:[valueArray objectAtIndex:11] forKey:@"location"];//所在位置
    [dict setValue:[valueArray objectAtIndex:12] forKey:@"phoneNumber"];//联系电话
    [dict setValue:[valueArray objectAtIndex:13] forKey:@"restrictReasion"];//限制流通原因
    [dict setValue:[valueArray objectAtIndex:14] forKey:@"mortgageTarget"];//质押对象
    [dict setValue:[valueArray objectAtIndex:15] forKey:@"restrictWorth"];//限制流通价值
    [dict setValue:[valueArray objectAtIndex:16] forKey:@"restrictNum"];//限制流通负债量
    if (self.capitalId.length>0) {
        [dict setObject:self.capitalId forKey:@"id"];
    }

    ZJAddPhotosViewController * addphotosVC=[[ZJAddPhotosViewController alloc]initWithNibName:@"ZJAddPhotosViewController" bundle:nil];
    addphotosVC.Phototype=ZJAddPhotosDebtAddEditCapital;
    addphotosVC.debtCapitalDic=dict;
    addphotosVC.debtCapitalimageDic=iamgeArray;
    if (self.personId.length>0) {
        addphotosVC.debtCapitaltype=@"person";
    }else if (self.companyId.length>0){
        addphotosVC.debtCapitaltype=@"company";
    }
    [self.navigationController pushViewController:addphotosVC animated:YES];
}

//重设UI
- (void)createUI{
    
    tableFooterview.width=ZJAPPWidth;
    tableFooterview.height=83;
    SaveBtn.left=45;
    SaveBtn.top=30;
    SaveBtn.width=ZJAPPWidth-90;
    SaveBtn.height=33;
    SaveBtn.layer.masksToBounds=YES;
    SaveBtn.layer.cornerRadius=5;
    
    //table
    DebtTable.top=0;
    DebtTable.left=0;
    DebtTable.width=ZJAPPWidth;
    DebtTable.height=ZJAPPHeight;
    DebtTable.showsVerticalScrollIndicator = NO;
    DebtTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [DebtTable setTableHeaderView:[[UIView alloc] initWithFrame:CGRectZero]];
    [DebtTable setTableFooterView:tableFooterview];
    
}
#pragma mark  tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return keyArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 53;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"identity_ID";
    
    ZJAddEditCapitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJAddEditCapitalTableViewCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    cell.titleLabel.text=[keyArray objectAtIndex:indexPath.row];
    cell.InfotextFiled.text=[valueArray objectAtIndex:indexPath.row];
    if ([cell.titleLabel.text isEqualToString:@"资产名称："]) {
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"请输入资产名称";
        cell.InfotextFiled.tag=2001;
    }else if ([cell.titleLabel.text isEqualToString:@"资产性质分类："]){
        cell.InfotextFiled.userInteractionEnabled=NO;
        cell.InfotextFiled.hidden=YES;
        cell.FirstBtn.hidden=NO;
        cell.SecondBtn.hidden=NO;
        [cell.FirstBtn setTitle:@"无形资产" forState:UIControlStateNormal];
        [cell.SecondBtn setTitle:@"有形资产" forState:UIControlStateNormal];
        cell.FirstBtn.tag=3001;
        cell.SecondBtn.tag=3002;
        if ([[valueArray objectAtIndex:1]isEqualToString:@"0"]) {
            [cell.FirstBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
            [cell.SecondBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
        }else if ([[valueArray objectAtIndex:1]isEqualToString:@"1"]){
            [cell.SecondBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
            [cell.FirstBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
        }
        [cell.FirstBtn addTarget:self action:@selector(FirstBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.SecondBtn addTarget:self action:@selector(SecondBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }else if ([cell.titleLabel.text isEqualToString:@"总价值："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, cell.InfotextFiled.frame.size.height)];
        cell.InfotextFiled.rightViewMode = UITextFieldViewModeAlways;
        cell.InfotextFiled.placeholder=@"元";
        cell.InfotextFiled.keyboardType=UIKeyboardTypeNumberPad;
        cell.InfotextFiled.textAlignment=NSTextAlignmentRight;
        cell.InfotextFiled.tag=2003;
    }else if ([cell.titleLabel.text isEqualToString:@"资产数量："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"请输入资产数量";
        cell.InfotextFiled.keyboardType=UIKeyboardTypeNumberPad;
        cell.InfotextFiled.tag=2004;
    }else if ([cell.titleLabel.text isEqualToString:@"可流通资产价值："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.keyboardType=UIKeyboardTypeNumberPad;
        cell.InfotextFiled.placeholder=@"请输入可流通资产价值";
        cell.InfotextFiled.tag=2005;
    }else if ([cell.titleLabel.text isEqualToString:@"资产凭证："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"请输入资产凭证";
        cell.InfotextFiled.tag=2006;
    }else if ([cell.titleLabel.text isEqualToString:@"资产详情："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"请输入资产详情";
        cell.InfotextFiled.tag=2007;
    }else if ([cell.titleLabel.text isEqualToString:@"抵押等数量和价值："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"请输入";
        cell.InfotextFiled.keyboardType=UIKeyboardTypeNumberPad;
        cell.InfotextFiled.tag=2008;
    }else if ([cell.titleLabel.text isEqualToString:@"诉讼情况："]){
        cell.InfotextFiled.userInteractionEnabled=NO;
        cell.InfotextFiled.hidden=YES;
        cell.FirstBtn.hidden=NO;
        cell.SecondBtn.hidden=NO;
        cell.FirstBtn.width=65;
        cell.SecondBtn.width=65;
        [cell.FirstBtn setTitle:@"未诉讼" forState:UIControlStateNormal];
        [cell.SecondBtn setTitle:@"已诉讼" forState:UIControlStateNormal];
        cell.FirstBtn.tag=3003;
        cell.SecondBtn.tag=3004;
        [cell.FirstBtn addTarget:self action:@selector(FirstBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.SecondBtn addTarget:self action:@selector(SecondBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        //为了更改数据源
        if ([[valueArray objectAtIndex:8]isEqualToString:@"0"]) {
            [cell.FirstBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
            [cell.SecondBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
        }else if ([[valueArray objectAtIndex:8]isEqualToString:@"1"]){
            [cell.SecondBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
            [cell.FirstBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
        }
    }else if ([cell.titleLabel.text isEqualToString:@"流通资产："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"请输入流通资产";
        cell.InfotextFiled.keyboardType=UIKeyboardTypeNumberPad;
        cell.InfotextFiled.tag=2010;
    }else if ([cell.titleLabel.text isEqualToString:@"归属人："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"请输入归属人";
        cell.InfotextFiled.tag=2011;
    }else if ([cell.titleLabel.text isEqualToString:@"所在位置："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"请输入所在位置";
        cell.InfotextFiled.tag=2012;
    }else if ([cell.titleLabel.text isEqualToString:@"联系电话："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.keyboardType=UIKeyboardTypeNumberPad;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"请输入联系电话";
        cell.InfotextFiled.tag=2013;
    }else if ([cell.titleLabel.text isEqualToString:@"限制流通原因："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"请输入限制流通原因";
        cell.InfotextFiled.tag=2014;
    }else if ([cell.titleLabel.text isEqualToString:@"质押对象："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"请输入质押对象";
        cell.InfotextFiled.tag=2015;
    }else if ([cell.titleLabel.text isEqualToString:@"限制流通价值："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"请输入限制流通价值";
        cell.InfotextFiled.tag=2016;
    }else if ([cell.titleLabel.text isEqualToString:@"限制流通负债量："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"请输入限制流通负债量";
        cell.InfotextFiled.tag=2017;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
//无形有形资产  未诉讼已诉讼的按钮点击事件，记得更改数据源刷新
-(void)FirstBtnAction:(UIButton *)sender
{
    if (sender.tag==3001) {
        [valueArray removeObjectAtIndex:1];
        [valueArray insertObject:@"0" atIndex:1];
    }else if (sender.tag==3003){
        [valueArray removeObjectAtIndex:8];
        [valueArray insertObject:@"0" atIndex:8];
    }
    [DebtTable reloadData];
}
-(void)SecondBtnAction:(UIButton *)sender
{
    if (sender.tag==3002) {
        [valueArray removeObjectAtIndex:1];
        [valueArray insertObject:@"1" atIndex:1];
    }else if (sender.tag==3004){
        [valueArray removeObjectAtIndex:8];
        [valueArray insertObject:@"1" atIndex:8];
    }
    [DebtTable reloadData];
}
#pragma mark--键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [DebtTable setContentOffset:CGPointMake(0, scrollViewOffSetY-beforeMigrationY) animated:YES];
    beforeMigrationY = 0.0;
    if (textField.tag==2001) {   //股东名称
        [valueArray removeObjectAtIndex:0];
        [valueArray insertObject:textField.text atIndex:0];
    }else if (textField.tag==2003){//总价值
        [valueArray removeObjectAtIndex:2];
        [valueArray insertObject:textField.text atIndex:2];
    }else if (textField.tag==2004){//资产数量
        [valueArray removeObjectAtIndex:3];
        [valueArray insertObject:textField.text atIndex:3];
    }else if (textField.tag==2005){//可流通资产价值
        [valueArray removeObjectAtIndex:4];
        [valueArray insertObject:textField.text atIndex:4];
    }else if (textField.tag==2006){//资产凭证
        [valueArray removeObjectAtIndex:5];
        [valueArray insertObject:textField.text atIndex:5];
    }else if (textField.tag==2007){//资产详情
        [valueArray removeObjectAtIndex:6];
        [valueArray insertObject:textField.text atIndex:6];
    }else if (textField.tag==2008){//抵押等数量和价值
        [valueArray removeObjectAtIndex:7];
        [valueArray insertObject:textField.text atIndex:7];
    }else if (textField.tag==2010){//流通资产
        [valueArray removeObjectAtIndex:9];
        [valueArray insertObject:textField.text atIndex:9];
    }else if (textField.tag==2011){//归属人
        [valueArray removeObjectAtIndex:10];
        [valueArray insertObject:textField.text atIndex:10];
    }else if (textField.tag==2012){//所在位置
        [valueArray removeObjectAtIndex:11];
        [valueArray insertObject:textField.text atIndex:11];
    }else if (textField.tag==2013){//联系电话
        [valueArray removeObjectAtIndex:12];
        [valueArray insertObject:textField.text atIndex:12];
    }else if (textField.tag==2014){//限制流通原因
        [valueArray removeObjectAtIndex:13];
        [valueArray insertObject:textField.text atIndex:13];
    }else if (textField.tag==2015){//质押对象
        [valueArray removeObjectAtIndex:14];
        [valueArray insertObject:textField.text atIndex:14];
    }else if (textField.tag==2016){//限制流通价值
        [valueArray removeObjectAtIndex:15];
        [valueArray insertObject:textField.text atIndex:15];
    }else if (textField.tag==2017){//限制流通负债量
        [valueArray removeObjectAtIndex:16];
        [valueArray insertObject:textField.text atIndex:16];
    }
    [DebtTable reloadData];
}

-(void)hideKeyboard{
    [self.view endEditing:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    /* scrollView 的偏移量*/
    CGFloat offSetY = scrollView.contentOffset.y;
    scrollViewOffSetY = offSetY;
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    /* 获取当前cell的位置*/
    /* 我们进行层次分析
     * textView 是添加在cell上面的。所以 A =textView.superview 是cellcontentView.
     * A.superview 则是 cell
     */
    CGFloat Hieght = textField.superview.superview.frame.origin.y;
    /* 获取当前点击Cell的位置*/
    CGFloat CurrentCellY = Hieght - scrollViewOffSetY;
    /* 获取剩余高度*/
    CGFloat lastHeight = ZJAPPHeight-64 - CurrentCellY-44-64;
    
    remainingDistanceY = lastHeight;
    
    /* 获取键盘的开始高度*/
    CGFloat keyBoardStart = 271;
    if (remainingDistanceY<keyBoardStart) {
        /* 获取差值*/
        CGFloat differenceValue = keyBoardStart -remainingDistanceY;
        beforeMigrationY = differenceValue;
        [DebtTable setContentOffset:CGPointMake(0, differenceValue + scrollViewOffSetY) animated:YES];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    /* 防止错乱停止编辑*/
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//限制条件
//    else if ([[valueArray objectAtIndex:7]isEqualToString:@""]){
//        [ZJUtil showBottomToastWithMsg:@"请输入抵押等数量和价值"];
//        return;
//    }else if ([[valueArray objectAtIndex:9]isEqualToString:@""]){
//        [ZJUtil showBottomToastWithMsg:@"请输入流通资产"];
//        return;
//    }else if ([[valueArray objectAtIndex:10]isEqualToString:@""]){
//        [ZJUtil showBottomToastWithMsg:@"请输入归属人"];
//        return;
//    }else if ([[valueArray objectAtIndex:11]isEqualToString:@""]){
//        [ZJUtil showBottomToastWithMsg:@"请输入所在位置"];
//        return;
//    }else if ([[valueArray objectAtIndex:12]isEqualToString:@""]){
//        [ZJUtil showBottomToastWithMsg:@"请输入联系电话"];
//        return;
//    }else if ([[valueArray objectAtIndex:13]isEqualToString:@""]){
//        [ZJUtil showBottomToastWithMsg:@"请输入限制流通原因"];
//        return;
//    }else if ([[valueArray objectAtIndex:14]isEqualToString:@""]){
//        [ZJUtil showBottomToastWithMsg:@"请输入质押对象"];
//        return;
//    }else if ([[valueArray objectAtIndex:15]isEqualToString:@""]){
//        [ZJUtil showBottomToastWithMsg:@"请输入限制流通价值"];
//        return;
//    }else if ([[valueArray objectAtIndex:16]isEqualToString:@""]){
//        [ZJUtil showBottomToastWithMsg:@"请输入限制流通负债量"];
//        return;
//    }


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
