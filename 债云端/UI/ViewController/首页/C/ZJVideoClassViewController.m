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
    __weak IBOutlet UIView *HeaderView;
    NSInteger _page;
    UIScrollView * headerScrollview;
    NSString * BtnType;   //直接赋值上面的按钮文字，根据他去判断显示什么布局
    UIView * seachview;
    NSMutableArray *collectionDataSource;
    NSString *action;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    collectionDataSource = [NSMutableArray array];
    BtnType=@"名师讲堂";
    _page = 1;
    [self creatUI];
    [self requestVideoRequestData];
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
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, headerScrollview.bottom+64+TRUE_1(15), ZJAPPWidth,ZJAPPHeight - headerScrollview.bottom-64-TRUE_1(15)) collectionViewLayout:flowLayout];
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
        [self.collectionView.mj_header beginRefreshing];
        [self.collectionView reloadData];
    }else if ([BtnType isEqualToString:@"解债案例"]){
        _page=1;
        [self.collectionView.mj_header beginRefreshing];
        [self requestVideoRequestData];
    }else if ([BtnType isEqualToString:@"答疑解惑"]){
        _page=1;
        [self.collectionView.mj_header beginRefreshing];
        [self requestVideoRequestData];
    }else if ([BtnType isEqualToString:@"法律咨询"]){
        _page=1;
        [self.collectionView.mj_header beginRefreshing];
        [self requestVideoRequestData];
    }else if ([BtnType isEqualToString:@"名师风采"]){
        _page=1;
        [self.collectionView.mj_header beginRefreshing];
        [self requestVideoRequestData];
    }
    [self.collectionView reloadData];
}


#pragma mark--请求债事信息
- (void)requestVideoRequestData
{
    if ([BtnType isEqualToString:@"名师讲堂"]) {
            action=[NSString stringWithFormat:@"api/video/getVideoList?videoId=%@&pn=%ld&ps=8",@"名师讲堂",_page];
        }else if ([BtnType isEqualToString:@"解债案例"]){
            action=[NSString stringWithFormat:@"api/video/getVideoList?videoId=%@&pn=%ld&ps=8",@"解债案例",_page];
        }else if ([BtnType isEqualToString:@"答疑解惑"]){
            action=[NSString stringWithFormat:@"api/video/getVideoList?videoId=%@&pn=%ld&ps=8",@"答疑解惑",_page];
        }else if ([BtnType isEqualToString:@"法律咨询"]){
            action=[NSString stringWithFormat:@"api/video/getVideoList?videoId=%@&pn=%ld&ps=8",@"法律咨询",_page];
        }else if ([BtnType isEqualToString:@"名师风采"]){
            action=[NSString stringWithFormat:@"api/video/getVideoList?videoId=%@&pn=%ld&ps=8",@"名师风采",_page];
        }
        
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
