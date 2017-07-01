//
//  ZJMyMemberViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/6/23.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJMyMemberViewController.h"
#import "ZJMyPageItem.h"
#import "ZJMyMmberTableViewCell.h"
@interface ZJMyMemberViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger  _page;
}
@property (nonatomic ,strong) NSMutableArray *tabledataSource;
@property (nonatomic ,strong) UITableView *tableView;

@end

@implementation ZJMyMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavcaition];
    [self.view addSubview:self.tableView];

    [self setMyMemberViewUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self requestMyMemberListInfo];
}
-(void)setNavcaition
{
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"我的会员"];
    [ZJNavigationPublic setLeftButtonOnTargetNav:self action:@selector(leftAction) With:[UIImage imageNamed:@"back"]];
}

-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)setMyMemberViewUI
{
    [self.view addSubview:self.tableView];
    //刷新
    __weak ZJMyMemberViewController *weakSelf = self;
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadFirstData];
    }];
    
    //加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];

}

-(void)reloadFirstData
{
    //@weakify(self) 防止循环引用
    //@strongify(self) 防止指针消失
    _page=1;
    [self requestMyMemberListInfo];
}
-(void)loadMoreData
{
    _page+=1;
    [self requestMyMemberListInfo];
}

// 我的会员网络请求
- (void)requestMyMemberListInfo
{
    NSString * action=[NSString stringWithFormat:@"api/my/tuijianhuiyuan?ps=10&pn=%ld",(long)_page];
    
    [ZJMyPageRequest GETMyMemberListRequestWithActions:action result:^(BOOL success, id responseData) {
     
        [self performSelectorOnMainThread:@selector(showProgress) withObject:self waitUntilDone:YES];
        
        if (success) {
            
            [self performSelectorOnMainThread:@selector(dismissProgress) withObject:self waitUntilDone:YES];
            
            if (_page==1) {
                
                [self.tabledataSource removeAllObjects];
                
            }
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                
                NSLog(@"%@",responseData);
                
                NSArray * itemarray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                for (int i=0; i<itemarray.count; i++) {
                    ZJReMyMemberHomeItem * item=[ZJReMyMemberHomeItem itemForDictionary:[itemarray objectAtIndex:i]];
                    
                    [self.tabledataSource addObject:item];
                }
                [self.tableView reloadData];
                
            }else{
                [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"%@",[responseData objectForKey:@"message"]]];
            }
            
        }else{
            [ZJUtil showBottomToastWithMsg:@"请求失败"];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
       
          }];
    
    }
     

-(NSMutableArray *)tabledataSource
{
    if (_tabledataSource == nil) {
        _tabledataSource = [NSMutableArray array];

    }
    return _tabledataSource;
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return _tableView;
}

#pragma mark TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tabledataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str  =@"vsd";

    ZJMyMmberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJMyMmberTableViewCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.ImageFlagLabel.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    [cell setitem:[self.tabledataSource objectAtIndex:indexPath.row]];

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [ZJMyMmberTableViewCell getCellHeight];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
