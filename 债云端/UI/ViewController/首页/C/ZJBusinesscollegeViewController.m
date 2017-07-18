//
//  ZJBusinesscollegeViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/4/23.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBusinesscollegeViewController.h"
#import "ZJBusinesscolledgTableViewCell.h"
#import "ZJNewsDetailsViewController.h"
#import "ZJVideoPlayViewController.h"
#import "ZJHomeItem.h"
@interface ZJBusinesscollegeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *hederImageView;

@property (weak, nonatomic) IBOutlet UIButton *videoClassBut;

@property (weak, nonatomic) IBOutlet UIButton *ImageTextClassBut;

@end

@implementation ZJBusinesscollegeViewController
{
    __weak IBOutlet UITableView * _bussinesscollegeTable;
    NSMutableArray * _dataSource;
    NSInteger  _page;

}
- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化
    _dataSource=[NSMutableArray array];
    _page=1;
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self creatUI];
}

-(void)creatUI
{
    
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"商学院"];
    
    _hederImageView.top = 0;
    _hederImageView.left = 0;
    _hederImageView.width = ZJAPPWidth;
    _hederImageView.height = TRUE_1(450/2);
    _hederImageView.backgroundColor = [UIColor whiteColor];
    
    _videoClassBut.top = TRUE_1(30/2);
    _videoClassBut.left = TRUE_1(75/2);
    _videoClassBut.width = ZJAPPWidth - _videoClassBut.left*2;
    _videoClassBut.height = (TRUE_1(460/2) - TRUE_1(30/2)*2-TRUE_1(20/2))/2;
    _ImageTextClassBut.top =  _videoClassBut.bottom+TRUE_1(20/2);
    _ImageTextClassBut.left = _videoClassBut.left;
    _ImageTextClassBut.width = _videoClassBut.width;
    _ImageTextClassBut.height = _videoClassBut.height;
    
    _bussinesscollegeTable.top=64;
    _bussinesscollegeTable.left=0;
    _bussinesscollegeTable.width=ZJAPPWidth;
    _bussinesscollegeTable.height=ZJAPPHeight;
    _bussinesscollegeTable.delegate = self;
    _bussinesscollegeTable.dataSource = self;
    _bussinesscollegeTable.showsVerticalScrollIndicator = NO;
    _bussinesscollegeTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    _bussinesscollegeTable.tableHeaderView = _hederImageView;
    //刷新
    __weak ZJBusinesscollegeViewController *weakSelf = self;
    _bussinesscollegeTable.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadFirstData];
    }];
    
    //加载
    _bussinesscollegeTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];

}
//刷新
-(void)reloadFirstData
{
    _page=1;
    //@weakify(self) 防止循环引用
    //@strongify(self) 防止指针消失
    [self requestBussinesSchoolListInfo];
    
}
-(void)loadMoreData
{
    _page+=1;
    [self requestBussinesSchoolListInfo];
}


- (void)requestBussinesSchoolListInfo
{
   NSString *action=[NSString stringWithFormat:@"api/debtrelation?ps=5&pn=%ld&issolution=%d",(long)_page,0];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ZJDeBtManageRequest GetDebtManageListRequestWithActions:action result:^(BOOL success, id responseData) {
        
        DLog(@"%@",responseData);
        if (success) {
            if (_page==1) {
                [_dataSource removeAllObjects];
            }
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                
                NSArray * itemarray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                for (int i=0; i<itemarray.count; i++) {
                    ZJBusinessSchoolModel * item=[ZJBusinessSchoolModel itemForDictionary:[itemarray objectAtIndex:i]];
                    [_dataSource addObject:item];
                }
                [_bussinesscollegeTable reloadData];
            }else{
                [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"%@",[responseData objectForKey:@"message"]]];
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [ZJUtil showBottomToastWithMsg:@"请求失败"];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [_bussinesscollegeTable.mj_header endRefreshing];
        [_bussinesscollegeTable.mj_footer endRefreshing];
    }];
}

#pragma mark  tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZJBusinesscolledgTableViewCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"identity_ID";
    
    ZJBusinesscolledgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJBusinesscolledgTableViewCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setitem:[_dataSource objectAtIndex:indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJVideoPlayViewController *videoPlayerVC = [[ZJVideoPlayViewController alloc]initWithNibName:@"ZJVideoPlayViewController" bundle:nil];
    [self.navigationController pushViewController:videoPlayerVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, TRUE_1(30))];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel * label=[[UILabel alloc]init];
    label.top =0;
    label.left = TRUE_1(30/2);
    label.width = TRUE_1(100);
    label.height = view.height;
    label.text = @"课程推荐";
    label.font = ZJ_TRUE_FONT(15);
    [view addSubview:label];
    
       
    UILabel *bottomlable = [[UILabel alloc]init];
    bottomlable.top = view.bottom;
    bottomlable.left = 0;
    bottomlable.width = ZJAPPWidth;
    bottomlable.height = 1;
    bottomlable.backgroundColor = ZJColor_efefef;
    [view addSubview:bottomlable];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TRUE_1(30);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
