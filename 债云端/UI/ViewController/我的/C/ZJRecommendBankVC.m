//
//  ZJRecommendBankVC.m
//  债云端
//
//  Created by 赵凯强 on 2017/6/24.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJRecommendBankVC.h"
#import "ZJMyPageItem.h"
#import "ZJReCommandBankCell.h"
@interface ZJRecommendBankVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger  _page;
}
@property (nonatomic ,strong) NSMutableArray *tabledataSource;
@property (nonatomic ,strong) UITableView *tableView;


@end

@implementation ZJRecommendBankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page=1;
    [self setNavcaition];
    [self.view addSubview:self.tableView];
    
    [self setRecommandBankViewUI];



}
-(void)viewWillAppear:(BOOL)animated
{
    [self requestRecommandBankPersonDataRequest];
}
-(void)setNavcaition
{
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"推荐行长"];
    [ZJNavigationPublic setLeftButtonOnTargetNav:self action:@selector(leftAction) With:[UIImage imageNamed:@"back"]];
}

-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)setRecommandBankViewUI
{
    [self.view addSubview:self.tableView];
    //刷新
    __weak ZJRecommendBankVC *weakSelf = self;
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
    [self requestRecommandBankPersonDataRequest];
}
-(void)loadMoreData
{
    _page+=1;
    [self requestRecommandBankPersonDataRequest];
}

// 推荐行长网络请求
- (void)requestRecommandBankPersonDataRequest
{
    NSString * action=[NSString stringWithFormat:@"api/my/tuijianhangzhang?ps=10&pn=%ld",(long)_page];

    [ZJMyPageRequest GETRecommandBankRequestWithActions:action result:^(BOOL success, id responseData) {
        
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
                    ZJRecomBankHomeItem * item=[ZJRecomBankHomeItem itemForDictionary:[itemarray objectAtIndex:i]];
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
    
    ZJReCommandBankCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJReCommandBankCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.ImageFlagLabel.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    [cell setitem:[self.tabledataSource objectAtIndex:indexPath.row]];

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [ZJReCommandBankCell getCellHeight];
    
}


@end

