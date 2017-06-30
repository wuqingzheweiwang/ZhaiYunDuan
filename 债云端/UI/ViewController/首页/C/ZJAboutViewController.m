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
    self.view.backgroundColor = [UIColor whiteColor];
    [self setZJDtaiUI];
    // 新闻请求
    [NSThread detachNewThreadSelector:@selector(loadNewsRequestData) toTarget:self withObject:nil];

}

-(void)setZJDtaiUI
{
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"中金动态"];
    [self.view addSubview:self.tableView];
}

// 新闻详情页网络请求
-(void)loadNewsRequestData
{
    NSString * action=[NSString stringWithFormat:@"resources/app/ep.news.json"];
    // 菊花
    [self performSelectorOnMainThread:@selector(showProgress) withObject:nil waitUntilDone:YES];
     [ZJHomeRequest zjGetHomeNewsRequestWithParams:action result:^(BOOL success, id responseData) {
        
         [self performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
        // 请求成功
        if (success) {
            NSLog(@"%@",responseData);
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                NSArray * newArray=[[responseData objectForKey:@"data"] objectForKey:@"news"];
                for (int i=0; i<newArray.count; i++) {
                    NSDictionary * dict=[newArray objectAtIndex:i];
                    ZJHomeNewsModel * item=[ZJHomeNewsModel itemForDictionary:dict];
                    [_tableViewdataSource addObject:item];
                }
            }
        }
        [self performSelectorOnMainThread:@selector(reloadUI) withObject:nil waitUntilDone:YES];
        
    }];
    
    
}

-(void)reloadUI
{
    [self.tableView reloadData];
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
    }
    
    return _tableView;
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
