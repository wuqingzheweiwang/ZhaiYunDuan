//
//  ZJVideoPlayViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/7/17.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJVideoPlayViewController.h"
#import "ZGLVideoPlyer.h"
#import "ZJBusinesscolledgTableViewCell.h"
@interface ZJVideoPlayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZGLVideoPlyer *player;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ZJVideoPlayViewController
{
    NSInteger _page;

}
- (void)viewDidLoad {
    [super viewDidLoad];

    _page = 1;
    [self setNavcaition];
    [self creatVideoPlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNav) name:@"show" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideenNav) name:@"hideen" object:nil];


}

-(void)showNav
{
    self.navigationController.navigationBar.hidden = NO;
}

-(void)hideenNav
{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)creaetUI
{
    //刷新
    __weak ZJVideoPlayViewController *weakSelf = self;
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadFirstData];
    }];
    
    //加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}
//刷新数据
-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"show" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"hideen" object:nil];

}

-(void)creatVideoPlayer
{
    
    CGFloat deviceWith = [UIScreen mainScreen].bounds.size.width;
    
    self.player = [[ZGLVideoPlyer alloc]initWithFrame:CGRectMake(0, 20, deviceWith, 300)];
    self.player.videoUrlStr = self.movieUrl;
    
    [self.view addSubview:self.player];

}

-(void)setNavcaition
{
    [ZJNavigationPublic setTitleOnTargetNav:self title:self.navgationTitle];
    [ZJNavigationPublic setLeftButtonOnTargetNav:self action:@selector(leftAction) With:[UIImage imageNamed:@"back"]];
}

-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
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


// 请求商学院
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
//                    ZJBusinessSchoolModel * item=[ZJBusinessSchoolModel itemForDictionary:[itemarray objectAtIndex:i]];
//                    [_dataSource addObject:item];
                }
                [self.tableView reloadData];
            }else{
                [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"%@",[responseData objectForKey:@"message"]]];
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [ZJUtil showBottomToastWithMsg:@"请求失败"];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark  tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
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
    [cell setitem:[self.dataSource objectAtIndex:indexPath.row]];
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
