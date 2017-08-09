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
@interface ZJSearchImageTextViewController ()<UISearchBarDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZJSearchImageTextViewController
{
    __weak IBOutlet UITableView *SearchTable;
    NSMutableArray * _dataSource;
    NSInteger _page;
    NSString * searchBarTextString;
    UISearchBar * searchheBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    searchheBar=[ZJNavigationPublic setNavSearchViewOnTargetNav:self With:@"请输入您要搜索的标题/内容"];
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
    if ([ZJUtil isKGEmpty:searchBarTextString]) {
        [ZJUtil showBottomToastWithMsg:@"请输入您要搜索的标题/内容"];
        [SearchTable.mj_header endRefreshing];
        [SearchTable.mj_footer endRefreshing];
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
        [ZJUtil showBottomToastWithMsg:@"请输入您要搜索的标题/内容"];
        [SearchTable.mj_header endRefreshing];
        [SearchTable.mj_footer endRefreshing];
        return;
    }
    _page+=1;
    [self requestTeacherClassInfo];
}

-(void)requestTeacherClassInfo
{
    [searchheBar resignFirstResponder];
    NSString * action1=[NSString stringWithFormat:@"api/imagetext/getImageTextSearch?ps=10&pn=%ld&wd=%@&videoId=%@",(long)_page,searchBarTextString,self.butType];
    NSString *utf = [action1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZJHomeRequest zjGetSearchVideoRequestWithActions:utf result:^(BOOL success, id responseData) {
        DLog(@"%@",responseData);
        if (success) {
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                if (_page==1) {
                   [_dataSource removeAllObjects];
                }
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
    searchBarTextString=searchBar.text;
    if ([ZJUtil isKGEmpty:searchBarTextString]) {
        [ZJUtil showBottomToastWithMsg:@"请输入您要搜索的标题/内容"];
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
    [searchheBar resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
