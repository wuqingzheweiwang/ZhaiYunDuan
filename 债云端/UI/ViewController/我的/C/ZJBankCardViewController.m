//  银行卡
//  ZJBankCardViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/5/4.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBankCardViewController.h"
#import "ZJBankCardTableViewCell.h"
#import "ZJaddBankCardController.h"
@interface ZJBankCardViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic , strong) NSMutableArray *tableViewdateSource;
@property (weak, nonatomic) IBOutlet UIView *backgroundV;
@property (weak, nonatomic) IBOutlet UITableView *DebtTable;

// 添加银行卡
@property (weak, nonatomic) IBOutlet UIButton *addCardBut;


@end

@implementation ZJBankCardViewController
{
    NSInteger  _page;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 1;
    [self setNavcation];
    [self setBottomAddUI];
    [self setMyBankCardViewUI];
    [self requestMyBankCardListInfo];
}

-(void)setNavcation
{
    self.navigationItem.hidesBackButton = YES;
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"我的银行卡"];
}

-(void)setBottomAddUI
{
    _DebtTable.top=0;
    _DebtTable.left=0;
    _DebtTable.width=ZJAPPWidth;
    _DebtTable.height=ZJAPPHeight;
    _DebtTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    _DebtTable.tableFooterView=_backgroundV;
    _DebtTable.delegate = self;
    
    _backgroundV.top = 0;
    _backgroundV.left = 0;
    _backgroundV.width = ZJAPPWidth;
    _backgroundV.height = TRUE_1(88/2)+10;
    
   
    _addCardBut.top = 10;
    _addCardBut.left = TRUE_1(125/2);
    _addCardBut.width = ZJAPPWidth-TRUE_1(125);
    _addCardBut.height = TRUE_1(88/2);
    _addCardBut.layer.masksToBounds = YES;
    _addCardBut.layer.cornerRadius = 5;
    [_addCardBut.titleLabel setFont:ZJ_TRUE_FONT(15)];
    [_addCardBut addTarget:self action:@selector(addBankCard) forControlEvents:UIControlEventTouchUpInside];

}

-(void)setMyBankCardViewUI
{
    //刷新
    __weak ZJBankCardViewController *weakSelf = self;
    self.DebtTable.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadFirstData];
    }];
    
    //加载
    self.DebtTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
}

-(void)reloadFirstData
{
    //@weakify(self) 防止循环引用
    //@strongify(self) 防止指针消失
    _page=1;
    [self requestMyBankCardListInfo];
}
-(void)loadMoreData
{
    _page+=1;
    [self requestMyBankCardListInfo];
}

// 我的银行卡网络请求
- (void)requestMyBankCardListInfo
{
    NSString * action=[NSString stringWithFormat:@"api/my/tuijianhuiyuan?ps=10&pn=%ld",(long)_page];
    
    [ZJMyPageRequest GETMyMemberListRequestWithActions:action result:^(BOOL success, id responseData) {
        
        [self performSelectorOnMainThread:@selector(showProgress) withObject:self waitUntilDone:YES];
        
        if (success) {
            
            [self performSelectorOnMainThread:@selector(dismissProgress) withObject:self waitUntilDone:YES];
            
            if (_page==1) {
                
                [self.tableViewdateSource removeAllObjects];
                
            }
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                
                DLog(@"%@",responseData);
                
                NSArray * itemarray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                for (int i=0; i<itemarray.count; i++) {
                    ZJMyBankCardHomeItem * item=[ZJMyBankCardHomeItem itemForDictionary:[itemarray objectAtIndex:i]];
                    
                    [self.tableViewdateSource addObject:item];
                }
                [self.DebtTable reloadData];
                
            }else{
                [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"%@",[responseData objectForKey:@"message"]]];
            }
            
        }else{
            [ZJUtil showBottomToastWithMsg:@"请求失败"];
        }
        [self.DebtTable.mj_header endRefreshing];
        [self.DebtTable.mj_footer endRefreshing];
        
    }];
    
}

//  跳转至添加银行卡页面
-(void)addBankCard
{
    ZJaddBankCardController *addBankCardVC = [[ZJaddBankCardController alloc]initWithNibName:@"ZJaddBankCardController" bundle:nil];
    [self.navigationController pushViewController:addBankCardVC animated:YES];
    
}

-(NSMutableArray *)tableViewdateSource
{
    if (_tableViewdateSource == nil) {
        _tableViewdateSource = [NSMutableArray array];
        
    }
    return _tableViewdateSource;
}



#pragma mark TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableViewdateSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableViewdateSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str  =@"vsd";
    ZJBankCardTableViewCell *bankCardCell = [tableView dequeueReusableCellWithIdentifier:str];
    if (bankCardCell == nil) {
        bankCardCell = [[[NSBundle mainBundle]loadNibNamed:@"ZJBankCardTableViewCell" owner:self options:nil]firstObject];
    }
    bankCardCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [bankCardCell setitem:[self.tableViewdateSource objectAtIndex:indexPath.row]];
    return bankCardCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [ZJBankCardTableViewCell getCellHeight];
}

@end
