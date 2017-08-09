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
#import "ZJTeacherGraceTableCell.h"
#import "ZJAnswerQuestionCell.h"
#import "ZJSecondAnswerquestionController.h"
#import "ZJSearchImageTextViewController.h"
#import "ZJSearchTeacherGraceController.h"
#import "ZJSearchAnswerQuestionController.h"
@interface ZJImageTextViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZJImageTextViewController
{

    __weak IBOutlet UIView *HeaderView;

    __weak IBOutlet UITableView *infoTable;
    
    NSMutableArray * _dataSource1;
    NSMutableArray * _dataSource2;
    NSMutableArray * _dataSource3;

    NSInteger _page1;
    NSInteger _page2;
    NSInteger _page3;

    NSString * BtnType;   //直接赋值上面的按钮文字，根据他去判断显示什么布局
    UIScrollView * headerScrollview;
    
    NSString * action;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [ZJNavigationPublic setTitleOnTargetNav:self title:@"图文课程"];
    [ZJNavigationPublic setRrightButtonOnTargetNav:self action:@selector(searchInfoAction) With:[UIImage imageNamed:@"searchBar"]];
    
    _dataSource1 =[NSMutableArray array];
    _dataSource2 =[NSMutableArray array];
    _dataSource3 =[NSMutableArray array];

    _page1=1;
    _page2=1;
    _page3=1;

    BtnType=@"名师讲堂";
    [self resetUI];
    [self requestTeacherClassInfo];
}

//UI布局
-(void)resetUI{
    
    self.automaticallyAdjustsScrollViewInsets=NO;

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
    if ([BtnType isEqualToString:@"名师讲堂"]){
        _page1=1;
        [infoTable.mj_header endRefreshing];
        [infoTable.mj_footer endRefreshing];
        [self requestTeacherClassInfo];
    }else if ([BtnType isEqualToString:@"解债案例"]){
        _page1=1;
        [self requestTeacherClassInfo];
    }else if ([BtnType isEqualToString:@"法律咨询"]){
        _page1=1;
        [self requestTeacherClassInfo];
    }else if ([BtnType isEqualToString:@"答疑解惑"]){
        _page2=1;
        [self requestAnswerQuestionsInfo];
    }else if ([BtnType isEqualToString:@"名师风采"]){
        _page3=1;
        [self requestTeacherGraceInfo];
    }
}
-(void)loadMoreData
{
    if ([BtnType isEqualToString:@"名师讲堂"]){
        [infoTable.mj_header endRefreshing];
        [infoTable.mj_footer endRefreshing];
        _page1+=1;
        [self requestTeacherClassInfo];
    }else if ([BtnType isEqualToString:@"解债案例"]){
        _page1+=1;
        [self requestTeacherClassInfo];
    }else if ([BtnType isEqualToString:@"法律咨询"]){
        _page1+=1;
        [self requestTeacherClassInfo];
    }else if ([BtnType isEqualToString:@"答疑解惑"]){
        _page2+=1;
        [self requestAnswerQuestionsInfo];
    }else if ([BtnType isEqualToString:@"名师风采"]){
        _page3+=1;
        [self requestTeacherGraceInfo];
    }

}
//搜索
-(void)searchInfoAction
{
    if ([BtnType isEqualToString:@"名师讲堂"]||[BtnType isEqualToString:@"解债案例"]||[BtnType isEqualToString:@"法律咨询"]) {
        
        ZJSearchImageTextViewController * searchVC=[[ZJSearchImageTextViewController alloc]initWithNibName:@"ZJSearchImageTextViewController" bundle:nil];
        searchVC.butType = BtnType;
        [self.navigationController pushViewController:searchVC animated:YES];
        
    }else if ([BtnType isEqualToString:@"答疑解惑"]){
        
        ZJSearchAnswerQuestionController * searchVC=[[ZJSearchAnswerQuestionController alloc]initWithNibName:@"ZJSearchAnswerQuestionController" bundle:nil];
        
        searchVC.butType = BtnType;
        NSLog(@"%@",searchVC.butType);

        [self.navigationController pushViewController:searchVC animated:YES];
        
    }else if ([BtnType isEqualToString:@"名师风采"]){
        ZJSearchTeacherGraceController * searchVC=[[ZJSearchTeacherGraceController alloc]initWithNibName:@"ZJSearchTeacherGraceController" bundle:nil];
        
        searchVC.butType = BtnType;

        [self.navigationController pushViewController:searchVC animated:YES];
        
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

    if ([BtnType isEqualToString:@"名师讲堂"]){
        [self requestTeacherClassInfo];
        [infoTable reloadData];
    }else if ([BtnType isEqualToString:@"解债案例"]){
        _page1=1;
        [self requestTeacherClassInfo];
    }else if ([BtnType isEqualToString:@"法律咨询"]){
        _page1=1;
        [self requestTeacherClassInfo];
    }else if ([BtnType isEqualToString:@"答疑解惑"]){
        _page2=1;
        [self requestAnswerQuestionsInfo];
    }else if ([BtnType isEqualToString:@"名师风采"]){
        _page3=1;
        [self requestTeacherGraceInfo];
    }

}
#pragma mark  tableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([BtnType isEqualToString:@"答疑解惑"]){
        if (_dataSource2.count>0) {
            return TRUE_1(30);
        }
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([BtnType isEqualToString:@"答疑解惑"]){
    
        if (_dataSource2.count>0) {

        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, TRUE_1(30))];
        view.backgroundColor = ZJColor_efefef;
        UILabel * label=[[UILabel alloc]init];
        
        label.left = TRUE_1(30/2);
        label.width = ZJAPPWidth - TRUE_1(30);
        label.height = view.height;
        label.centerY = view.centerY;
        label.text = @"猜你可能有以下方面问题";
        label.textColor = ZJColor_999999;
        label.font = ZJ_TRUE_FONT(12);
        [view addSubview:label];
   
        return view;
        }
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([BtnType isEqualToString:@"名师讲堂"]){

        return _dataSource1.count;
    }else if ([BtnType isEqualToString:@"解债案例"]){
        
        return _dataSource1.count;
    }else if ([BtnType isEqualToString:@"法律咨询"]){
        
        return _dataSource1.count;
    }else if ([BtnType isEqualToString:@"答疑解惑"]){

        return _dataSource2.count;
    }else if ([BtnType isEqualToString:@"名师风采"]){
   
        return _dataSource3.count;
    }
    return 0;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    if ([BtnType isEqualToString:@"名师讲堂"]){
        
        return [ZJHomeNewsViewCell getCellHeight];
    }else if ([BtnType isEqualToString:@"解债案例"]){
        
        return [ZJHomeNewsViewCell getCellHeight];
    }else if ([BtnType isEqualToString:@"法律咨询"]){
        
        return [ZJHomeNewsViewCell getCellHeight];
    }else if ([BtnType isEqualToString:@"答疑解惑"]){
        
        return [ZJAnswerQuestionCell getCellHeight];

    }else if ([BtnType isEqualToString:@"名师风采"]){
        
        return [ZJTeacherGraceTableCell getCellHeight];
    }
    return 0;
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([BtnType isEqualToString:@"名师讲堂"]||[BtnType isEqualToString:@"解债案例"]||[BtnType isEqualToString:@"法律咨询"]){
        
        static NSString *str  =@"vsd";
        ZJHomeNewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJHomeNewsViewCell" owner:self options:nil]firstObject];
        }
        // 取消选中效果
        [cell setitem:[_dataSource1 objectAtIndex:indexPath.row]];
        
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if ([BtnType isEqualToString:@"答疑解惑"]){
        
        static NSString *str  =@"vvv";
        ZJAnswerQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJAnswerQuestionCell" owner:self options:nil]firstObject];

        }
        
        int testNum = (int)indexPath.row+1;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
        NSString *string = [formatter stringFromNumber:[NSNumber numberWithInt: testNum]];
        NSString *lastStr = [NSString stringWithFormat:@"第%@类：",string];
        
        cell.textlabel.text = lastStr;
        // 取消选中效果
        [cell setitem:[_dataSource2 objectAtIndex:indexPath.row]];
        
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;

        
    }else if ([BtnType isEqualToString:@"名师风采"]){
        
        static NSString *str  =@"sss";
        ZJTeacherGraceTableCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJTeacherGraceTableCell" owner:self options:nil]firstObject];
        }
        // 取消选中效果
        [cell setitem:[_dataSource3 objectAtIndex:indexPath.row]];
        
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([BtnType isEqualToString:@"名师讲堂"]||[BtnType isEqualToString:@"解债案例"]||[BtnType isEqualToString:@"法律咨询"]){
        
        ZJNewsDetailsViewController * newsVC=[[ZJNewsDetailsViewController alloc]initWithNibName:@"ZJNewsDetailsViewController" bundle:nil];
        ZJHomeNewsModel * moder=[_dataSource1 objectAtIndex:indexPath.row];
        newsVC.newsurl=moder.url;
        newsVC.newstitle=@"图文详情";
        [self.navigationController pushViewController:newsVC animated:YES];
        
    }else if ([BtnType isEqualToString:@"答疑解惑"]){
        
        ZJSecondAnswerquestionController *secondAnswerVC = [[ZJSecondAnswerquestionController alloc]initWithNibName:@"ZJSecondAnswerquestionController" bundle:nil];
        ZJAnswerQuestionModel *model = [_dataSource2 objectAtIndex:indexPath.row];
        secondAnswerVC.headerTitleText = model.title;
        secondAnswerVC.titleText = model.detialTitle;
        secondAnswerVC.url = model.url;
        [self.navigationController pushViewController:secondAnswerVC animated:YES];

    }else if ([BtnType isEqualToString:@"名师风采"]){
        
        
    }

    
}


#pragma mark 名师讲堂、解债案例、法律咨询网络请求
- (void)requestTeacherClassInfo
{
    if ([BtnType isEqualToString:@"名师讲堂"]) {
        action=[NSString stringWithFormat:@"api/imagetext/getImageText?videoId=%@&pn=%ld&ps=8",@"名师讲堂",_page1];
    }else if ([BtnType isEqualToString:@"解债案例"]){
        action=[NSString stringWithFormat:@"api/imagetext/getImageText?videoId=%@&pn=%ld&ps=8",@"解债案例",_page1];
    }else if ([BtnType isEqualToString:@"法律咨询"]){
        action=[NSString stringWithFormat:@"api/imagetext/getImageText?videoId=%@&pn=%ld&ps=8",@"法律咨询",_page1];
    }
    
    [self showProgress];
    NSString *encoded = [action stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZJHomeRequest zjGetImageandTextRequestWithActions:encoded result:^(BOOL success, id responseData) {
        [self dismissProgress];
        DLog(@"%@",responseData);
        // 请求成功
        if (success) {
            
            if (_page1==1) {
                [_dataSource1 removeAllObjects];
                [infoTable reloadData];
            }
            
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                NSArray * newArray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                for (int i=0; i<newArray.count; i++) {
                    NSDictionary * dict=[newArray objectAtIndex:i];
                    ZJHomeNewsModel * item=[ZJHomeNewsModel itemForDictionary:dict];
                    [_dataSource1 addObject:item];
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
#pragma mark 答疑解惑网络请求
-(void)requestAnswerQuestionsInfo
{
    [self showProgress];

    action=[NSString stringWithFormat:@"api/question/getquestion?ps=10&pn=%ld",(long)_page2];

    [ZJHomeRequest zjGetAnswerQuestionsInfoRequestWithParams:action result:^(BOOL success, id responseData) {
        [self dismissProgress];
        DLog(@"%@",responseData);
        // 请求成功
        if (success) {
            
            if (_page2==1) {
                [_dataSource2 removeAllObjects];
                [infoTable reloadData];
            }
            
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                NSArray * newArray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                for (int i=0; i<newArray.count; i++) {
                    NSDictionary * dict=[newArray objectAtIndex:i];
                    ZJAnswerQuestionModel * item=[ZJAnswerQuestionModel itemForDictionary:dict];
                    [_dataSource2 addObject:item];
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


#pragma mark 名师风采网络请求
-(void)requestTeacherGraceInfo
{
    
    [self showProgress];
    action=[NSString stringWithFormat:@"api/news/getNews?ps=10&pn=%ld",(long)_page3];
    
    [ZJHomeRequest zjGetTeacherGraceRequestWithActions:action result:^(BOOL success, id responseData) {
        [self dismissProgress];
        DLog(@"%@",responseData);
        // 请求成功
        if (success) {
            
            if (_page3==1) {
                [_dataSource3 removeAllObjects];
                [infoTable reloadData];
            }
            
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                NSArray * newArray=[[responseData objectForKey:@"data"] objectForKey:@"news"];
                for (int i=0; i<newArray.count; i++) {
                    NSDictionary * dict=[newArray objectAtIndex:i];
                    ZJTeacherGraceModel * item=[ZJTeacherGraceModel itemForDictionary:dict];
                    [_dataSource3 addObject:item];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
