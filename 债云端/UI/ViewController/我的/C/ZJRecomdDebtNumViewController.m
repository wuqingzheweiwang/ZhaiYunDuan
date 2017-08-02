//
//  ZJRecomdDebtNumViewController.m
//  债云端
//
//  Created by apple on 2017/8/2.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJRecomdDebtNumViewController.h"
#import "ZJDebtDetailViewController.h"
#import "ZJPayMoneyViewController.h"
#import "ZJDebtMangerTableViewCell.h"
#import "ZJDebtMangerItem.h"
@interface ZJRecomdDebtNumViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,DebtMangerHomeDelegate>

@end

@implementation ZJRecomdDebtNumViewController
{
    __weak IBOutlet UITableView *RecomdTable;
    NSMutableArray * _dataSource;
    NSInteger  _page;
    BOOL SearchYES;
    UIView * seachview;
    NSString * seachBarTextString;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [ZJNavigationPublic setTitleOnTargetNav:self title:@"推荐备案"];
    [ZJNavigationPublic setRrightButtonOnTargetNav:self action:@selector(searchInfoAction) With:[UIImage imageNamed:@"searchBar"]];
    //初始化
    _dataSource=[NSMutableArray array];
    _page=1;
    seachBarTextString=@"";
    
    [self createUI];
    [self createSerach];
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
    searchBar.placeholder = @"请输入您要搜索的姓名/推荐编码";
    searchBar.contentMode = UIViewContentModeLeft;
    searchBar.barTintColor = [UIColor clearColor];
    searchBar.layer.cornerRadius = 15;
    searchBar.layer.masksToBounds = YES;
    searchBar.showsCancelButton=YES;
    [seachview addSubview:searchBar];
    seachview.hidden=YES;
    
}
//搜索
-(void)searchInfoAction
{
    SearchYES=YES;
    [RecomdTable reloadData];
    if (SearchYES) {
        seachview.hidden=NO;
    }
}
//请求债事列表
- (void)requestDebtPersonMangeListInfo
{
    NSString * action=[NSString stringWithFormat:@"api/debtrelation/getrecommenddebtRelation?ps=5&pn=%ld",(long)_page];
    [self showProgress];
    [ZJDeBtManageRequest GetDebtManageListRequestWithActions:action result:^(BOOL success, id responseData) {
        
        if (success) {
            
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                DLog(@"%@",responseData);
                if (_page==1) {
                    [_dataSource removeAllObjects];
                }
                NSArray * itemarray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                for (int i=0; i<itemarray.count; i++) {
                    ZJDebtMangerHomeItem * item=[ZJDebtMangerHomeItem itemForDictionary:[itemarray objectAtIndex:i]];
                    [_dataSource addObject:item];
                }
                [RecomdTable reloadData];
                
            }else{
                [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"%@",[responseData objectForKey:@"message"]]];
            }
            [self dismissProgress];
        }else{
            [ZJUtil showBottomToastWithMsg:@"请求失败"];
            [self dismissProgress];
        }
        [self dismissProgress];
        [RecomdTable.mj_header endRefreshing];
        [RecomdTable.mj_footer endRefreshing];
    }];
}




-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    _page=1;
    seachBarTextString=searchBar.text;
    [self searchInfoTextRequest];
}

- (void)searchInfoTextRequest
{
    NSString * action1=[NSString stringWithFormat:@"api/debtrelation/searchdebtrelation?ps=10&pn=%ld&condition=%@",(long)_page,seachBarTextString];
    NSString *utf = [action1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZJDeBtManageRequest zjGetSearchDebtRequestWithActions:utf result:^(BOOL success, id responseData) {
        DLog(@"%@",responseData);
        if (success) {
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                if (_page==1) {
                    [_dataSource removeAllObjects];
                }
                NSArray * itemarray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                for (int i=0; i<itemarray.count; i++) {
                    ZJDebtMangerHomeItem * item=[ZJDebtMangerHomeItem itemForDictionary:[itemarray objectAtIndex:i]];
                    [_dataSource addObject:item];
                }
                [RecomdTable reloadData];
            }else{
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:responseData];
        }
        [RecomdTable.mj_header endRefreshing];
        [RecomdTable.mj_footer endRefreshing];
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
    [self requestDebtPersonMangeListInfo];
    
}

//重设UI
- (void)createUI{
    //table
    RecomdTable.top=0;
    RecomdTable.left=0;
    RecomdTable.width=ZJAPPWidth;
    RecomdTable.height=ZJAPPHeight;
    
    RecomdTable.showsVerticalScrollIndicator = NO;
    RecomdTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [RecomdTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [RecomdTable setTableHeaderView:[[UIView alloc] initWithFrame:CGRectZero]];
    //刷新
    __weak ZJRecomdDebtNumViewController *weakSelf = self;
    RecomdTable.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadFirstData];
    }];
    
    //加载
    RecomdTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
}
-(void)reloadFirstData
{
    //@weakify(self) 防止循环引用
    //@strongify(self) 防止指针消失
    _page=1;
    if (SearchYES) {
        [self searchInfoTextRequest];
    }else{
        [self requestDebtPersonMangeListInfo];
    }
    
}
-(void)loadMoreData
{
    _page+=1;
    if (SearchYES) {
        [self searchInfoTextRequest];
    }else{
        [self requestDebtPersonMangeListInfo];
    }
    
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
#pragma mark  tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZJDebtMangerTableViewCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"identity_ID";
    
    ZJDebtMangerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJDebtMangerTableViewCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.ImageFlagLabel.text= [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    cell.delegate = self;
    [cell setitem:[_dataSource objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark--DebtMangerHomeDelegate
//支付
- (void)DebtMangerHomePayActionWithItem:(ZJDebtMangerHomeItem *)item
{
    ZJPayMoneyViewController * zjDdVC=[[ZJPayMoneyViewController alloc]initWithNibName:@"ZJPayMoneyViewController" bundle:nil];
    zjDdVC.isManager=ZJisBankManegerYes;
    zjDdVC.orderid=item.debtorderid;
    zjDdVC.type=@"1";
    zjDdVC.payAmount = item.qianshu;
    [zjDdVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:zjDdVC animated:YES];
}
//查看详情
- (void)DebtMangerHomeSeeDetailActionWithItem:(ZJDebtMangerHomeItem *)item{
    ZJDebtDetailViewController * zjDdVC=[[ZJDebtDetailViewController alloc]initWithNibName:@"ZJDebtDetailViewController" bundle:nil];
    zjDdVC.DetailID=item.debtdebtid;
    zjDdVC.payAmount = item.qianshu;
    [zjDdVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:zjDdVC animated:YES];
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
