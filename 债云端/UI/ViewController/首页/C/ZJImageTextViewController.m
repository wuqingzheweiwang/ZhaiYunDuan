//
//  ZJImageTextViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/7/18.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJImageTextViewController.h"
#import "ZJNewsDetailsViewController.h"
#import "ZJHomeNewsViewCell.h"
@interface ZJImageTextViewController ()

@end

@implementation ZJImageTextViewController
{

    __weak IBOutlet UIView *HeaderView;

    __weak IBOutlet UITableView *infoTable;
    
    NSMutableArray * _dataSource;
    NSInteger _page;
   
    NSString * BtnType;   //直接赋值上面的按钮文字，根据他去判断显示什么布局
    UIScrollView * headerScrollview;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"图文课程"];
    _dataSource=[NSMutableArray array];
    
    _page=1;
    
    
    BtnType=@"名师讲堂";
    self.automaticallyAdjustsScrollViewInsets=NO;
   
    [self resetUI];
    [self requestTeacherClassInfo];
}
- (void)requestTeacherClassInfo
{

}
//UI布局
-(void)resetUI{
    HeaderView.top=64;
    HeaderView.left=0;
    HeaderView.width=ZJAPPWidth;
    HeaderView.height=44;
    headerScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, 44)];
    headerScrollview.userInteractionEnabled=YES;
    headerScrollview.showsVerticalScrollIndicator=NO;
    headerScrollview.showsHorizontalScrollIndicator=NO;
    [HeaderView addSubview:headerScrollview];
    NSMutableArray * infoarray=[NSMutableArray arrayWithObjects:@"基本信息",@"资产信息",@"需求信息",@"股权信息",@"经营信息",@"债事信息", nil];
    for (int i=0; i<infoarray.count; i++) {
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(i*ZJAPPWidth/5, 0, ZJAPPWidth/5, 44);
        [button setTitle:[NSString stringWithFormat:@"%@",[infoarray objectAtIndex:i]] forState:UIControlStateNormal];
        if (i==0) {
            [button setTitleColor:ZJColor_red forState:UIControlStateNormal];
        }else [button setTitleColor:ZJColor_333333 forState:UIControlStateNormal];
        button.tag=1000+i;
        [button.titleLabel setFont:ZJ_FONT(12)];
        [headerScrollview addSubview:button];
        [button addTarget:self action:@selector(infoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        UIView * lineview=[[UIView alloc]initWithFrame:CGRectMake(10+i*ZJAPPWidth/5, 43, ZJAPPWidth/5-20, 1)];
        lineview.backgroundColor=ZJColor_red;
        lineview.tag=2000+i;
        [headerScrollview addSubview:lineview];
        if (i==0) {
            lineview.hidden=NO;
        }else lineview.hidden=YES;
        [headerScrollview setContentSize:CGSizeMake(button.right, 0)];
    }
    infoTable.top=HeaderView.bottom;
    infoTable.left=0;
    infoTable.width=ZJAPPWidth;
    infoTable.height=ZJAPPHeight-44-64;
    infoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    infoTable.showsVerticalScrollIndicator = NO;
    [infoTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [infoTable setTableHeaderView:[[UIView alloc] initWithFrame:CGRectZero]];
    //刷新
    __weak ZJImageTextViewController *weakSelf = self;
    infoTable.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadFirstData];
    }];
    
    //加载
    infoTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}
-(void)reloadFirstData
{
    //@weakify(self) 防止循环引用
    //@strongify(self) 防止指针消失
    if ([BtnType isEqualToString:@"基本信息"]){
//        [infoTable.mj_header endRefreshing];
//        [infoTable.mj_footer endRefreshing];
    }else if ([BtnType isEqualToString:@"资产信息"]){
//        _page2=1;
//        [self requestCapitalInfo];
    }else if ([BtnType isEqualToString:@"需求信息"]){
//        _page3=1;
//        [self requestDemandInfo];
    }else if ([BtnType isEqualToString:@"股权信息"]){
//        _page4=1;
//        [self requestStockInfo];
    }else if ([BtnType isEqualToString:@"经营信息"]){
//        _page5=1;
//        [self requestOperateInfo];
    }else if ([BtnType isEqualToString:@"债事信息"]){
//        _page6=1;
//        [self requestDebtInfoMation];
    }
    
}
-(void)loadMoreData
{
    if ([BtnType isEqualToString:@"基本信息"]){
//        [Infotabel.mj_header endRefreshing];
//        [Infotabel.mj_footer endRefreshing];
    }else if ([BtnType isEqualToString:@"资产信息"]){
//        _page2+=1;
//        [self requestCapitalInfo];
    }else if ([BtnType isEqualToString:@"需求信息"]){
//        _page3+=1;
//        [self requestDemandInfo];
    }else if ([BtnType isEqualToString:@"股权信息"]){
//        _page4+=1;
//        [self requestStockInfo];
    }else if ([BtnType isEqualToString:@"经营信息"]){
//        _page5+=1;
//        [self requestOperateInfo];
    }else if ([BtnType isEqualToString:@"债事信息"]){
//        _page6+=1;
//        [self requestDebtInfoMation];
    }
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
    if ([BtnType isEqualToString:@"基本信息"]) {
//        rightBtn.hidden=YES;
//        rightBtn.tag=5000;
//        [Infotabel reloadData];
    }else if ([BtnType isEqualToString:@"资产信息"]){
//        rightBtn.hidden=NO;
//        rightBtn.tag=5001;
//        _page2=1;
//        [self requestCapitalInfo];
    }else if ([BtnType isEqualToString:@"需求信息"]){
//        rightBtn.hidden=NO;
//        rightBtn.tag=5002;
//        _page3=1;
//        [self requestDemandInfo];
    }else if ([BtnType isEqualToString:@"股权信息"]){
//        rightBtn.hidden=NO;
//        rightBtn.tag=5003;
//        _page4=1;
//        [self requestStockInfo];
    }else if ([BtnType isEqualToString:@"经营信息"]){
//        rightBtn.hidden=NO;
//        rightBtn.tag=5004;
//        _page5=1;
//        [self requestOperateInfo];
    }else if ([BtnType isEqualToString:@"债事信息"]){
//        rightBtn.hidden=NO;
//        rightBtn.tag=5005;
//        _page6=1;
//        [self requestDebtInfoMation];
    }
//    [Infotabel reloadData];
}
#pragma mark  tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return [ZJHomeNewsViewCell getCellHeight];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str  =@"vsd";
    ZJHomeNewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJHomeNewsViewCell" owner:self options:nil]firstObject];
    }
    // 取消选中效果
    [cell setitem:[_dataSource objectAtIndex:indexPath.row]];
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ZJNewsDetailsViewController * newsVC=[[ZJNewsDetailsViewController alloc]initWithNibName:@"ZJNewsDetailsViewController" bundle:nil];
    ZJHomeNewsModel * moder=[_dataSource objectAtIndex:indexPath.row];
    newsVC.newsurl=moder.url;
    newsVC.newstitle=@"新闻详情";
    [self.navigationController pushViewController:newsVC animated:YES];
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
