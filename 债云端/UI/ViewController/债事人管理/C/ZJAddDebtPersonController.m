//
//  ZJAddDebtPersonController.m
//  债云端
//
//  Created by 赵凯强 on 2017/4/23.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJAddDebtPersonController.h"
#import "ZJDebtPersonInfoTableViewCell.h"
#import "ZJAddPhotosViewController.h"
#import <objc/runtime.h>
@interface ZJAddDebtPersonController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation ZJAddDebtPersonController
{
    __weak IBOutlet UITableView *DebtPersonTable;

    __weak IBOutlet UIView *tableHeaderview;
    __weak IBOutlet UIView *MiddlelineView;
    __weak IBOutlet UIView *redLineview1;   //红线
    __weak IBOutlet UIView *redLineView2;
    __weak IBOutlet UIButton *DebtPersonBtn;//债事人
    __weak IBOutlet UIButton *DebtCompanyBtn;//债事企业
    
    __weak IBOutlet UIView *tableFooterview;
    __weak IBOutlet UIButton *NextBtn;
    
    NSMutableArray * keyArray1;    //债事企业
    NSMutableArray * valueArray1;
    NSMutableArray * keyArray2;    //债事自然人
    NSMutableArray * valueArray2;
    NSInteger  _page;
    
    CGFloat scrollViewOffSetY;
    CGFloat remainingDistanceY;
    CGFloat beforeMigrationY;//键盘
    
    NSMutableDictionary * debtPersonDic;   //债事个人
    NSMutableDictionary * debtCompanyDic;    //债事公司
}
- (void)viewDidLoad {
    [super viewDidLoad];
    debtPersonDic=[NSMutableDictionary dictionary];
    debtCompanyDic=[NSMutableDictionary dictionary];
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"添加债事人"];
    keyArray1=[NSMutableArray arrayWithObjects:@"组织机构代码：",@"债事企业名称：",@"企业法人姓名：",@"法人身份证号：",@"所属省：",@"所属行业：",@"联系电话：",@"注册资本：",@"电子邮箱：",@"QQ：",@"微信：", nil];
    valueArray1=[NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    keyArray2=[NSMutableArray arrayWithObjects:@"身份证件号：",@"债事人名称：",@"所属省：",@"联系电话：",@"联系地址：",@"电子邮箱：",@"QQ：",@"微信：", nil];
    valueArray2=[NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
    _Btntype=ZJDebtPersonCompany;
    _page=1;
    if (self.DebtPersonNumString.length>0) {
        [valueArray1 removeObjectAtIndex:0];
        [valueArray1 insertObject:self.DebtPersonNumString atIndex:0];
        [valueArray2 removeObjectAtIndex:0];
        [valueArray2 insertObject:self.DebtPersonNumString atIndex:0];
    }
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [DebtPersonTable addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;//加上这句不会影响你 tableview
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createUI];


}
//下一步
- (IBAction)TouchNextBtnAction:(id)sender {
    if (_Btntype==ZJDebtPersonCompany) {
        if ([[valueArray1 objectAtIndex:0]isEqualToString:@""]) {
            [ZJUtil showBottomToastWithMsg:@"请输入组织机构代码"];
            return;
        }else if ([[valueArray1 objectAtIndex:1]isEqualToString:@""]){
            [ZJUtil showBottomToastWithMsg:@"请输入债事企业名称"];
            return;
        }else if ([[valueArray1 objectAtIndex:2]isEqualToString:@""]){
            [ZJUtil showBottomToastWithMsg:@"请输入企业法人姓名"];
            return;
        }else if ([[valueArray1 objectAtIndex:3]isEqualToString:@""]){
            [ZJUtil showBottomToastWithMsg:@"请输入法人身份证号"];
            return;
        }else if ([[valueArray1 objectAtIndex:4]isEqualToString:@""]){
            [ZJUtil showBottomToastWithMsg:@"请输入所属省"];
            return;
        }else if ([[valueArray1 objectAtIndex:5]isEqualToString:@""]){
            [ZJUtil showBottomToastWithMsg:@"请输入所属行业"];
            return;
        }else if ([[valueArray1 objectAtIndex:6]isEqualToString:@""]){
            [ZJUtil showBottomToastWithMsg:@"请输入联系电话"];
            return;
        }else if ([[valueArray1 objectAtIndex:7]isEqualToString:@""]){
            [ZJUtil showBottomToastWithMsg:@"请输入注册资本"];
            return;
        }
        if (![ZJUtil isMobileNo:[NSString stringWithFormat:@"%@",[valueArray1 objectAtIndex:6]]]) {
            [ZJUtil showBottomToastWithMsg:@"请输入正确的联系电话"];
            return;
        }
    }else if(_Btntype==ZJAddPhotosDebtPerson){
        if ([[valueArray2 objectAtIndex:0]isEqualToString:@""]) {
            [ZJUtil showBottomToastWithMsg:@"请输入身份证件号"];
            return;
        }else if ([[valueArray2 objectAtIndex:1]isEqualToString:@""]){
            [ZJUtil showBottomToastWithMsg:@"请输入债事人名称"];
            return;
        }else if ([[valueArray2 objectAtIndex:2]isEqualToString:@""]){
            [ZJUtil showBottomToastWithMsg:@"请输入所属省"];
            return;
        }else if ([[valueArray2 objectAtIndex:3]isEqualToString:@""]){
            [ZJUtil showBottomToastWithMsg:@"请输入联系电话"];
            return;
        }else if ([[valueArray2 objectAtIndex:4]isEqualToString:@""]){
            [ZJUtil showBottomToastWithMsg:@"请输入联系地址"];
            return;
        }
        if (![ZJUtil isMobileNo:[NSString stringWithFormat:@"%@",[valueArray2 objectAtIndex:3]]]) {
            [ZJUtil showBottomToastWithMsg:@"请输入正确的联系电话"];
            return;
        }
        
    }
    if (_Btntype==1) {  //公司
        
        [debtCompanyDic setObject:[valueArray1 objectAtIndex:0] forKey:@"organCode"];
        [debtCompanyDic setObject:[valueArray1 objectAtIndex:1] forKey:@"debtCompanyName"];
        [debtCompanyDic setObject:@"" forKey:@"provinceCode"];
        [debtCompanyDic setObject:@"" forKey:@"cityCode"];
        [debtCompanyDic setObject:@"" forKey:@"prCode"];
        [debtCompanyDic setObject:[valueArray1 objectAtIndex:2] forKey:@"legalPersonName"];
        [debtCompanyDic setObject:[valueArray1 objectAtIndex:3] forKey:@"legalPersonId"];
        [debtCompanyDic setObject:[valueArray1 objectAtIndex:5] forKey:@"category"];
        [debtCompanyDic setObject:[valueArray1 objectAtIndex:6] forKey:@"phoneNumber"];
        [debtCompanyDic setObject:[valueArray1 objectAtIndex:7] forKey:@"registeredCapital"];
        [debtCompanyDic setObject:[valueArray1 objectAtIndex:8] forKey:@"email"];
        [debtCompanyDic setObject:[valueArray1 objectAtIndex:9] forKey:@"qq"];
        [debtCompanyDic setObject:[valueArray1 objectAtIndex:10] forKey:@"weChat"];
        
    }else if (_Btntype==2){  //个人
        
        [debtPersonDic setObject:[valueArray2 objectAtIndex:0] forKey:@"idCode"];
        [debtPersonDic setObject:[valueArray2 objectAtIndex:1] forKey:@"name"];
        [debtPersonDic setObject:@"" forKey:@"provinceCode"];
        [debtPersonDic setObject:@"" forKey:@"cityCode"];
        [debtPersonDic setObject:@"" forKey:@"prCode"];
        [debtPersonDic setObject:[valueArray2 objectAtIndex:3] forKey:@"phoneNumber"];
        [debtPersonDic setObject:[valueArray2 objectAtIndex:4] forKey:@"contactAddress"];
        [debtPersonDic setObject:[valueArray2 objectAtIndex:5] forKey:@"email"];
        [debtPersonDic setObject:[valueArray2 objectAtIndex:6] forKey:@"qq"];
        [debtPersonDic setObject:[valueArray2 objectAtIndex:7] forKey:@"weChat"];
        
    }


    ZJAddPhotosViewController * addphotosVC=[[ZJAddPhotosViewController alloc]initWithNibName:@"ZJAddPhotosViewController" bundle:nil];
    if (_Btntype==ZJDebtPersonCompany) {
        addphotosVC.Phototype=ZJAddPhotosDebtCompany;
        addphotosVC.debtCompanyDict=debtCompanyDic;
    }else if (_Btntype==ZJDebtPersonPerson){
        addphotosVC.Phototype=ZJAddPhotosDebtPerson;
        addphotosVC.debtPersonDict=debtPersonDic;
    }
    addphotosVC.isower=self.isOwer;
    addphotosVC.fromWhereto=self.formwhere;
    [self.navigationController pushViewController:addphotosVC animated:YES];
}
//债事企业btn
- (IBAction)DebtCompanyAction:(id)sender {
    [DebtCompanyBtn setTitleColor:ZJColor_red forState:UIControlStateNormal];
    [DebtPersonBtn setTitleColor:ZJColor_333333 forState:UIControlStateNormal];
    _Btntype=ZJDebtPersonCompany;
    redLineview1.hidden=NO;
    redLineView2.hidden=YES;
    [DebtPersonTable reloadData];
}
//债事自然人btn
- (IBAction)DebtPersonAction:(id)sender {
    [DebtPersonBtn setTitleColor:ZJColor_red forState:UIControlStateNormal];
    [DebtCompanyBtn setTitleColor:ZJColor_333333 forState:UIControlStateNormal];
    _Btntype=ZJDebtPersonPerson;
    redLineview1.hidden=YES;
    redLineView2.hidden=NO;
    [DebtPersonTable reloadData];
}
//重设UI
- (void)createUI{
    
    tableHeaderview.top=64;
    tableHeaderview.left=0;
    tableHeaderview.width=ZJAPPWidth;
    tableHeaderview.height=45;
    
    DebtCompanyBtn.top=0;
    DebtCompanyBtn.left=0;
    DebtCompanyBtn.width=tableHeaderview.width/2;
    DebtCompanyBtn.height=tableHeaderview.height;
    
    DebtPersonBtn.top=0;
    DebtPersonBtn.left=DebtCompanyBtn.right;
    DebtPersonBtn.width=tableHeaderview.width/2;
    DebtPersonBtn.height=tableHeaderview.height;
    
    MiddlelineView.width=1;
    MiddlelineView.height=25;
    MiddlelineView.top=10;
    MiddlelineView.left=(ZJAPPWidth-1)/2;
    
    redLineview1.top=43;
    redLineView2.top=redLineview1.top;
    redLineview1.left= (tableHeaderview.width/2-100)/2;
    redLineView2.left= (tableHeaderview.width/2-100)/2+tableHeaderview.width/2;
    redLineview1.width=100;
    redLineview1.height=1;
    redLineView2.width=redLineview1.width;
    redLineView2.height=redLineview1.height;
    
    tableFooterview.width=ZJAPPWidth;
    tableFooterview.height=83;
    NextBtn.left=45;
    NextBtn.top=30;
    NextBtn.width=ZJAPPWidth-90;
    NextBtn.height=33;
    NextBtn.layer.masksToBounds=YES;
    NextBtn.layer.cornerRadius=5;
    
    
    //table
    DebtPersonTable.top=64+45;
    DebtPersonTable.left=0;
    DebtPersonTable.width=ZJAPPWidth;
    DebtPersonTable.height=ZJAPPHeight-64-45;
    DebtPersonTable.showsVerticalScrollIndicator = NO;
    DebtPersonTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [DebtPersonTable setTableHeaderView:[[UIView alloc] initWithFrame:CGRectZero]];
    [DebtPersonTable setTableFooterView:tableFooterview];
    
}
#pragma mark  tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_Btntype==1) {
       return keyArray1.count;
    }else if (_Btntype==2){
       return keyArray2.count;
    }else return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 53;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"identity_ID";
    
    ZJDebtPersonInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJDebtPersonInfoTableViewCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    if (_Btntype==1) {
        cell.titleLabel.text=[keyArray1 objectAtIndex:indexPath.row];
        cell.InfotextFiled.text=[valueArray1 objectAtIndex:indexPath.row];
        if ([cell.titleLabel.text isEqualToString:@"组织机构代码："]) {
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.placeholder=@"请输入组织机构代码";
            cell.InfotextFiled.tag=2001;
        }else if ([cell.titleLabel.text isEqualToString:@"债事企业名称："]){
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.placeholder=@"请输入债事企业名称";
            cell.InfotextFiled.tag=2002;
        }else if ([cell.titleLabel.text isEqualToString:@"企业法人姓名："]){
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.placeholder=@"请输入法人姓名";
            cell.InfotextFiled.tag=2003;
        }else if ([cell.titleLabel.text isEqualToString:@"法人身份证号："]){
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.placeholder=@"请输入法人身份证号";
            cell.InfotextFiled.tag=2004;
        }else if ([cell.titleLabel.text isEqualToString:@"所属省："]){
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.placeholder=@"请输入公司所在省份";
            cell.InfotextFiled.tag=2005;
        }else if ([cell.titleLabel.text isEqualToString:@"所属行业："]){
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.placeholder=@"请输入公司所属行业";
            cell.InfotextFiled.tag=2006;
        }else if ([cell.titleLabel.text isEqualToString:@"联系电话："]){
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.keyboardType=UIKeyboardTypeNumberPad;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.placeholder=@"请输入手机号";
            cell.InfotextFiled.tag=2007;
        }else if ([cell.titleLabel.text isEqualToString:@"注册资本："]){
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.keyboardType=UIKeyboardTypeNumberPad;
            cell.InfotextFiled.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, cell.InfotextFiled.frame.size.height)];
            cell.InfotextFiled.rightViewMode = UITextFieldViewModeAlways;
            cell.InfotextFiled.placeholder=@"元";
            cell.InfotextFiled.textAlignment=NSTextAlignmentRight;
            cell.InfotextFiled.tag=2008;
        }else if ([cell.titleLabel.text isEqualToString:@"电子邮箱："]){
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.placeholder=@"例如：zjzs@163.com";
            cell.InfotextFiled.tag=2009;
        }else if ([cell.titleLabel.text isEqualToString:@"QQ："]){
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.placeholder=@"非必填项";
            cell.InfotextFiled.tag=2010;
        }else if ([cell.titleLabel.text isEqualToString:@"微信："]){
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.placeholder=@"非必填项";
            cell.InfotextFiled.tag=2011;
        }

    }else if (_Btntype==2){
        cell.titleLabel.text=[keyArray2 objectAtIndex:indexPath.row];
        cell.InfotextFiled.text=[valueArray2 objectAtIndex:indexPath.row];
        if ([cell.titleLabel.text isEqualToString:@"身份证件号："]) {
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.placeholder=@"请输入身份证号/护照";
            cell.InfotextFiled.tag=3001;
        }else if ([cell.titleLabel.text isEqualToString:@"债事人名称："]){
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.placeholder=@"请输入真实姓名";
            cell.InfotextFiled.tag=3002;
        }else if ([cell.titleLabel.text isEqualToString:@"所属省："]){
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.placeholder=@"请输入户籍所在省份";
            cell.InfotextFiled.tag=3003;
        }else if ([cell.titleLabel.text isEqualToString:@"联系电话："]){
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.keyboardType=UIKeyboardTypeNumberPad;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.placeholder=@"请输入手机号";
            cell.InfotextFiled.tag=3004;
        }else if ([cell.titleLabel.text isEqualToString:@"联系地址："]){
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.placeholder=@"请输入地址";
            cell.InfotextFiled.tag=3005;
        }else if ([cell.titleLabel.text isEqualToString:@"电子邮箱："]){
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.placeholder=@"例如：zjzs@163.com";
            cell.InfotextFiled.tag=3006;
        }else if ([cell.titleLabel.text isEqualToString:@"QQ："]){
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.placeholder=@"非必填项";
            cell.InfotextFiled.tag=3007;
        }else if ([cell.titleLabel.text isEqualToString:@"微信："]){
            cell.InfotextFiled.userInteractionEnabled=YES;
            cell.InfotextFiled.delegate=self;
            cell.InfotextFiled.placeholder=@"非必填项";
            cell.InfotextFiled.tag=3008;
        }

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
    [DebtPersonTable setContentOffset:CGPointMake(0, scrollViewOffSetY-beforeMigrationY) animated:YES];
    beforeMigrationY = 0.0;
    if (textField.tag==2001) {   //组织机构代码
        [valueArray1 removeObjectAtIndex:0];
        [valueArray1 insertObject:textField.text atIndex:0];
    }else if (textField.tag==2002){   //债事企业名称
        [valueArray1 removeObjectAtIndex:1];
        [valueArray1 insertObject:textField.text atIndex:1];
    }else if (textField.tag==2003){   //企业法人姓名
        [valueArray1 removeObjectAtIndex:2];
        [valueArray1 insertObject:textField.text atIndex:2];
    }else if (textField.tag==2004){   //法人身份证号
        [valueArray1 removeObjectAtIndex:3];
        [valueArray1 insertObject:textField.text atIndex:3];
    }else if (textField.tag==2005){   //所属省
        [valueArray1 removeObjectAtIndex:4];
        [valueArray1 insertObject:textField.text atIndex:4];
    }else if (textField.tag==2006){   //所属行业
        [valueArray1 removeObjectAtIndex:5];
        [valueArray1 insertObject:textField.text atIndex:5];
    }else if (textField.tag==2007){   //联系电话
        [valueArray1 removeObjectAtIndex:6];
        [valueArray1 insertObject:textField.text atIndex:6];
    }else if (textField.tag==2008){   //注册资本
        [valueArray1 removeObjectAtIndex:7];
        [valueArray1 insertObject:textField.text atIndex:7];
    }else if (textField.tag==2009){   //电子邮箱
        [valueArray1 removeObjectAtIndex:8];
        [valueArray1 insertObject:textField.text atIndex:8];
    }else if (textField.tag==2010){   //QQ
        [valueArray1 removeObjectAtIndex:9];
        [valueArray1 insertObject:textField.text atIndex:9];
    }else if (textField.tag==2011){   //微信
        [valueArray1 removeObjectAtIndex:10];
        [valueArray1 insertObject:textField.text atIndex:10];
    }else if (textField.tag==3001){   //债事自然人身份证号
        [valueArray2 removeObjectAtIndex:0];
        [valueArray2 insertObject:textField.text atIndex:0];
    }else if (textField.tag==3002){   //债事人名称
        [valueArray2 removeObjectAtIndex:1];
        [valueArray2 insertObject:textField.text atIndex:1];
    }else if (textField.tag==3003){   //所属省
        [valueArray2 removeObjectAtIndex:2];
        [valueArray2 insertObject:textField.text atIndex:2];
    }else if (textField.tag==3004){   //联系电话
        [valueArray2 removeObjectAtIndex:3];
        [valueArray2 insertObject:textField.text atIndex:3];
    }else if (textField.tag==3005){   //联系地址
        [valueArray2 removeObjectAtIndex:4];
        [valueArray2 insertObject:textField.text atIndex:4];
    }else if (textField.tag==3006){   //电子邮箱
        [valueArray2 removeObjectAtIndex:5];
        [valueArray2 insertObject:textField.text atIndex:5];
    }else if (textField.tag==3007){   //QQ
        [valueArray2 removeObjectAtIndex:6];
        [valueArray2 insertObject:textField.text atIndex:6];
    }else if (textField.tag==3008){   //微信
        [valueArray2 removeObjectAtIndex:7];
        [valueArray2 insertObject:textField.text atIndex:7];
    }
    [DebtPersonTable reloadData];
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
        [DebtPersonTable setContentOffset:CGPointMake(0, differenceValue + scrollViewOffSetY) animated:YES];
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
