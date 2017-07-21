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
#import "ZJSearchImageTextViewController.h"
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
    
    NSString * action;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [ZJNavigationPublic setTitleOnTargetNav:self title:@"图文课程"];
    [ZJNavigationPublic setRrightButtonOnTargetNav:self action:@selector(searchInfoAction) With:[UIImage imageNamed:@"searchBar"]];
    _dataSource=[NSMutableArray array];
    _page=1;
    BtnType=@"名师讲堂";
    self.automaticallyAdjustsScrollViewInsets=NO;
   
    [self resetUI];
    [self requestTeacherClassInfo];
}
- (void)requestTeacherClassInfo
{
    if ([BtnType isEqualToString:@"名师讲堂"]) {
        action=[NSString stringWithFormat:@"api/imagetext/getImageText?videoId=%@&pn=%ld&ps=8",@"名师讲堂",_page];
    }else if ([BtnType isEqualToString:@"解债案例"]){
        action=[NSString stringWithFormat:@"api/imagetext/getImageText?videoId=%@&pn=%ld&ps=8",@"解债案例",_page];
    }else if ([BtnType isEqualToString:@"答疑解惑"]){
        action=[NSString stringWithFormat:@"api/imagetext/getImageText?videoId=%@&pn=%ld&ps=8",@"答疑解惑",_page];
    }else if ([BtnType isEqualToString:@"法律咨询"]){
        action=[NSString stringWithFormat:@"api/imagetext/getImageText?videoId=%@&pn=%ld&ps=8",@"法律咨询",_page];
    }else if ([BtnType isEqualToString:@"名师风采"]){
        action=[NSString stringWithFormat:@"api/imagetext/getImageText?videoId=%@&pn=%ld&ps=8",@"名师风采",_page];
    }
    
    [self showProgress];
    NSString *encoded = [action stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZJHomeRequest zjGetImageandTextRequestWithActions:encoded result:^(BOOL success, id responseData) {
        [self dismissProgress];
        DLog(@"%@",responseData);
        // 请求成功
        if (success) {
            if (_page==1) {
                [_dataSource removeAllObjects];
                [infoTable reloadData];
            }
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                NSArray * newArray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                for (int i=0; i<newArray.count; i++) {
                    NSDictionary * dict=[newArray objectAtIndex:i];
                    ZJHomeNewsModel * item=[ZJHomeNewsModel itemForDictionary:dict];
                    [_dataSource addObject:item];
                    [infoTable reloadData];
                }
            }else{
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:@"请求失败"];
        }
        [infoTable.mj_header endRefreshing];
        [infoTable.mj_footer endRefreshing];
    }];
    
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
    NSMutableArray * infoarray=[NSMutableArray arrayWithObjects:@"名师讲堂",@"解债案例",@"答疑解惑",@"法律咨询",@"名师风采", nil];
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
    [infoTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, ZJAPPWidth, 10)]];
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
    _page=1;
    [self requestTeacherClassInfo];
    
}
-(void)loadMoreData
{
    _page+=1;
    [self requestTeacherClassInfo];
}
//搜索
-(void)searchInfoAction
{
    ZJSearchImageTextViewController * searchVC=[[ZJSearchImageTextViewController alloc]initWithNibName:@"ZJSearchImageTextViewController" bundle:nil];
    [self.navigationController pushViewController:searchVC animated:YES];
}
//-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    [self.view endEditing:YES];
//    NSString * action1=[NSString stringWithFormat:@"api/imagetext/getImageTextSearch?ps=10&pn=1&wd=%@&videoId=%@",searchBar.text,BtnType];
//    NSString *utf = [action1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [ZJHomeRequest zjGetSearchVideoRequestWithActions:utf result:^(BOOL success, id responseData) {
//        DLog(@"%@",responseData);
//        if (success) {
//            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
//               
//                [_dataSource removeAllObjects];
//                NSArray * itemarray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
//                for (int i=0; i<itemarray.count; i++) {
//                    ZJHomeNewsModel * item=[ZJHomeNewsModel itemForDictionary:[itemarray objectAtIndex:i]];
//                    [_dataSource addObject:item];
//                }
//                [infoTable reloadData];
//            }else{
//                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
//            }
//        }else{
//            [ZJUtil showBottomToastWithMsg:responseData];
//        }
//    }];
//    
//}
//-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
//{
//    [self.view endEditing:YES];
//    SearchYES=NO;
//    seachview.hidden=YES;
//    searchBar.text=@"";
//    _page=1;
//    [self requestTeacherClassInfo];
//    
//}
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

    _page=1;
    [self requestTeacherClassInfo];
}
#pragma mark  tableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
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
    newsVC.newstitle=@"图文详情";
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
