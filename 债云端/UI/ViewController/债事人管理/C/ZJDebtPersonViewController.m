//
//  ZJDebtPersonViewController.m
//  债云端
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJDebtPersonViewController.h"
#import "ZJDebtPersonMangerTableViewCell.h"
#import "ZJAddDebtPersonController.h"
#import "ZJDebtPersonMangerItem.h"
#import "ZJCompanyDebtInfomationViewController.h"
#import "ZJPersonDebtInfomationViewController.h"
@interface ZJDebtPersonViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@end

@implementation ZJDebtPersonViewController
{
    __weak IBOutlet UITableView *DebtMangerRersonTable;//tabel
    UIView * backview;
    NSMutableArray * _dataSource;
    NSInteger  _page;
    
    BOOL SearchYES;
    UIView * seachview;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //为了 切换用户 后的刷新数据
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"DebtPersonRequest"]isEqualToString:@"0"]) {
        _page=1;
        [_dataSource removeAllObjects];
        [DebtMangerRersonTable reloadData];
        [self requestDebtPersonMangeListInfo];
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"DebtPersonRequest"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化
    _dataSource=[NSMutableArray array];
    _page=1;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"债事人管理"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isfreshData) name:@"AddDebtPerson" object:nil];
    
    if (_isPopVc) {
        [ZJNavigationPublic setLeftButtonOnTargetNav:self action:@selector(backToVc) With:[UIImage imageNamed:@"back"]];
    }
    [ZJNavigationPublic setRightButtonOnTargetNav:self action:@selector(AddDebtManagerAction) image:[UIImage imageNamed:@"add-debt-person"] HighImage:[UIImage imageNamed:@"add-debt-person"]];
    [ZJNavigationPublic setLeftButtonOnTargetNav:self action:@selector(searchInfoAction) With:[UIImage imageNamed:@"searchBar"]];
    [self createUI];
    [self createSerach];
    [self createNodataView];
    [self requestInfo];
    
}
-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"AddDebtPerson" object:nil];
}
- (void)isfreshData
{
    _page=1;
    [_dataSource removeAllObjects];
    [DebtMangerRersonTable reloadData];
    [self requestDebtPersonMangeListInfo];
}
- (void)createSerach
{
    seachview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, 40)];
    seachview.backgroundColor=[UIColor whiteColor];
    UISearchBar * searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(15, 10, ZJAPPWidth-30, 30)];
    searchBar.searchBarStyle=UISearchBarStyleMinimal;
    [searchBar setImage:[UIImage imageNamed:@"searchBargrey"]
       forSearchBarIcon:UISearchBarIconSearch
                  state:UIControlStateNormal];
    searchBar.delegate = self;
    searchBar.placeholder = @"请输入搜索的姓名或者身份证号";
    searchBar.contentMode = UIViewContentModeLeft;
    searchBar.barTintColor = [UIColor clearColor];
    searchBar.layer.cornerRadius = 15;
    searchBar.layer.masksToBounds = YES;
    searchBar.showsCancelButton=YES;
    [seachview addSubview:searchBar];
    seachview.hidden=YES;
   
}

//请求债事人列表
- (void)requestInfo
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self requestDebtPersonMangeListInfo];
}

- (void)requestDebtPersonMangeListInfo
{
    NSString * action=[NSString stringWithFormat:@"api/debt/byuser?ps=10&pn=%ld",(long)_page];
    [ZJDebtPersonRequest GetDebtPersonManageListRequestWithActions:action result:^(BOOL success, id responseData) {
        
        if (success) {
            if (_page==1) {
                [_dataSource removeAllObjects];
            }
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                NSLog(@"%@",responseData);
                
                if ([[responseData objectForKey:@"message"]isEqualToString:@"没有权限"]) {
                    backview.hidden=NO;
//                    DebtMangerRersonTable.hidden=YES;
                    [DebtMangerRersonTable reloadData];
                }else{
                    backview.hidden=YES;
                    DebtMangerRersonTable.hidden=NO;
                    NSArray * itemarray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                    for (int i=0; i<itemarray.count; i++) {
                        ZJDebtPersonMangerHomeItem * item=[ZJDebtPersonMangerHomeItem itemForDictionary:[itemarray objectAtIndex:i]];
                        [_dataSource addObject:item];
                    }
                    [DebtMangerRersonTable reloadData];
                }
            }else{
                 [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"%@",[responseData objectForKey:@"message"]]];
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }else{
            [ZJUtil showBottomToastWithMsg:@"请求失败"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [DebtMangerRersonTable.mj_header endRefreshing];
        [DebtMangerRersonTable.mj_footer endRefreshing];
    }];
}
//创建没有权限的界面
-(void)createNodataView
{
    backview=[[UIView alloc]initWithFrame:CGRectMake(0, (ZJAPPHeight-TRUE_1(115))/2, ZJAPPWidth, TRUE_1(115))];
    [self.view addSubview:backview];
    backview.hidden=YES;
    UIImageView * iconImageview=[[UIImageView alloc]initWithFrame:CGRectMake((ZJAPPWidth-TRUE_1(130))/2, 0, TRUE_1(130), TRUE_1(80))];
    iconImageview.image=[UIImage imageNamed:@"nodataicon"];
    [backview addSubview:iconImageview];
    
    UILabel * iconLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, TRUE_1(100), ZJAPPWidth, TRUE_1(15))];
    iconLabel.text=@"权限不足，升级行长可查看";
    iconLabel.textColor=ZJColor_999999;
    iconLabel.textAlignment=NSTextAlignmentCenter;
    iconLabel.font=ZJ_TRUE_FONT(14);
    [backview addSubview:iconLabel];
}
//返回页面
-(void)backToVc
{
    [self.navigationController popViewControllerAnimated:NO];
}
//搜索
-(void)searchInfoAction
{
    SearchYES=YES;
    [DebtMangerRersonTable reloadData];
    if (SearchYES) {
        seachview.hidden=NO;
    }else{
        seachview.hidden=YES;
        _page=1;
        [_dataSource removeAllObjects];
        [self requestInfo];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    NSString * action=[NSString stringWithFormat:@"api/debt/byuser?ps=10&pn=1&condition=%@",searchBar.text];
    NSString *utf = [action stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZJDebtPersonRequest GetSearchDebtPersonRequestWithActions:utf result:^(BOOL success, id responseData) {
        NSLog(@"%@",responseData);
        if (success) {
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                backview.hidden=YES;
                DebtMangerRersonTable.hidden=NO;
                [_dataSource removeAllObjects];
                NSArray * itemarray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                for (int i=0; i<itemarray.count; i++) {
                    ZJDebtPersonMangerHomeItem * item=[ZJDebtPersonMangerHomeItem itemForDictionary:[itemarray objectAtIndex:i]];
                    [_dataSource addObject:item];
                }
                [DebtMangerRersonTable reloadData];
            }else{
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:responseData];
        }
    }];

}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    SearchYES=NO;
    seachview.hidden=YES;
    searchBar.text=@"";
    _page=1;
    [_dataSource removeAllObjects];
    [self requestInfo];
    
}
//新增债事人
- (void)AddDebtManagerAction
{
    ZJAddDebtPersonController * addDebtVC=[[ZJAddDebtPersonController alloc]initWithNibName:@"ZJAddDebtPersonController" bundle:nil];
    [addDebtVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:addDebtVC animated:YES];
}
//重设UI
- (void)createUI{
    //table
    DebtMangerRersonTable.top=64;
    DebtMangerRersonTable.left=0;
    DebtMangerRersonTable.width=ZJAPPWidth;
    if (_isPopVc) {
        DebtMangerRersonTable.height=ZJAPPHeight-64;
    }else{
        DebtMangerRersonTable.height=ZJAPPHeight-64-49;
    }
    
    DebtMangerRersonTable.showsVerticalScrollIndicator = NO;
    DebtMangerRersonTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [DebtMangerRersonTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [DebtMangerRersonTable setTableHeaderView:[[UIView alloc] initWithFrame:CGRectZero]];
    //刷新
    __weak ZJDebtPersonViewController *weakSelf = self;
    DebtMangerRersonTable.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadFirstData];
    }];
    
    //加载
    DebtMangerRersonTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
}
-(void)reloadFirstData
{
    //@weakify(self) 防止循环引用
    //@strongify(self) 防止指针消失
    _page=1;
    [self requestInfo];
}
-(void)loadMoreData
{
    _page+=1;
    [self requestInfo];
}
#pragma mark  tableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (SearchYES) {
        return 40;
    }else return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (SearchYES) {
        return seachview;
    }else return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZJDebtPersonMangerTableViewCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"identity_ID";
    
    ZJDebtPersonMangerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJDebtPersonMangerTableViewCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.ImageFlagLabel.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    [cell setitem:[_dataSource objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ZJDebtPersonMangerHomeItem * item=[_dataSource objectAtIndex:indexPath.row];
    if ([item.deptType isEqualToString:@"企业"]) {
        ZJCompanyDebtInfomationViewController *companyVC=[[ZJCompanyDebtInfomationViewController alloc]initWithNibName:@"ZJCompanyDebtInfomationViewController" bundle:nil];
        companyVC.companyName=item.deptname;
        companyVC.companyId=item.deptid;
        [companyVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:companyVC animated:YES];
    }else if ([item.deptType isEqualToString:@"自然人"]){
        ZJPersonDebtInfomationViewController *personVC=[[ZJPersonDebtInfomationViewController alloc]initWithNibName:@"ZJPersonDebtInfomationViewController" bundle:nil];
        personVC.personName=item.deptname;
        personVC.personId=item.deptid;
        [personVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:personVC animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
