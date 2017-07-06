//
//  ZJAddStockInfoViewController.m
//  债云端
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJAddStockInfoViewController.h"
#import "ZJAddStockTableViewCell.h"
@interface ZJAddStockInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation ZJAddStockInfoViewController
{
    __weak IBOutlet UITableView *DebtTable;
    
    __weak IBOutlet UIView *tableFooterview;
    __weak IBOutlet UIButton *SaveBtn;
    
    NSMutableArray * keyArray;    
    NSMutableArray * valueArray;

    NSInteger  _page;
    
    CGFloat scrollViewOffSetY;
    CGFloat remainingDistanceY;
    CGFloat beforeMigrationY;//键盘
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"XX公司新增股权信息"];
    keyArray=[NSMutableArray arrayWithObjects:@"股东名称：",@"股东证件号：",@"地址：",@"投资金额：",@"投资比例：",@"注册资本：",@"实到资本：", nil];
    valueArray=[NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"", nil];

    _page=1;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [DebtTable addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;//加上这句不会影响你 tableview
    [self createUI];

}
//保存
- (IBAction)TouchSaveBtnAction:(id)sender {
    if ([[valueArray objectAtIndex:0]isEqualToString:@""]) {
        [ZJUtil showBottomToastWithMsg:@"请输入股东名称"];
        return;
    }else if ([[valueArray objectAtIndex:1]isEqualToString:@""]){
        [ZJUtil showBottomToastWithMsg:@"请输入股东证件号"];
        return;
    }else if ([[valueArray objectAtIndex:2]isEqualToString:@""]){
        [ZJUtil showBottomToastWithMsg:@"请输入地址"];
        return;
    }else if ([[valueArray objectAtIndex:3]isEqualToString:@""]){
        [ZJUtil showBottomToastWithMsg:@"请输入投资金额"];
        return;
    }else if ([[valueArray objectAtIndex:4]isEqualToString:@""]){
        [ZJUtil showBottomToastWithMsg:@"请输入投资比例"];
        return;
    }else if ([[valueArray objectAtIndex:5]isEqualToString:@""]){
        [ZJUtil showBottomToastWithMsg:@"请输入注册资本"];
        return;
    }else if ([[valueArray objectAtIndex:6]isEqualToString:@""]){
        [ZJUtil showBottomToastWithMsg:@"请输入实到资本"];
        return;
    }
    
    
    [self showProgress];
    NSMutableDictionary * dict=[NSMutableDictionary dictionary];
    [dict setObject:[valueArray objectAtIndex:0] forKey:@"shareholderName"];
    [dict setObject:[valueArray objectAtIndex:1] forKey:@"shareholderCode"];
    [dict setObject:[valueArray objectAtIndex:2] forKey:@"address"];
    [dict setObject:[valueArray objectAtIndex:3] forKey:@"amount"];
    [dict setObject:[valueArray objectAtIndex:4] forKey:@"proportion"];
    [dict setObject:[valueArray objectAtIndex:5] forKey:@"registeredCapital"];
    [dict setObject:[valueArray objectAtIndex:6] forKey:@"actualCapital"];
    NSMutableDictionary * bigDic=[NSMutableDictionary dictionary];
    [bigDic setObject:dict forKey:@"equityVo"];
    [bigDic setObject:self.companyId forKey:@"debtid"];
    [ZJDebtPersonRequest postAddDebtCompanyStockInfoRequestWithParms:bigDic result:^(BOOL success, id responseData) {
        NSLog(@"%@",responseData);
        [self dismissProgress];
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
    
    ZJAddStockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJAddStockTableViewCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    cell.titleLabel.text=[keyArray objectAtIndex:indexPath.row];
    cell.InfotextFiled.text=[valueArray objectAtIndex:indexPath.row];
    if ([cell.titleLabel.text isEqualToString:@"股东名称："]) {
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"请输入真实姓名";
        cell.InfotextFiled.tag=2001;
    }else if ([cell.titleLabel.text isEqualToString:@"股东证件号："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"请输入身份证号/护照";
        cell.InfotextFiled.tag=2002;
    }else if ([cell.titleLabel.text isEqualToString:@"地址："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"请输入联系地址";
        cell.InfotextFiled.tag=2003;
    }else if ([cell.titleLabel.text isEqualToString:@"投资金额："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"元";
        cell.InfotextFiled.keyboardType=UIKeyboardTypeNumberPad;
        cell.InfotextFiled.tag=2004;
    }else if ([cell.titleLabel.text isEqualToString:@"投资比例："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"%";
        cell.InfotextFiled.tag=2005;
    }else if ([cell.titleLabel.text isEqualToString:@"注册资本："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"元";
        cell.InfotextFiled.keyboardType=UIKeyboardTypeNumberPad;
        cell.InfotextFiled.tag=2006;
    }else if ([cell.titleLabel.text isEqualToString:@"实到资本："]){
        cell.InfotextFiled.userInteractionEnabled=YES;
        cell.InfotextFiled.keyboardType=UIKeyboardTypeNumberPad;
        cell.InfotextFiled.delegate=self;
        cell.InfotextFiled.placeholder=@"元";
        cell.InfotextFiled.tag=2007;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
    }else if (textField.tag==2002){//股东证件号
        [valueArray removeObjectAtIndex:1];
        [valueArray insertObject:textField.text atIndex:1];
    }else if (textField.tag==2003){//地址
        [valueArray removeObjectAtIndex:2];
        [valueArray insertObject:textField.text atIndex:2];
    }else if (textField.tag==2004){//投资金额
        [valueArray removeObjectAtIndex:3];
        [valueArray insertObject:textField.text atIndex:3];
    }else if (textField.tag==2005){//投资比例
        [valueArray removeObjectAtIndex:4];
        [valueArray insertObject:textField.text atIndex:4];
    }else if (textField.tag==2006){//注册资本
        [valueArray removeObjectAtIndex:5];
        [valueArray insertObject:textField.text atIndex:5];
    }else if (textField.tag==2007){//实到资本
        [valueArray removeObjectAtIndex:6];
        [valueArray insertObject:textField.text atIndex:6];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
