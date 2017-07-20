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
#import "ZJVideoClassViewController.h"
#import "ZJImageTextViewController.h"
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
    [self requestBussinesSchoolListInfo];
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
    [_videoClassBut addTarget:self action:@selector(clickToVideoVC) forControlEvents:UIControlEventTouchUpInside];
    
    _ImageTextClassBut.top =  _videoClassBut.bottom+TRUE_1(20/2);
    _ImageTextClassBut.left = _videoClassBut.left;
    _ImageTextClassBut.width = _videoClassBut.width;
    _ImageTextClassBut.height = _videoClassBut.height;
    [_ImageTextClassBut addTarget:self action:@selector(clickToImageTextVC) forControlEvents:UIControlEventTouchUpInside];
    
    _bussinesscollegeTable.top=64;
    _bussinesscollegeTable.left=0;
    _bussinesscollegeTable.width=ZJAPPWidth;
    _bussinesscollegeTable.height=ZJAPPHeight-64;
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

// 视频课程
-(void)clickToVideoVC
{
    ZJVideoClassViewController *zjVideoClassVC =[[ZJVideoClassViewController alloc]initWithNibName:@"ZJVideoClassViewController" bundle:nil];
    
    [self.navigationController pushViewController:zjVideoClassVC animated:YES];
    
//        ZJVideoPlayViewController *zjVideoClassVC =[[ZJVideoPlayViewController alloc]initWithNibName:@"ZJVideoPlayViewController" bundle:nil];
//        zjVideoClassVC.movieUrl = @"http://baobab.wdjcdn.com/1455782903700jy.mp4";
//        [self.navigationController pushViewController:zjVideoClassVC animated:YES];
}

// 图文课程
-(void)clickToImageTextVC
{
    ZJImageTextViewController *zjImageTextClassVC =[[ZJImageTextViewController alloc]initWithNibName:@"ZJImageTextViewController" bundle:nil];
    [self.navigationController pushViewController:zjImageTextClassVC animated:YES];
    
}

// 请求商学院
- (void)requestBussinesSchoolListInfo
{
   NSString *action=[NSString stringWithFormat:@"api/debtrelation?ps=5&pn=%ld&issolution=%d",(long)_page,0];
    action=[NSString stringWithFormat:@"resources/app/ep.news.json"];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [ZJHomeRequest zjGetBussinessSchoolRequestWithActions
    [ZJHomeRequest zjGetHomeNewsRequestWithParams:action result:^(BOOL success, id responseData) {
        
            DLog(@"%@",responseData);
        if (success) {
            if (_page==1) {
                [_dataSource removeAllObjects];
            }
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                NSArray * newArray=[[responseData objectForKey:@"data"] objectForKey:@"news"];
                for (int i=0; i<newArray.count; i++) {
                    NSDictionary * dict=[newArray objectAtIndex:i];
                    ZJHomeNewsModel * item=[ZJHomeNewsModel itemForDictionary:dict];
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
    ZJHomeNewsModel * item=[_dataSource objectAtIndex:indexPath.row];
    videoPlayerVC.mainTitle = item.title;
    videoPlayerVC.detialTitle = item.title;
    videoPlayerVC.updateTime = item.updateTime;
//    videoPlayerVC.movieUrl = item.movieUrl;
    [self.navigationController pushViewController:videoPlayerVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_dataSource.count>0) {
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
    }else return nil;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (_dataSource.count>0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, TRUE_1(20))];
        view.backgroundColor = [UIColor whiteColor];
        
        return view;
    }else return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_dataSource.count>0) {
       return TRUE_1(30); 
    }else return 0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_dataSource.count>0) {
        return TRUE_1(20);
    }else return 0;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
