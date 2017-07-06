//
//  ZJAddEditDemandViewController.m
//  债云端
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJAddEditDemandViewController.h"
#import "ZJAddEditCapitalTableViewCell.h"
@interface ZJAddEditDemandViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation ZJAddEditDemandViewController
{
    __weak IBOutlet UITableView *DebtTable;
    
    __weak IBOutlet UIView *tableFooterview;
    __weak IBOutlet UIButton *SaveBtn;
    
    NSMutableArray * keyArray;
    NSMutableArray * valueArray;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (_Btntype==1) {
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"新增需求信息"];
    }else if (_Btntype==2){
        [ZJNavigationPublic setTitleOnTargetNav:self title:@"编辑需求信息"];
    }
    keyArray=[NSMutableArray arrayWithObjects:@"资产名称：",@"资产性质分类：",@"总价值：",@"资产数量：", nil];
    valueArray=[NSMutableArray arrayWithObjects:@"",@"0",@"",@"", nil];
    [self createUI];
    
    if (_Btntype==ZJDemandEdit) {
        [self requestDemandInfo];
    }
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [DebtTable addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;//加上这句不会影响你 tableview
    
}
- (void)requestDemandInfo
{
  NSString * action=[NSString stringWithFormat:@"api/demand/detail?demandid=%@",self.demandId];
    [self showProgress];
    [ZJDebtPersonRequest GetDebtPersonCapitalDetailRequestWithActions:action result:^(BOOL success, id responseData) {
        NSLog(@"%@",responseData);
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
                            [valueArray insertObject:[NSString stringWithFormat:@"1"] atIndex:1];
                        }else if ([[dict objectForKey:@"tangible"] integerValue]==0){
                            [valueArray removeObjectAtIndex:1];
                            [valueArray insertObject:[NSString stringWithFormat:@"0"] atIndex:1];
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
                [DebtTable reloadData];
            }else{
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:responseData];
        }
    }];
}
//保存
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
    }
    if (_Btntype==1) {
        NSMutableDictionary * dict=[NSMutableDictionary dictionary];
        [dict setValue:self.personId forKey:@"debtId"];
        [dict setValue:[valueArray objectAtIndex:0] forKey:@"name"];//资产名称
        [dict setValue:[valueArray objectAtIndex:1] forKey:@"tangible"];//资产性质分类
        [dict setValue:[valueArray objectAtIndex:2] forKey:@"totalAmout"];//总价值
        [dict setValue:[valueArray objectAtIndex:3] forKey:@"assetNum"];//资产数量
        
        NSLog(@"%@",dict);
        [self showProgress];
        [ZJDebtPersonRequest postAddDebtPersonDemandInfoRequestWithParms:dict result:^(BOOL success, id responseData) {
            [self dismissProgress];
            NSLog(@"%@",responseData);
            if (success) {
                if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                    self.block(@"fresh");
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
                }
            }else{
                [ZJUtil showBottomToastWithMsg:responseData];
            }
        }];
    }else if (_Btntype==2){
        NSMutableDictionary * dict=[NSMutableDictionary dictionary];
        [dict setObject:self.demandId forKey:@"id"];
        [dict setValue:[valueArray objectAtIndex:0] forKey:@"name"];//资产名称
        [dict setValue:[valueArray objectAtIndex:1] forKey:@"tangible"];//资产性质分类
        [dict setValue:[valueArray objectAtIndex:2] forKey:@"totalAmout"];//总价值
        [dict setValue:[valueArray objectAtIndex:3] forKey:@"assetNum"];//资产数量
        
        NSLog(@"%@",dict);
        [self showProgress];
        [ZJDebtPersonRequest postEditDebtPersonDemandInfoRequestWithParms:dict result:^(BOOL success, id responseData) {
            [self dismissProgress];
            NSLog(@"%@",responseData);
            if (success) {
                if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                    self.block(@"fresh");
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
                }
            }else{
                [ZJUtil showBottomToastWithMsg:responseData];
            }
        }];
    }
    
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
        cell.InfotextFiled.placeholder=@"元";
        cell.InfotextFiled.keyboardType=UIKeyboardTypeNumberPad;
        cell.InfotextFiled.tag=2003;
    }else if ([cell.titleLabel.text isEqualToString:@"资产数量："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"请输入资产数量";
        cell.InfotextFiled.keyboardType=UIKeyboardTypeNumberPad;
        cell.InfotextFiled.tag=2004;
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
    }
    [DebtTable reloadData];
}
-(void)SecondBtnAction:(UIButton *)sender
{
    if (sender.tag==3002) {
        [valueArray removeObjectAtIndex:1];
        [valueArray insertObject:@"1" atIndex:1];
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
   
    if (textField.tag==2001) {   //名称
        [valueArray removeObjectAtIndex:0];
        [valueArray insertObject:textField.text atIndex:0];
    }else if (textField.tag==2003){//总价值
        [valueArray removeObjectAtIndex:2];
        [valueArray insertObject:textField.text atIndex:2];
    }else if (textField.tag==2004){//资产数量
        [valueArray removeObjectAtIndex:3];
        [valueArray insertObject:textField.text atIndex:3];
    }
    [DebtTable reloadData];
}

-(void)hideKeyboard{
    [self.view endEditing:YES];
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
