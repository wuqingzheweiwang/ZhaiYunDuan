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
#import "ZJVideoSearchVController.h"
@interface ZJVideoClassViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView *collectionView;

@end

static NSString *identifierId=@"zz";

@implementation ZJVideoClassViewController
{
    NSInteger _page;
    NSMutableArray *collectionDataSource;
    NSString *action;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    collectionDataSource = [NSMutableArray array];
    _page = 1;
    [self creatUI];
    [self requestVideoRequestData];
}

-(void)creatUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"视频课程"];
    [ZJNavigationPublic setRrightButtonOnTargetNav:self action:@selector(searchInfoAction) With:[UIImage imageNamed:@"searchBar"]];

    [self.view addSubview:self.collectionView];
    //刷新
    __weak ZJVideoClassViewController *weakSelf = self;
    self.collectionView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadFirstData];
    }];
    
    //加载
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];

}

-(void)reloadFirstData
{
    _page=1;
    [self requestVideoRequestData];
    
}
-(void)loadMoreData
{
    _page+=1;
    [self requestVideoRequestData];
}

-(UICollectionView *)collectionView
{
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64+TRUE_1(15), ZJAPPWidth,ZJAPPHeight - 64-TRUE_1(15)) collectionViewLayout:flowLayout];
    }
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
 
    //  cell间的行距
    flowLayout.minimumLineSpacing = TRUE_1(5);
    //  cell间的列距
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset=UIEdgeInsetsMake(TRUE_1(0), TRUE_1(15), 0, TRUE_1(15));
    
    //  注册类
    [_collectionView registerClass:[ZJVideoCollectionViewCell class] forCellWithReuseIdentifier:identifierId];
    [_collectionView registerNib:[UINib nibWithNibName:@"ZJVideoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifierId];
    _collectionView.scrollEnabled = YES;
    return _collectionView;
}

// 设置单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize=CGSizeMake((ZJAPPWidth - TRUE_1(15)*3)/2, TRUE_1(350/2));
    return itemSize;
}


#pragma mark collectionView代理

//  设置分区中的单元格cell数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return collectionDataSource.count;
}
//  设置cell内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    ZJVideoCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifierId forIndexPath:indexPath];
    [cell setitem:[collectionDataSource objectAtIndex:indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    ZJVideoPlayViewController * videoPlayVC=[[ZJVideoPlayViewController alloc]initWithNibName:@"ZJVideoPlayViewController" bundle:nil];

    ZJVideoCollectionModel * moder=[collectionDataSource objectAtIndex:indexPath.item];
    videoPlayVC.movieUrl=moder.url;
    videoPlayVC.mainTitle = moder.title;
    videoPlayVC.detialTitle = moder.detialtitle;
    videoPlayVC.updateTime = moder.updateTime;
    [self.navigationController pushViewController:videoPlayVC animated:YES];
}

//搜索
-(void)searchInfoAction
{
    ZJVideoSearchVController *videoSearchVC = [[ZJVideoSearchVController alloc]initWithNibName:@"ZJVideoSearchVController" bundle:nil];
    
    [self.navigationController pushViewController:videoSearchVC animated:YES];
}

#pragma mark--请求债事信息
- (void)requestVideoRequestData
{
    action=[NSString stringWithFormat:@"api/video/getVideoList?pn=%ld&ps=8",_page];
    
    [self showProgress];
    NSString *encoded = [action stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZJHomeRequest zjGetBussinessClassRequestWithActions:encoded result:^(BOOL success, id responseData) {
         
    [self dismissProgress];
    DLog(@"%@",responseData);
        if (_page==1) {
            [collectionDataSource removeAllObjects];
            [self.collectionView reloadData];
        }
        if (success) {
        
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                NSArray * newArray=[[responseData objectForKey:@"data"]objectForKey:@"items"];
                for (int i=0; i<newArray.count; i++) {
                    NSDictionary * dict=[newArray objectAtIndex:i];
                    ZJVideoCollectionModel * item=[ZJVideoCollectionModel itemForDictionary:dict];
                    [collectionDataSource addObject:item];
                }
                [self.collectionView reloadData];
            }else{
                
                 [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:@"网络请求错误"];
        }
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
