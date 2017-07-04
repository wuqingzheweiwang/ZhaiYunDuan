//
//  ZJMyZhangDanViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/5/3.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJMyZhangDanViewController.h"
#import "ZJMyZhangDanTableViewCell.h"
#import "ZJMyPageItem.h"

@interface ZJMyZhangDanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) NSMutableArray *tableViewdataSource;
@property (nonatomic , strong) NSMutableArray *tableViewSectionHeader;
@property (nonatomic , strong) UITableView *tableView;

@end

@implementation ZJMyZhangDanViewController
{
    NSInteger  _page;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavcaition];
    [self setMyZhangDanUI];

}

-(void)viewWillAppear:(BOOL)animated
{
    [self postMyZahngDanDataRequest];
}
-(void)setNavcaition
{
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"我的账单"];
    [ZJNavigationPublic setLeftButtonOnTargetNav:self action:@selector(leftAction) With:[UIImage imageNamed:@"back"]];
}

-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)setMyZhangDanUI
{
    [self.view addSubview:self.tableView];
        //刷新
        __weak ZJMyZhangDanViewController *weakSelf = self;
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
    [self postMyZahngDanDataRequest];
}
-(void)loadMoreData
{
    _page+=1;
    [self postMyZahngDanDataRequest];
}


// 我的账单数据请求
-(void)postMyZahngDanDataRequest
{
    NSMutableDictionary * dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"",nil];
    [self performSelectorOnMainThread:@selector(showProgress) withObject:self waitUntilDone:YES];
    
    // 网络请求
    [ZJMyPageRequest zjPOSTMyZhangDanRequestWithParams:dic result:^(BOOL success, id responseData) {
        
        if (success) {
            
            [self performSelectorOnMainThread:@selector(dismissProgress) withObject:self waitUntilDone:YES];
            
        if (_page==1) {
            
                [self.tableViewdataSource removeAllObjects];
            
                        }
        if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
            
                NSLog(@"%@",responseData);
            
//            NSArray * itemarray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
//            for (int i=0; i<itemarray.count; i++) {
//                ZJMyZhangDanHomeItem * item=[ZJMyZhangDanHomeItem itemForDictionary:[itemarray objectAtIndex:i]];
//            
//                [self.tableViewdataSource addObject:item];
//                
//            }
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



-(NSMutableArray *)tableViewdataSource
{
    
    if (_tableViewdataSource == nil) {
        
        _tableViewdataSource = [NSMutableArray array];
    }
    return _tableViewdataSource;
}

-(NSMutableArray *)tableViewSectionHeader
{
    if (_tableViewSectionHeader == nil) {
        
        _tableViewSectionHeader =[NSMutableArray array];
    }
    return _tableViewSectionHeader;
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    
    return _tableView;
}

#pragma mark tableViewdelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableViewdataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.tableViewdataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str  =@"vsd";
    ZJMyZhangDanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"ZJMyZhangDanTableViewCell" owner:self options:nil]firstObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setitem:[self.tableViewdataSource objectAtIndex:indexPath.row]];

    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [ZJMyZhangDanTableViewCell getCellHeight];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, TRUE_1(80/2))];
    view.backgroundColor = ZJColor_efefef;
    UILabel *label = [[UILabel alloc]init];
    label.top = TRUE_1(25/2);
    label.left = TRUE_1(30/2);
    label.width = TRUE_1(130/2);
    label.height = TRUE_1(25/2);
    label.centerY = view.centerY;
    label.font = ZJ_FONT(15);
    label.text = self.tableViewSectionHeader[section];
    label.textColor = ZJColor_333333;
    [view addSubview:label];
 
    if (section == 0) {
        
        UIButton *dateBut = [UIButton buttonWithType:UIButtonTypeCustom];
        dateBut.top = label.top;
        dateBut.width = TRUE_1(34);
        dateBut.height = dateBut.width;
        dateBut.right = ZJAPPWidth - TRUE_1(40/2) - dateBut.width;
        dateBut.centerY = label.centerY;
        [dateBut setImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
        [view addSubview:dateBut];
    }
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TRUE_1(40);
}

@end
