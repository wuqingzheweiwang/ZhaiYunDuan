//
//  ZJBusinesscollegeViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/4/23.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBusinesscollegeViewController.h"
#import "ZJBusinesscolledgTableViewCell.h"
#import "ZJNewsDetailsViewController.h"
#import "ZJVideoPlayViewController.h"
@interface ZJBusinesscollegeViewController ()

@end

@implementation ZJBusinesscollegeViewController
{
    __weak IBOutlet UITableView * _bussinesscollegeTable;
}
- (void)viewDidLoad {
    [super viewDidLoad];


    [ZJNavigationPublic setTitleOnTargetNav:self title:@"商学院"];
    
    _bussinesscollegeTable.top=0;
    _bussinesscollegeTable.left=0;
    _bussinesscollegeTable.width=ZJAPPWidth;
    _bussinesscollegeTable.height=ZJAPPHeight;
    _bussinesscollegeTable.showsVerticalScrollIndicator = NO;
    _bussinesscollegeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_bussinesscollegeTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [_bussinesscollegeTable setTableHeaderView:[[UIView alloc] initWithFrame:CGRectZero]];
}
#pragma mark  tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
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
    [cell setitem:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row==0) {
//        ZJNewsDetailsViewController *zjNewsVC = [[ZJNewsDetailsViewController alloc]initWithNibName:@"ZJNewsDetailsViewController" bundle:nil];
//        
//        NSString *url = @"http://v.youku.com/v_show/id_XMjYxMDU3NTI0NA==.html";
//        zjNewsVC.newsurl = url;
//        zjNewsVC.newstitle = @"商学院";
//        [self.navigationController pushViewController:zjNewsVC animated:YES];
        ZJVideoPlayViewController * videoPlayViewC =[[ZJVideoPlayViewController alloc]init];
        videoPlayViewC.movieUrl = @"http://baobab.wdjcdn.com/1455782903700jy.mp4";
        videoPlayViewC.navgationTitle = @"视频";
        [self.navigationController pushViewController:videoPlayViewC animated:YES];

    }else if (indexPath.row==1){
        ZJNewsDetailsViewController *zjNewsVC = [[ZJNewsDetailsViewController alloc]initWithNibName:@"ZJNewsDetailsViewController" bundle:nil];
        NSString *url = @"http://v.youku.com/v_show/id_XMjYxMDU3NTkwMA==.html";
        zjNewsVC.newsurl = url;
        zjNewsVC.newstitle = @"商学院";
        [self.navigationController pushViewController:zjNewsVC animated:YES];
    }else if (indexPath.row==2){
        ZJNewsDetailsViewController *zjNewsVC = [[ZJNewsDetailsViewController alloc]initWithNibName:@"ZJNewsDetailsViewController" bundle:nil];
        NSString *url = @"http://v.youku.com/v_show/id_XMjYxMDU3NzI2MA==.html";
        zjNewsVC.newsurl = url;
        zjNewsVC.newstitle = @"商学院";
        [self.navigationController pushViewController:zjNewsVC animated:YES];
    }
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
