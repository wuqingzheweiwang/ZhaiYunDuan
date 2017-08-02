//
//  ZJDebtSearchtextViewController.m
//  债云端
//
//  Created by apple on 2017/8/2.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJDebtSearchtextViewController.h"
#import "ZJDebtMangerTableViewCell.h"
#import "ZJDebtDetailViewController.h"
#import "ZJPayMoneyViewController.h"
@interface ZJDebtSearchtextViewController ()<UITableViewDataSource,UITableViewDelegate,DebtMangerHomeDelegate,UIScrollViewDelegate>

@end

@implementation ZJDebtSearchtextViewController
{
    __weak IBOutlet UITableView *searchTable;
    NSMutableArray * _dataSource;
    NSInteger _page;
    NSString * searchBarTextString;
    UISearchBar * searchheBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    searchheBar=[ZJNavigationPublic setNavSearchViewOnTargetNav:self With:@"请输入您要搜索的姓名/推荐编码"];
    _dataSource=[NSMutableArray array];
    searchBarTextString=@"";
    _page=1;
    [self resetUI];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [searchheBar resignFirstResponder];
}
//UI布局
-(void)resetUI{
    searchTable.top=0;
    searchTable.left=0;
    searchTable.width=ZJAPPWidth;
    searchTable.height=ZJAPPHeight;
    searchTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    searchTable.showsVerticalScrollIndicator = NO;
    [searchTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, ZJAPPWidth, 10)]];
    [searchTable setTableHeaderView:[[UIView alloc] initWithFrame:CGRectZero]];
    //刷新
    __weak ZJDebtSearchtextViewController *weakSelf = self;
    searchTable.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadFirstData];
    }];
    
    //加载
    searchTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

-(void)reloadFirstData
{
    if ([ZJUtil isKGEmpty:searchBarTextString]) {
        [ZJUtil showBottomToastWithMsg:@"请输入您要搜索的姓名/推荐编码"];
        [searchTable.mj_header endRefreshing];
        [searchTable.mj_footer endRefreshing];
        return;
    }
    //@weakify(self) 防止循环引用
    //@strongify(self) 防止指针消失
    _page=1;
    [self requestTeacherClassInfo];
    
}
-(void)loadMoreData
{
    if ([ZJUtil isKGEmpty:searchBarTextString]) {
        [ZJUtil showBottomToastWithMsg:@"请输入您要搜索的姓名/推荐编码"];
        [searchTable.mj_header endRefreshing];
        [searchTable.mj_footer endRefreshing];
        return;
    }
    _page+=1;
    [self requestTeacherClassInfo];
}
-(void)requestTeacherClassInfo
{
    [searchheBar resignFirstResponder];
    NSString * action1=[NSString stringWithFormat:@"api/debtrelation/searchdebtrelation?ps=10&pn=%ld&condition=%@",(long)_page,searchBarTextString];
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
                [searchTable reloadData];
            }else{
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:responseData];
        }
        [searchTable.mj_header endRefreshing];
        [searchTable.mj_footer endRefreshing];
    }];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchBarTextString=searchBar.text;
    if ([ZJUtil isKGEmpty:searchBarTextString]) {
        [ZJUtil showBottomToastWithMsg:@"请输入您要搜索的姓名/推荐编码"];
        return;
    }
    _page=1;
    
    [self requestTeacherClassInfo];
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [searchheBar resignFirstResponder];
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
