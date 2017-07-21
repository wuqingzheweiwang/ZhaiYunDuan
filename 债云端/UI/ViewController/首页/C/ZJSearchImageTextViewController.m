//
//  ZJSearchImageTextViewController.m
//  债云端
//
//  Created by apple on 2017/7/21.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJSearchImageTextViewController.h"
#import "ZJHomeNewsViewCell.h"
#import "ZJNewsDetailsViewController.h"
@interface ZJSearchImageTextViewController ()<UISearchBarDelegate,UIScrollViewDelegate>

@end

@implementation ZJSearchImageTextViewController
{
    __weak IBOutlet UITableView *SearchTable;
    NSMutableArray * _dataSource;
    NSInteger _page;
    NSString * searchBarTextString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [ZJNavigationPublic setNavSearchViewOnTargetNav:self With:@"请输入您要搜索的内容"];
    _dataSource=[NSMutableArray array];
    searchBarTextString=@"";
    _page=1;
     [self resetUI];
}
//UI布局
-(void)resetUI{
    SearchTable.top=0;
    SearchTable.left=0;
    SearchTable.width=ZJAPPWidth;
    SearchTable.height=ZJAPPHeight;
    SearchTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    SearchTable.showsVerticalScrollIndicator = NO;
    [SearchTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, ZJAPPWidth, 10)]];
    [SearchTable setTableHeaderView:[[UIView alloc] initWithFrame:CGRectZero]];
    //刷新
    __weak ZJSearchImageTextViewController *weakSelf = self;
    SearchTable.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadFirstData];
    }];
    
    //加载
    SearchTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

-(void)reloadFirstData
{
    //@weakify(self) 防止循环引用
    //@strongify(self) 防止指针消失
    _page=1;
    [self requestTeacherClassInfo];
    
}
-(void)loadMoreData
{
    _page+=1;
    [self requestTeacherClassInfo];
}
-(void)requestTeacherClassInfo
{
    [self.view endEditing:YES];
    NSString * action1=[NSString stringWithFormat:@"api/imagetext/getImageTextSearch?ps=10&pn=%ld&wd=%@",(long)_page,searchBarTextString];
    NSString *utf = [action1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZJHomeRequest zjGetSearchVideoRequestWithActions:utf result:^(BOOL success, id responseData) {
        DLog(@"%@",responseData);
        if (success) {
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                
                [_dataSource removeAllObjects];
                NSArray * itemarray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                for (int i=0; i<itemarray.count; i++) {
                    ZJHomeNewsModel * item=[ZJHomeNewsModel itemForDictionary:[itemarray objectAtIndex:i]];
                    [_dataSource addObject:item];
                }
                [SearchTable reloadData];
            }else{
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:responseData];
        }
        [SearchTable.mj_header endRefreshing];
        [SearchTable.mj_footer endRefreshing];
    }];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _page=1;
    searchBarTextString=searchBar.text;
    [self requestTeacherClassInfo];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    
    searchBarTextString=@"";
}
#pragma mark  tableView的代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [ZJHomeNewsViewCell getCellHeight];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str  =@"vsd";
    ZJHomeNewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJHomeNewsViewCell" owner:self options:nil]firstObject];
    }
    // 取消选中效果
    [cell setitem:[_dataSource objectAtIndex:indexPath.row]];
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ZJNewsDetailsViewController * newsVC=[[ZJNewsDetailsViewController alloc]initWithNibName:@"ZJNewsDetailsViewController" bundle:nil];
    ZJHomeNewsModel * moder=[_dataSource objectAtIndex:indexPath.row];
    newsVC.newsurl=moder.url;
    newsVC.newstitle=@"图文详情";
    [self.navigationController pushViewController:newsVC animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
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
