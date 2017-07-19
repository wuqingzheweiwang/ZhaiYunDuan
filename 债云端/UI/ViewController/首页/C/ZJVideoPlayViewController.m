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

    _page = 1;
    [self setNavcaition];
    [self creatVideoPlayer];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNav) name:@"show" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideenNav) name:@"hideen" object:nil];

}



-(void)showNav
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
    
    self.navigationController.navigationBar.hidden = YES;
    self.tableView.hidden = NO;
    leftBackBut.hidden = NO;
    [self.tableView reloadData];
}

-(void)hideenNav
{

    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
    self.navigationController.navigationBar.hidden = YES;
    self.tableView.hidden = YES;
    leftBackBut.hidden = YES;
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
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.alpha=1;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.hidesBackButton = YES;
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
    [leftBackBut setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    leftBackBut.tag = 2000;
    [leftBackBut addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [self.player addSubview:leftBackBut];
    [self.view addSubview:self.player];
    
    [self.view addSubview:self.tableView];
    [self creaetMjRefreshUI];
    
    _tableHeaderView.top = self.player.bottom;
    _tableHeaderView.left = 0;
    _tableHeaderView.width = ZJAPPWidth;
    _tableHeaderView.height = TRUE_1(90);
    _tableHeaderView.backgroundColor = [UIColor orangeColor];
    
    _titleText.top = TRUE_1(7);
    _titleText.left = TRUE_1(15);
    _titleText.width = ZJAPPWidth - _titleText.left*2;
    _titleText.numberOfLines = 0;
    NSMutableAttributedString * mastring_1 = [[NSMutableAttributedString alloc]initWithString:_titleText.text];
    NSMutableParagraphStyle *paragraphStyle_1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle_1 setLineSpacing:3];//调整行间距
    
    [mastring_1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle_1 range:NSMakeRange(0, [_titleText.text length])];
    [mastring_1 addAttribute:NSFontAttributeName value:_titleText.font range:NSMakeRange(0, mastring_1.length)];
    _titleText.attributedText = mastring_1;
    CGFloat width_1 = _titleText.width; // whatever your desired width is
    CGRect rect_1 = [mastring_1 boundingRectWithSize:CGSizeMake(width_1, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    _titleText.height = rect_1.size.height;
    _titleText.font = ZJ_TRUE_FONT(15);
    
    _detialText.top = _titleText.bottom+TRUE_1(5);
    _detialText.left = _titleText.left;
    _detialText.width = _titleText.width;
    _detialText.numberOfLines = 0;
    NSMutableAttributedString * mastring_2 = [[NSMutableAttributedString alloc]initWithString:_detialText.text];
    NSMutableParagraphStyle *paragraphStyle_2 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle_2 setLineSpacing:3];//调整行间距
    
    [mastring_2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle_2 range:NSMakeRange(0, [_detialText.text length])];
    [mastring_1 addAttribute:NSFontAttributeName value:_detialText.font range:NSMakeRange(0, mastring_2.length)];
    _detialText.attributedText = mastring_2;
    CGFloat width = _detialText.width; // whatever your desired width is
    CGRect rect = [mastring_2 boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    _detialText.height = rect.size.height;
    _detialText.font = ZJ_TRUE_FONT(9);
    
    _updataTimeText.top = _detialText.bottom+TRUE_1(10);
    _updataTimeText.left = _detialText.left;
    _updataTimeText.width = _detialText.width;
    _updataTimeText.height = _tableHeaderView.height - _detialText.bottom;
    _updataTimeText.font = ZJ_TRUE_FONT(9);
    
    _bottomLine.top = _tableHeaderView.bottom;
    _bottomLine.left = 0;
    _bottomLine.width = ZJAPPWidth;
    _bottomLine.height = 1;
    
    self.tableView.tableHeaderView = self.tableHeaderView;
}


-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.player.bottom, ZJAPPWidth, ZJAPPHeight-self.player.bottom) style:UITableViewStylePlain];
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
        [MBProgressHUD hideHUDForView:self.view animated:YES];

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
    label.text = @"相关视频";
    label.font = ZJ_TRUE_FONT(15);
    [view addSubview:label];
    
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
