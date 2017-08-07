//
//  ZJSecondAnswerquestionController.m
//  债云端
//
//  Created by 赵凯强 on 2017/8/4.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJSecondAnswerquestionController.h"
#import "ZJSecondAnswerQuestionCell.h"
#import "ZJNewsDetailsViewController.h"
@interface ZJSecondAnswerquestionController ()<UISearchBarDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *tabledataSource;

@end

@implementation ZJSecondAnswerquestionController
{
    BOOL SearchYES;
    UIView * seachview;
    NSUInteger _page;
    UISearchBar * searcherBar;

}
- (void)viewDidLoad {
    [super viewDidLoad];

    _tabledataSource = [NSMutableArray array];
    _page = 1;
    [self setAnswerVCUI];
    [self createSerach];
    [self requestAnswerQuestionsInfo];
}


-(void)setAnswerVCUI
{
    [ZJNavigationPublic setLeftButtonOnTargetNav:self action:@selector(leftAction) With:[UIImage imageNamed:@"back"]];
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"答疑解惑"];
    [ZJNavigationPublic setRrightButtonOnTargetNav:self action:@selector(searchInfoAction) With:[UIImage imageNamed:@"searchBar"]];
    
    [self.view addSubview:self.tableView];
    
    //刷新
    __weak ZJSecondAnswerquestionController *weakSelf = self;
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadFirstData];
    }];
    
    //加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];

}

-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)createSerach
{
    seachview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, 40)];
    seachview.backgroundColor=[UIColor whiteColor];
    searcherBar=[[UISearchBar alloc]initWithFrame:CGRectMake(15, 5, ZJAPPWidth-30, 30)];
    searcherBar.searchBarStyle=UISearchBarStyleMinimal;
    [searcherBar setImage:[UIImage imageNamed:@"searchBargrey"]
       forSearchBarIcon:UISearchBarIconSearch
                  state:UIControlStateNormal];
    searcherBar.delegate = self;
    searcherBar.placeholder = @"请输入搜索的姓名或者身份证号";
    searcherBar.contentMode = UIViewContentModeLeft;
    searcherBar.barTintColor = [UIColor clearColor];
    searcherBar.layer.cornerRadius = 15;
    searcherBar.layer.masksToBounds = YES;
    searcherBar.showsCancelButton=YES;
    [seachview addSubview:searcherBar];
    self.tableView.tableHeaderView = seachview;
    self.tableView.tableHeaderView.height = 0;
    
}


//搜索action
-(void)searchInfoAction
{
    SearchYES=YES;
    if (SearchYES) {
        seachview.hidden=NO;
        self.tableView.tableHeaderView.height = 40;
         [self.tableView reloadData];
    }
}

// 搜索request
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    NSString * action=[NSString stringWithFormat:@"api/debt/byuser?ps=10&pn=1&condition=%@",searchBar.text];
    NSString *utf = [action stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZJDebtPersonRequest GetSearchDebtPersonRequestWithActions:utf result:^(BOOL success, id responseData) {
        DLog(@"%@",responseData);
        if (success) {
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                if (_page==1) {
                    [self.tabledataSource removeAllObjects];
                }
                NSArray * itemarray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                for (int i=0; i<itemarray.count; i++) {
                    ZJAnswerQuestionModel * item=[ZJAnswerQuestionModel itemForDictionary:[itemarray objectAtIndex:i]];
                    [self.tabledataSource addObject:item];
                }
                [self.tableView reloadData];
            }else{
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:responseData];
        }
    }];
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    SearchYES=NO;
    searchBar.text=@"";
    self.tableView.tableHeaderView.height = 0;
    _page=1;
    [self.tabledataSource removeAllObjects];
    [self requestAnswerQuestionsInfo];
    
}





-(void)reloadFirstData
{
    _page=1;
    [self requestAnswerQuestionsInfo];
    
}
-(void)loadMoreData
{
    _page+=1;
    [self requestAnswerQuestionsInfo];
    
}


-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark  tableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.tabledataSource.count>0) {

    return TRUE_1(30);
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.tabledataSource.count>0) {

        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, TRUE_1(30))];
        view.backgroundColor = ZJColor_efefef;
        UILabel * label=[[UILabel alloc]init];
        
        label.left = TRUE_1(30/2);
        label.width = ZJAPPWidth - TRUE_1(30);
        label.height = view.height;
        label.centerY = view.centerY;
        label.text = self.headerTitleText;
        label.textColor = ZJColor_999999;
        label.font = ZJ_TRUE_FONT(12);
        [view addSubview:label];
        
        return view;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.tabledataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str  =@"vsd";
    ZJSecondAnswerQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJSecondAnswerQuestionCell" owner:self options:nil]firstObject];
    }
    
    [cell setitem:[self.tabledataSource objectAtIndex:indexPath.row]];
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ZJSecondAnswerQuestionCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

        ZJNewsDetailsViewController * newsVC=[[ZJNewsDetailsViewController alloc]initWithNibName:@"ZJNewsDetailsViewController" bundle:nil];
        ZJAnswerQuestionModel * moder=[self.tabledataSource objectAtIndex:indexPath.row];
        newsVC.newsurl=moder.url;
        newsVC.newstitle=@"图文详情";
        [self.navigationController pushViewController:newsVC animated:YES];
}

#pragma mark 答疑解惑网络请求
-(void)requestAnswerQuestionsInfo
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString * action=[NSString stringWithFormat:@"api/news/getNews?ps=10&pn=%ld",(long)_page];
        
    [ZJHomeRequest zjGetHomeNewsRequestWithParams:action result:^(BOOL success, id responseData) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        DLog(@"%@",responseData);
        // 请求成功
        if (success) {
            
            if (_page==1) {
                [self.tabledataSource removeAllObjects];
                [self.tableView reloadData];
            }
            
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                NSArray * newArray=[[responseData objectForKey:@"data"] objectForKey:@"news"];
                for (int i=0; i<newArray.count; i++) {
                    NSDictionary * dict=[newArray objectAtIndex:i];
                    ZJAnswerQuestionModel * item=[ZJAnswerQuestionModel itemForDictionary:dict];
                    [self.tabledataSource addObject:item];
                    [self.tableView reloadData];
                }
            }else{
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:@"请求失败"];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [searcherBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
