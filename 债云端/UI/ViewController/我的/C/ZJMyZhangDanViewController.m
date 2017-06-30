//
//  ZJMyZhangDanViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/5/3.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJMyZhangDanViewController.h"
#import "ZJMyZhangDanTableViewCell.h"
@interface ZJMyZhangDanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) NSMutableArray *tableViewdataSource;
@property (nonatomic , strong) NSArray *tableViewSectionHeader;
@property (nonatomic , strong) UITableView *tableView;

@end

@implementation ZJMyZhangDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavcaition];
    [self setMyZhangDanUI];

}

-(void)viewWillAppear:(BOOL)animated
{
    [NSThread detachNewThreadSelector:@selector(postMyZahngDanDataRequest) toTarget:self withObject:nil];
}
-(void)setNavcaition
{
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"我的账单"];
    [ZJNavigationPublic setLeftButtonOnTargetNav:self action:@selector(leftAction) With:[UIImage imageNamed:@"back"]];
}

-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)setMyZhangDanUI
{
    [self.view addSubview:self.tableView];
    
    
}

// 我的账单数据请求
-(void)postMyZahngDanDataRequest
{
    NSMutableDictionary * dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"",nil];
    [self performSelectorOnMainThread:@selector(showProgress) withObject:self waitUntilDone:YES];
    
    // 网络请求
    [ZJMyPageRequest zjPOSTMyZhangDanRequestWithParams:dic result:^(BOOL success, id responseData) {
        
        [self performSelectorOnMainThread:@selector(dismissProgress) withObject:self waitUntilDone:YES];
        
        // 成功
        if (success) {
            
            NSLog(@"1111111%@",responseData);
            // 后台设定成功
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                
                
                
                
                [self performSelectorOnMainThread:@selector(reloadUI) withObject:nil waitUntilDone:YES];
                
                
                // 后台设定失败
            }else if ([[responseData objectForKey:@"state"]isEqualToString:@"warn"]) {
                
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
            
        }else{
            
            [ZJUtil showBottomToastWithMsg:@"请求失败"];
        }
        
    }];
    

    
}


// 刷新UI
-(void)reloadUI
{
    
    
}

-(NSMutableArray *)tableViewdataSource
{
    
    if (_tableViewdataSource == nil) {
        
        _tableViewdataSource = [NSMutableArray arrayWithObjects:
    @[
  @[@"今天",@"05-01",@"head",@"+350.00",@"呵呵哈哈哈"],                                 @[@"昨天",@"05-01",@"head",@"+350.00",@"吼吼"],                                  @[@"周二",@"05-02",@"head",@"+350.00",@"十三反反复复所"],                                  ],
    @[
  @[@"周三",@"04-11",@"head-portrait",@"+1250.00",@"方式的的"],
  @[@"周五",@"04-11",@"head-portrait",@"+1350.00",@"大葱"],
  @[@"周六",@"04-12",@"head",@"+1350.00",@"讲课我V领是我去问问"],
  ],
                                nil];
    }
    return _tableViewdataSource;
}

-(NSArray *)tableViewSectionHeader
{
    if (_tableViewSectionHeader == nil) {
        
        _tableViewSectionHeader =@[@"05/2017",@"04/2017"];
    }
    return _tableViewSectionHeader;

}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    
    return _tableView;
}

#pragma mark tableViewdelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableViewdataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.tableViewdataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str  =@"vsd";
    ZJMyZhangDanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"ZJMyZhangDanTableViewCell" owner:self options:nil]firstObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.weekLabel.text = self.tableViewdataSource[indexPath.section][indexPath.row][0];
    cell.monthLabel.text = self.tableViewdataSource[indexPath.section][indexPath.row][1];
    cell.imageViewH.image = [UIImage imageNamed:self.tableViewdataSource[indexPath.section][indexPath.row][2]];
    cell.textLabelH.text = self.tableViewdataSource[indexPath.section][indexPath.row][3];
    cell.detialTextLabel.text = self.tableViewdataSource[indexPath.section][indexPath.row][4];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return TRUE_1(100/2);
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, TRUE_1(80/2))];
    view.backgroundColor = ZJColor_efefef;
    UILabel *label = [[UILabel alloc]init];
    label.top = TRUE_1(25/2);
    label.left = TRUE_1(30/2);
    label.width = TRUE_1(130/2);
    label.height = TRUE_1(25/2);
    label.centerY = view.centerY;
    label.font = ZJ_FONT(15);
    label.text = self.tableViewSectionHeader[section];
    label.textColor = ZJColor_333333;
    [view addSubview:label];
 
    if (section == 0) {
        
        UIButton *dateBut = [UIButton buttonWithType:UIButtonTypeCustom];
        dateBut.top = label.top;
        dateBut.width = TRUE_1(34);
        dateBut.height = dateBut.width;
        dateBut.right = ZJAPPWidth - TRUE_1(40/2) - dateBut.width;
        dateBut.centerY = label.centerY;
        [dateBut setImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
        [view addSubview:dateBut];
    }
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TRUE_1(40);
}

@end
