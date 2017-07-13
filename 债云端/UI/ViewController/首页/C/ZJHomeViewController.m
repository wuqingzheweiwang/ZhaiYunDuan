//
//  ZJHomeViewController.m
//  债云端
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJHomeViewController.h"
#import "ZJDebtBankViewController.h"
#import "ZJBusinesscollegeViewController.h"
#import "ZJDebtShoppingCentreViewController.h"
#import "ZJAddDebtPersonController.h"
#import "ZJDebtAllsubjectsViewController.h"
#import "ZJGodEyesViewController.h"
#import "ZJAboutViewController.h"
#import "ZJMemberCenterViewController.h"
#import "ZJAllApplyViewController.h"
#import "ZJLoginViewController.h"
#import "ZJAddDebtInformationViewController.h"
#import "ZJHomeRequest.h"
#import "ZJHomeItem.h"
#import "ZJHomeNewsViewCell.h"
#import "ZJNewsDetailsViewController.h"
@interface ZJHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate,UIScrollViewDelegate>
{
    UIView *titleView;
}
@property (nonatomic , strong) NSMutableArray *tableViewdataSource;
@property (nonatomic , strong) NSMutableArray *collectionViewdataSource;

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UICollectionView *collectionView;

@property (nonatomic , assign) NSInteger isMember;

// 头视图
@property (nonatomic , strong) UIView * tableHeaderView;
// 滚动视图
@property (nonatomic, strong) SDCycleScrollView *sdCyScroll;
@property (nonatomic , strong) NSMutableArray *imageArray; //图片地址
@property (nonatomic , strong) NSMutableArray *silderArray; //图片的modle

@end

static NSString *identifierId=@"zz";

@implementation ZJHomeViewController
{
    // 登录按钮
    UIButton * rightBtn;
    // 开通债行弹出框
    UIAlertController *alertcon;
    BOOL   isOpen;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageArray = [NSMutableArray array];
    self.silderArray= [NSMutableArray array];
    // 设置导航栏
    [self setNavgication];

    // 设置头视图
    [self setTableHeaderView];
    
    [NSThread detachNewThreadSelector:@selector(loadNewsRequestData) toTarget:self withObject:nil];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if ([ZJUserInfo getUserIDForUserToken].length>0) {
        [self getUserRoleWithToken];
    }
    _sdCyScroll.autoScroll = YES;
    if ([ZJUtil getUserLogin]) {
        rightBtn.hidden=YES;
    }else rightBtn.hidden=NO;

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    _sdCyScroll.autoScroll = NO;
    
}
//获取用户角色
- (void)getUserRoleWithToken
{
     [ZJHomeRequest zjGetUserRoleRequestresult:^(BOOL success, id responseData) {
         NSLog(@"%@",responseData);
         if (success) {
             if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                 [ZJUserInfo saveUserInfoWithUserRole:[NSString stringWithFormat:@"%@",[responseData objectForKey:@"data"]]];
             }
         }
     }];
}
// 新闻页网络请求
-(void)loadNewsRequestData
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"",@"", nil];
    // 菊花
    [self performSelectorOnMainThread:@selector(showPrass) withObject:self waitUntilDone:YES];
    
    [ZJHomeRequest zjGetHomeRequestWithParams:dic result:^(BOOL success, id responseData) {
    [self performSelectorOnMainThread:@selector(hidePrass) withObject:self waitUntilDone:YES];
        
       // 请求成功
       if (success) {
           NSLog(@"%@",responseData);
           if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
        
               NSArray * newArray=[[responseData objectForKey:@"data"] objectForKey:@"news"];
               [_tableViewdataSource removeAllObjects];
               for (int i=0; i<newArray.count; i++) {
                   NSDictionary * dict=[newArray objectAtIndex:i];
                   ZJHomeNewsModel * item=[ZJHomeNewsModel itemForDictionary:dict];
                   [_tableViewdataSource addObject:item];
               }
               
               NSArray * sliderArray=[[responseData objectForKey:@"data"]objectForKey:@"slider"];
               [self.silderArray removeAllObjects];
               [self.imageArray removeAllObjects];
               for (int i = 0; i<sliderArray.count; i++) {
                   
                   ZJHomeScrollerModel *item = [ZJHomeScrollerModel itemForDictionary:[sliderArray objectAtIndex:i]];
                   [self.imageArray addObject:item.url];
                   [self.silderArray addObject:item];
               }
               self.sdCyScroll.imageURLStringsGroup = self.imageArray;
               
               [self performSelectorOnMainThread:@selector(reloadUI) withObject:nil waitUntilDone:YES];
           }

       }
   }];
    
    
}



-(void)showPrass
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}

-(void)hidePrass
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}
// 刷新UI
-(void)reloadUI
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
    
}


// 设置导航栏
-(void)setNavgication
{
    
    [ZJNavigationPublic setHomeTitleOnTargetNav:self];
    rightBtn=[ZJNavigationPublic setHiddenRightButtonOnTargetNav:self action:@selector(clickLogin) Withtitle:@"登录"];
}

// 点击登录按钮
-(void)clickLogin
{
    ZJLoginViewController *zjLogin = [[ZJLoginViewController alloc]initWithNibName:@"ZJLoginViewController" bundle:nil];
    [zjLogin setHidesBottomBarWhenPushed:YES];

    [self.navigationController pushViewController:zjLogin animated:YES];
}

// 设置UItableHeaderView   SDcycleScrollerView + UIView
-(void)setTableHeaderView
{
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.tableHeaderView;
    UIView * footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, 20)];
    footview.backgroundColor=[UIColor whiteColor];
    self.tableView.tableFooterView=footview;
    self.tableView.showsVerticalScrollIndicator=NO;
    [self.tableHeaderView addSubview:self.sdCyScroll];
    [self.tableHeaderView addSubview:self.collectionView];
}

-(UIView *)tableHeaderView
{
    if (_tableHeaderView == nil) {
        _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, TRUE_1(360/2)+TRUE_1(390/2))];
        _tableHeaderView.backgroundColor =HexRGB(colorLong(@"efefef"));
    }
    return _tableHeaderView;
}
-(NSMutableArray *)tableViewdataSource
{
    if (_tableViewdataSource == nil) {
        _tableViewdataSource =[NSMutableArray array];
    }
    return _tableViewdataSource;
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //刷新
        __weak ZJHomeViewController *weakSelf = self;
        _tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf reloadFirstData];
        }];
    }
    
    return _tableView;
}
//刷新
-(void)reloadFirstData
{
    //@weakify(self) 防止循环引用
    //@strongify(self) 防止指针消失
    [NSThread detachNewThreadSelector:@selector(loadNewsRequestData) toTarget:self withObject:nil];
    
}

#pragma mark TableView代理
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
    cell.selectionStyle =UITableViewCellSelectionStyleNone;

    [cell setitem:[self.tableViewdataSource objectAtIndex:indexPath.row]];
    
    return cell;
}

// 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJNewsDetailsViewController * newsVC=[[ZJNewsDetailsViewController alloc]initWithNibName:@"ZJNewsDetailsViewController" bundle:nil];
    ZJHomeNewsModel * moder=[_tableViewdataSource objectAtIndex:indexPath.row];
    newsVC.newsurl=moder.url;
    newsVC.newstitle=@"新闻详情";
    newsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newsVC animated:YES];
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, TRUE_1(40))];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label=[[UILabel alloc]init];
    
    label.left = TRUE_1(30/2);
    label.width = TRUE_1(100);
    label.height = view.height;
    label.centerY = view.centerY;
    label.text = @"最新动态";
    label.font = ZJ_TRUE_FONT(12);
    [view addSubview:label];
    
    UIButton *rightMore = [UIButton buttonWithType:UIButtonTypeCustom];
    rightMore.width = TRUE_1(40/2);
    rightMore.height = TRUE_1(40/2);
    rightMore.right =ZJAPPWidth- label.left - rightMore.width;
    rightMore.top = view.centerY-TRUE_1(20/2);
    [rightMore setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [rightMore addTarget:self action:@selector(moreNews) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rightMore];
    
    
    UIButton *moreBut = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBut.width =label.width;
    moreBut.height = label.height;
    moreBut.right =ZJAPPWidth- (TRUE_1(40/2) + rightMore.width+moreBut.width);
    moreBut.top = label.top;
    [moreBut setTitle:@"查看更多" forState:UIControlStateNormal];
    [moreBut setTitleColor: HexRGB(colorLong(@"999999")) forState:UIControlStateNormal];
    [moreBut setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    moreBut.titleLabel.font = ZJ_TRUE_FONT_1(12);
    [moreBut addTarget:self action:@selector(moreNews) forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:moreBut];
    
    UILabel *bottomlable = [[UILabel alloc]init];
    bottomlable.top = view.bottom;
    bottomlable.left = 0;
    bottomlable.width = ZJAPPWidth;
    bottomlable.height = 1;
    bottomlable.backgroundColor = ZJColor_efefef;
    [view addSubview:bottomlable];
    
    return view;
}

// 跳转新闻页
-(void)moreNews
{
    ZJAboutViewController *moreNewsVC = [[ZJAboutViewController alloc]initWithNibName:@"ZJAboutViewController" bundle:nil];
    [moreNewsVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController: moreNewsVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TRUE_1(80/2);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [ZJHomeNewsViewCell getCellHeight];
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 

-(SDCycleScrollView *)sdCyScroll
{
    if (_sdCyScroll == nil) {
        _sdCyScroll =  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ZJAPPWidth, TRUE_1(360)/2) delegate:self placeholderImage:[UIImage imageNamed:@"backGroundDefault"]];
    }
    return _sdCyScroll;
}
#pragma mark  cycleScrollView代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    ZJHomeScrollerModel * moder=[self.silderArray objectAtIndex:index];
    if (moder.openUrl.length>0) {
        ZJNewsDetailsViewController * newsVC=[[ZJNewsDetailsViewController alloc]initWithNibName:@"ZJNewsDetailsViewController" bundle:nil];
        newsVC.newsurl=moder.openUrl;
        newsVC.newstitle=@"新闻详情";
        newsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:newsVC animated:YES];
    }
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
}

-(NSMutableArray *)collectionViewdataSource
{

    if (_collectionViewdataSource == nil) {
        _collectionViewdataSource = [NSMutableArray arrayWithObjects:
    @[  @[@"Rdebtecord",@"债事备案"],
        @[@"debtBank",@"开通债行"],
        @[@"addDebtPerson",@"添加债事人"],

        @[@"debtShopping",@"债市商城"],
        @[@"ZJstate",@"中金动态"],
        @[@"businesscollege",@"商学院"],
        @[@"debtAllsubjects",@"债事百科"],
        
        @[@"zjGodIeas",@"中金天眼"],
        @[@"memberCenter",@"会员中心"],
        @[@"allApply",@"全部应用"]],nil];
        
        
    }
    return _collectionViewdataSource;
}

-(UICollectionView *)collectionView
{
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];

    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.sdCyScroll.height, ZJAPPWidth,TRUE_1(190)) collectionViewLayout:flowLayout];
    }
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;

    //  cell间的行距
    flowLayout.minimumLineSpacing = TRUE_1(5);
    //  cell间的列距
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset=UIEdgeInsetsMake(TRUE_1(-5), TRUE_1(10), 0, TRUE_1(10));

    //  注册类
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifierId];
    _collectionView.scrollEnabled = NO;
    return _collectionView;
}

// 设置单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize=CGSizeMake(ZJAPPWidth/6, TRUE_1(190/2));
    return itemSize;
}


#pragma mark collectionView代理

//  设置分区中的单元格cell数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
//  设置cell内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifierId forIndexPath:indexPath];
    for (UIView *vv in cell.contentView.subviews) {
        [vv removeFromSuperview];
    }
//        cell.backgroundColor=[UIColor redColor];
    //  为单元格设置图片 为网格设置内容,都是cell.contentView addSubView: 这种方式直接加载
    
    
    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(TRUE_1(6), TRUE_1(20), cell.width-TRUE_1(12), cell.width-TRUE_1(12))];
    imgView.image=[UIImage imageNamed:self.collectionViewdataSource[indexPath.section][indexPath.row][0]];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imgView.bottom+TRUE_1(5), cell.width,TRUE_1(10))];
    label.text =self.collectionViewdataSource[indexPath.section][indexPath.row][1];
    label.font = ZJ_TRUE_FONT_1(10);
    label.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:imgView];
    [cell.contentView addSubview:label];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0) {   //债事备案
        if ([ZJUtil getUserLogin]) {
            ZJAddDebtInformationViewController *addDebtVC = [[ZJAddDebtInformationViewController alloc]init];
            if ([ZJUtil getUserIsDebtBank]) {
                addDebtVC.Btntype=ZJDebtRecordTypeVip;
            }else{
                addDebtVC.Btntype=ZJDebtRecordTypeNoVip;
            }
            [addDebtVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:addDebtVC animated:YES];
        }else{
            //跳到登录页面 CCPLoginVC
            ZJLoginViewController *login = [[ZJLoginViewController alloc]initWithNibName:@"ZJLoginViewController" bundle:nil];;
            //隐藏tabbar
            login.hidesBottomBarWhenPushed =YES;
            [login setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:login animated:YES];
        
        }
    }else if (indexPath.row==1){  //开通债行
        if ([ZJUtil getUserLogin]) {
            // 如果是会员(行长)
            if ([ZJUtil getUserIsDebtBank]) {
                
                alertcon = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已成为云债行行长" preferredStyle:UIAlertControllerStyleAlert];
                // 添加按钮
//                __weak typeof(alertcon) weakAlert = alertcon;
                [alertcon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                   
                }]];
                
                [self presentViewController:alertcon animated:YES completion:nil];
                
            }else{
            ZJDebtBankViewController *addDebtVC = [[ZJDebtBankViewController alloc]init];
            [addDebtVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:addDebtVC animated:YES];
            }
        }else{
            //跳到登录页面 CCPLoginVC
            ZJLoginViewController *login = [[ZJLoginViewController alloc]initWithNibName:@"ZJLoginViewController" bundle:nil];;
            //隐藏tabbar
            login.hidesBottomBarWhenPushed =YES;
            [login setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:login animated:YES];
        }
    }else if (indexPath.row==2){  //添加债事人
        if ([ZJUtil getUserLogin]) {
            ZJAddDebtPersonController *addDebtVC = [[ZJAddDebtPersonController alloc]init];
            [addDebtVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:addDebtVC animated:YES];
        }else{
            //跳到登录页面 CCPLoginVC
            ZJLoginViewController *login = [[ZJLoginViewController alloc]initWithNibName:@"ZJLoginViewController" bundle:nil];;
            login.hidesBottomBarWhenPushed =YES;
            [login setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:login animated:YES];
        }
    }else if (indexPath.row==3){  //债事商城
        
        ZJNewsDetailsViewController *zjNewsVC = [[ZJNewsDetailsViewController alloc]initWithNibName:@"ZJNewsDetailsViewController" bundle:nil];
        NSString *url = @"http://wx.wdcome.com/";
        zjNewsVC.newsurl = url;
        zjNewsVC.newstitle = @"债事商城";
        [zjNewsVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:zjNewsVC animated:YES];
        
    }else if (indexPath.row==4){  //中金动态
        
        ZJAboutViewController *addDebtVC = [[ZJAboutViewController alloc]init];
        [addDebtVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:addDebtVC animated:YES];
        
    }else if (indexPath.row==5){  //商学院
        
        ZJBusinesscollegeViewController *addDebtVC = [[ZJBusinesscollegeViewController alloc]init];
        [addDebtVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:addDebtVC animated:YES];
        
    }else if (indexPath.row==6){  //债事百科
        if (isOpen) {
            ZJDebtAllsubjectsViewController *addDebtVC = [[ZJDebtAllsubjectsViewController alloc]init];
            [addDebtVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:addDebtVC animated:YES];
        }else{
            [ZJUtil showBottomToastWithMsg:@"该功能正在开发中，敬请期待"];
        }
    }else if (indexPath.row==7){  //中金天眼
        if (isOpen) {
            ZJGodEyesViewController *addDebtVC = [[ZJGodEyesViewController alloc]init];
            [addDebtVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:addDebtVC animated:YES];
        }else{
            [ZJUtil showBottomToastWithMsg:@"该功能正在开发中，敬请期待"];
        }
    }else if (indexPath.row==8){  //会员中心
        
        self.tabBarController.selectedIndex=3;
        
    }else if (indexPath.row==9){  //全部应用
        if (isOpen) {
            ZJAllApplyViewController *addDebtVC = [[ZJAllApplyViewController alloc]init];
            [addDebtVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:addDebtVC animated:YES];
        }else{
            [ZJUtil showBottomToastWithMsg:@"该功能正在开发中，敬请期待"];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
