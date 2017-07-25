//
//  ZJAboutViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/4/23.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJAboutViewController.h"
#import "ZJNewsDetailsViewController.h"
#import "ZJHomeNewsViewCell.h"
@interface ZJAboutViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) NSMutableArray *tableViewdataSource;
@property (nonatomic , strong) UITableView *tableView;

@end

@implementation ZJAboutViewController
{
    NSInteger _page;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _page=1;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setZJDtaiUI];
    // 新闻请求
    [self loadNewsRequestData];

}

-(void)setZJDtaiUI
{
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"中金动态"];
    [self.view addSubview:self.tableView];
}

// 新闻详情页网络请求
-(void)loadNewsRequestData
{
    NSString * action=[NSString stringWithFormat:@"/api/news/getNews?ps=10&pn=%ld",(long)_page];
    // 菊花
    [self showProgress];
     [ZJHomeRequest zjGetHomeNewsRequestWithParams:action result:^(BOOL success, id responseData) {
         NSLog(@"%@",responseData);
         [self dismissProgress];
        // 请求成功
        if (success) {
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                if (_page==1) {
                    [_tableViewdataSource removeAllObjects];
                }
                NSArray * newArray=[[responseData objectForKey:@"data"] objectForKey:@"news"];
                for (int i=0; i<newArray.count; i++) {
                    NSDictionary * dict=[newArray objectAtIndex:i];
                    ZJHomeNewsModel * item=[ZJHomeNewsModel itemForDictionary:dict];
                    [_tableViewdataSource addObject:item];
                }
            }
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
    }];
    
    
}


-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView * footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, 20)];
        footview.backgroundColor=[UIColor whiteColor];
        _tableView.tableFooterView=footview;
        __weak ZJAboutViewController *weakSelf = self;
        _tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf reloadFirstData];
        }];
        
        //加载
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreData];
        }];
    }
    
    return _tableView;
}
-(void)reloadFirstData
{
    //@weakify(self) 防止循环引用
    //@strongify(self) 防止指针消失
    _page=1;
    [self loadNewsRequestData];
    
}
-(void)loadMoreData
{
    _page+=1;
    [self loadNewsRequestData];
}

-(NSMutableArray *)tableViewdataSource
{
    if (_tableViewdataSource == nil) {
        _tableViewdataSource =[NSMutableArray array];
    }
    return _tableViewdataSource;
}

#pragma mark TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.tableViewdataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str  =@"vsd";
    ZJHomeNewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJHomeNewsViewCell" owner:self options:nil]firstObject];
    }
    // 取消选中效果
    [cell setitem:[self.tableViewdataSource objectAtIndex:indexPath.row]];
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ZJHomeNewsViewCell getCellHeight];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJNewsDetailsViewController * newsVC=[[ZJNewsDetailsViewController alloc]initWithNibName:@"ZJNewsDetailsViewController" bundle:nil];
    ZJHomeNewsModel * moder=[_tableViewdataSource objectAtIndex:indexPath.row];
    newsVC.newsurl=moder.url;
    newsVC.newstitle=@"新闻详情";
    [self.navigationController pushViewController:newsVC animated:YES];
}

@end
