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
#import "ZJHomeItem.h"
@interface ZJVideoPlayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZGLVideoPlyer *player;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UIView *tableHeaderView;

@property (weak, nonatomic) IBOutlet UILabel *titleText;

@property (weak, nonatomic) IBOutlet UILabel *detialText;

@property (weak, nonatomic) IBOutlet UILabel *updataTimeText;

@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@end

@implementation ZJVideoPlayViewController
{
    NSInteger _page;
    UIButton *leftBackBut;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource =[NSMutableArray array];
    _page = 1;
    [self setNavcaition];
    [self creatVideoPlayer];
    [self requestBussinesSchoolListInfo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNav) name:@"show" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideenNav) name:@"hideen" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];

}

-(void)applicationBecomeActive
{
    self.navigationController.navigationBar.alpha = 0;
}

-(void)showNav
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
    self.navigationController.navigationBar.hidden = YES;
    self.tableView.hidden = NO;
    [self.tableView reloadData];
}

-(void)hideenNav
{

    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
    self.navigationController.navigationBar.hidden = YES;
    self.tableView.hidden = YES;
    [self.tableView reloadData];
}


-(void)creaetMjRefreshUI
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

-(void)setNavcaition
{
    self.navigationController.navigationBar.alpha=0;

}

-(void)leftAction
{
    if (self.player.currentDevDir == Right) {
        
        self.player.videoMaskView.fullScreenBtn.selected=NO;
        self.player.currentDevDir = Portrait;
        
        //刷新债事管理列表
        NSNotification *notication1=[NSNotification notificationWithName:@"show" object:nil];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notication1];
        
        
        
        [UIView animateWithDuration:0.3 animations:^{
            self.player.transform = CGAffineTransformMakeRotation(M_PI * 2);
        } completion:nil];
        self.player.frame = CGRectMake(0, 0, ZJAPPWidth, TRUE_1(200));
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        self.navigationController.navigationBar.alpha=1;
        self.navigationController.navigationBar.hidden = NO;
        self.navigationItem.hidesBackButton = YES;
    }
    
}

-(void)creatVideoPlayer
{
    self.player = [[ZGLVideoPlyer alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, TRUE_1(200))];
    self.player.videoUrlStr = self.movieUrl;
    
    leftBackBut = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBackBut.top = TRUE_1(25/2);
    leftBackBut.left = 0;
    leftBackBut.width = TRUE_1(40);
    leftBackBut.height = leftBackBut.width;
    leftBackBut.hidden = NO;
    [leftBackBut setImage:[UIImage imageNamed:@"video-back"] forState:UIControlStateNormal];
    leftBackBut.tag = 2000;
    [leftBackBut addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [self.player addSubview:leftBackBut];
    [self.view addSubview:self.player];
    
    [self.view addSubview:self.tableView];
    
    [self creaetMjRefreshUI];
    
    _tableHeaderView.top = 0;
    _tableHeaderView.left = 0;
    _tableHeaderView.width = ZJAPPWidth;
    _tableHeaderView.height = 0;
    
    _titleText.top = TRUE_1(7);
    _titleText.left = TRUE_1(15);
    _titleText.width = ZJAPPWidth - TRUE_1(30);
    _titleText.numberOfLines = 0;
    _titleText.font=ZJ_TRUE_FONT(15);
    
    NSLog(@"%@",self.mainTitle);
    if ([_titleText.text isEqualToString:@""]) {
        NSMutableAttributedString * mastring = [[NSMutableAttributedString alloc]initWithString:self.mainTitle];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3];//调整行间距
        
        [mastring addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [mastring length])];
        [mastring addAttribute:NSFontAttributeName value:_titleText.font range:NSMakeRange(0, mastring.length)];
        _titleText.attributedText = mastring;
        
        CGFloat width = _titleText.width;
        
        CGRect rect = [mastring boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        
        _titleText.height = rect.size.height;

    }else{
        _titleText.height = TRUE_1(20);
    }
    
    
    _detialText.top = _titleText.bottom+TRUE_1(5);
    _detialText.left = _titleText.left;
    _detialText.width = _titleText.width;
    _detialText.font=ZJ_TRUE_FONT(9);
    _detialText.numberOfLines = 0;
    
    if (![_titleText.text isEqualToString:@""]) {

    NSMutableAttributedString * mastring1 = [[NSMutableAttributedString alloc]initWithString:self.detialTitle];
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:3];//调整行间距
    
    [mastring1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [mastring1 length])];
    [mastring1 addAttribute:NSFontAttributeName value:_detialText.font range:NSMakeRange(0, mastring1.length)];
    _detialText.attributedText = mastring1;
    
    CGFloat width1 = _detialText.width;
    
    CGRect rect1 = [mastring1 boundingRectWithSize:CGSizeMake(width1, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    _detialText.height = rect1.size.height;
    }else{
        
        _detialText.height = TRUE_1(20);

    }
    
    _updataTimeText.top = _detialText.bottom+TRUE_1(10);
    _updataTimeText.left = _detialText.left;
    _updataTimeText.width = _detialText.width;
    _updataTimeText.height =TRUE_1(10);
    _updataTimeText.text = self.updateTime;
    _updataTimeText.font = ZJ_TRUE_FONT(9);
    
    _bottomLine.top = _updataTimeText.bottom+TRUE_1(5);
    _bottomLine.left = 0;
    _bottomLine.width = ZJAPPWidth;
    _bottomLine.height = 1;

    self.tableHeaderView.height=_bottomLine.bottom;
    
    self.tableView.tableHeaderView = self.tableHeaderView;
}


-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.player.height, ZJAPPWidth, ZJAPPHeight-self.player.height) style:UITableViewStylePlain];
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
    NSString *type = @"2";
    NSString *action=[NSString stringWithFormat:@"api/video/getVideo?ps=5&pn=%ld&type=%@",(long)_page,type];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  
    [ZJHomeRequest zjGetVideoContentWithActions:action result:^(BOOL success, id responseData) {
    [MBProgressHUD hideHUDForView:self.view animated:YES];

        DLog(@"%@",responseData);
        if (success) {

            if (_page==1) {
                [_dataSource removeAllObjects];
                [self.tableView reloadData];
            }
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                NSArray * newArray=[[responseData objectForKey:@"data"]objectForKey:@"items"];
                for (int i=0; i<newArray.count; i++) {
                    ZJBusinessSchoolModel * item=[ZJBusinessSchoolModel itemForDictionary:[newArray objectAtIndex:i]];
                    [self.dataSource addObject:item];
                }
                [self.tableView reloadData];
            }else{
                [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"%@",[responseData objectForKey:@"message"]]];
            }
        }else{
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
    [cell setitem:[_dataSource objectAtIndex:indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ZJBusinessSchoolModel * moder=[_dataSource objectAtIndex:indexPath.row];
    self.player.videoUrlStr = moder.url;
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
    label.text = @"相关视频";
    label.font = ZJ_TRUE_FONT(15);
    [view addSubview:label];
        return view;

    }else return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_dataSource.count>0) {
        return TRUE_1(30);
    }else return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (_dataSource.count>0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, TRUE_1(20))];
        view.backgroundColor = [UIColor whiteColor];
        
        return view;
    }else return nil;
    
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
