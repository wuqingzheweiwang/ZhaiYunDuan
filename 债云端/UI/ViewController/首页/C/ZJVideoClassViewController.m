//
//  ZJVideoClassViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/7/18.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJVideoClassViewController.h"
#import "ZJVideoCollectionViewCell.h"
#import "ZJHomeItem.h"
#import "ZJVideoPlayViewController.h"
@interface ZJVideoClassViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView *collectionView;

@end

static NSString *identifierId=@"zz";

@implementation ZJVideoClassViewController
{
    __weak IBOutlet UIView *HeaderView;
    NSMutableArray * _dataSource; 
    NSInteger _page;
    UIScrollView * headerScrollview;
    NSString * BtnType;   //直接赋值上面的按钮文字，根据他去判断显示什么布局
    BOOL SearchYES;
    UIView * seachview;
    NSMutableArray *collectionDataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    collectionDataSource = [NSMutableArray array];
    BtnType=@"名师讲堂";
    _page = 1;
    [self creatUI];
    [self createSerach];
    [self requestVideoRequestData];
}

- (void)createSerach
{
    seachview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, 40)];
    seachview.backgroundColor=[UIColor whiteColor];
    UISearchBar * searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(15, 10, ZJAPPWidth-30, 30)];
    searchBar.searchBarStyle=UISearchBarStyleMinimal;
    [searchBar setImage:[UIImage imageNamed:@"searchBargrey"]
       forSearchBarIcon:UISearchBarIconSearch
                  state:UIControlStateNormal];
    searchBar.delegate = self;
    searchBar.placeholder = @"请输入搜索的姓名或者身份证号";
    searchBar.contentMode = UIViewContentModeLeft;
    searchBar.barTintColor = [UIColor clearColor];
    searchBar.layer.cornerRadius = 15;
    searchBar.layer.masksToBounds = YES;
    searchBar.showsCancelButton=YES;
    [seachview addSubview:searchBar];
    seachview.hidden=YES;
}


-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    SearchYES=NO;
    seachview.hidden=YES;
    searchBar.text=@"";
    _page=1;
//    [self requestTeacherClassInfo];
    
}

-(void)creatUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"视频课程"];
    [ZJNavigationPublic setRrightButtonOnTargetNav:self action:@selector(searchInfoAction) With:[UIImage imageNamed:@"searchBar"]];

    HeaderView.top=64;
    HeaderView.left=0;
    HeaderView.width=ZJAPPWidth;
    HeaderView.height=44;
    headerScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, 44)];
    headerScrollview.userInteractionEnabled=YES;
    headerScrollview.showsVerticalScrollIndicator=NO;
    headerScrollview.showsHorizontalScrollIndicator=NO;
    [HeaderView addSubview:headerScrollview];
    NSMutableArray * infoarray=[NSMutableArray arrayWithObjects:@"名师讲堂",@"解债案例",@"答疑解惑",@"法律咨询",@"名师风采", nil];
    for (int i=0; i<infoarray.count; i++) {
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(i*(ZJAPPWidth/5), 0, ZJAPPWidth/5, 44);
        [button setTitle:[NSString stringWithFormat:@"%@",[infoarray objectAtIndex:i]] forState:UIControlStateNormal];
        if (i==0) {
            [button setTitleColor:ZJColor_red forState:UIControlStateNormal];
        }else [button setTitleColor:ZJColor_333333 forState:UIControlStateNormal];
        button.tag=1000+i;
        [button.titleLabel setFont:ZJ_FONT(12)];
        [headerScrollview addSubview:button];
        [button addTarget:self action:@selector(infoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        UIView * lineview=[[UIView alloc]initWithFrame:CGRectMake(10+i*(ZJAPPWidth/5), 43, ZJAPPWidth/5-20, 1)];
        lineview.backgroundColor=ZJColor_red;
        lineview.tag=2000+i;
        [headerScrollview addSubview:lineview];
        if (i==0) {
            lineview.hidden=NO;
        }else lineview.hidden=YES;
        [headerScrollview setContentSize:CGSizeMake(button.right, 0)];
    }

    [self.view addSubview:self.collectionView];

}

-(UICollectionView *)collectionView
{
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, headerScrollview.bottom, ZJAPPWidth,ZJAPPHeight - headerScrollview.bottom) collectionViewLayout:flowLayout];
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
    
   
    ZJVideoCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifierId forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJVideoCollectionViewCell" owner:self options:nil]firstObject];
    }
       
    [cell setitem:[collectionDataSource objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    ZJVideoPlayViewController * videoPlayVC=[[ZJVideoPlayViewController alloc]initWithNibName:@"ZJVideoPlayViewController" bundle:nil];
    ZJVideoCollectionModel * moder=[_dataSource objectAtIndex:indexPath.row];
    videoPlayVC.movieUrl=moder.url;
    [self.navigationController pushViewController:videoPlayVC animated:YES];

}

//搜索
-(void)searchInfoAction
{
    SearchYES=YES;
//    [self.ta reloadData];
    if (SearchYES) {
        seachview.hidden=NO;
    }else{
        seachview.hidden=YES;
        _page=1;
        [_dataSource removeAllObjects];
        [self requestInfo];
    }
}
-(void)requestInfo
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self requestVideoRequestData];
}


//button的点击事件
-(void)infoBtnAction:(UIButton *)sender
{
    //遍历查找btn
    BtnType=sender.titleLabel.text;
    [sender setTitleColor:ZJColor_red forState:UIControlStateNormal];
    for (UIButton *subView in headerScrollview.subviews) {
        if ([subView isKindOfClass:[UIButton class]] && subView.tag != sender.tag) {
            [subView setTitleColor:ZJColor_333333 forState:UIControlStateNormal];
        }
    }
    //便利查找红线
    for (UIView *subView in headerScrollview.subviews) {
        if (![subView isKindOfClass:[UIButton class]] && subView.tag == sender.tag+1000) {
            subView.hidden=NO;
        }
        if (![subView isKindOfClass:[UIButton class]] && subView.tag != sender.tag+1000) {
            subView.hidden=YES;
        }
    }
    if ([BtnType isEqualToString:@"名师讲堂"]) {
        _page=1;
//        [Infotabel reloadData];
    }else if ([BtnType isEqualToString:@"解债案例"]){
        _page=1;
        [self requestVideoRequestData];
    }else if ([BtnType isEqualToString:@"答疑解惑"]){
        _page=1;
        [self requestVideoRequestData];
    }else if ([BtnType isEqualToString:@"法律咨询"]){
        _page=1;
        [self requestVideoRequestData];
    }else if ([BtnType isEqualToString:@"名师风采"]){

        _page=1;
        [self requestVideoRequestData];
    }
//    [Infotabel reloadData];
}


#pragma mark--请求债事信息
- (void)requestVideoRequestData
{
//    NSString * action=[NSString stringWithFormat:@"api/debtrelation/debtinfo?debtId=%@&ps=8&pn=%ld",self.companyId,(long)_page];
//    [self showProgress];
//    [ZJDebtPersonRequest GetDebtPersondebtInfomationRequestWithActions:action result:^(BOOL success, id responseData) {
//        DLog(@"%@",responseData);
//        [self dismissProgress];
//        if (success) {
//            
//            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
//                if (_page==1) {
//                    [_dataSource removeAllObjects];
//                }
//                NSArray * dicArray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
//                for (int i=0; i<dicArray.count; i++) {
////                    ZJVideoCollectionModel * item=[ZJVideoCollectionModel itemForDictionary:[dicArray objectAtIndex:i]];
//                    [collectionDataSource addObject:item];
//                }
//                [Infotabel reloadData];
//            }else{
//                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
//            }
//        }else{
//            [ZJUtil showBottomToastWithMsg:@"网络请求错误"];
//        }
//        [Infotabel.mj_header endRefreshing];
//        [Infotabel.mj_footer endRefreshing];
        
//    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
