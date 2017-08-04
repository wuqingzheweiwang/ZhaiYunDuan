//
//  ZJTeacherGraceController.m
//  债云端
//
//  Created by 赵凯强 on 2017/8/4.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJSearchTeacherGraceController.h"
#import "ZJTeacherGraceTableCell.h"

@interface ZJSearchTeacherGraceController ()<UISearchBarDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZJSearchTeacherGraceController
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
    SearchTable.delegate = self;
    SearchTable.dataSource = self;
    SearchTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    SearchTable.showsVerticalScrollIndicator = NO;
    [SearchTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, ZJAPPWidth, 10)]];
    [SearchTable setTableHeaderView:[[UIView alloc] initWithFrame:CGRectZero]];
    //刷新
    __weak ZJSearchTeacherGraceController *weakSelf = self;
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
    NSString * action1=[NSString stringWithFormat:@"api/imagetext/getImageTextSearch?ps=10&pn=%ld&wd=%@",(long)_page,searchBarTextString];
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
                    ZJTeacherGraceModel * item=[ZJTeacherGraceModel itemForDictionary:[itemarray objectAtIndex:i]];
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
    
    return [ZJTeacherGraceTableCell getCellHeight];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str  =@"vsd";
    ZJTeacherGraceTableCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJAnswerQuestionCell" owner:self options:nil]firstObject];
    }
    // 取消选中效果
    [cell setitem:[_dataSource objectAtIndex:indexPath.row]];
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
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




