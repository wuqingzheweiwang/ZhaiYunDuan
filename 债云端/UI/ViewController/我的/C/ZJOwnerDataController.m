//
//  ZJOwnerDataController.m
//  债云端
//
//  Created by 赵凯强 on 2017/5/16.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJOwnerDataController.h"
#import "ZJOwnerHeaderImageCell.h"
#import "ZJChangeTelNumberController.h"
@interface ZJOwnerDataController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImage *headerImage;
}
@property (nonatomic , strong) NSMutableArray *tableViewdataSource;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ZJOwnerDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setNavcaition];
    
    [self setOwnerDataUI];

}

-(void)setNavcaition
{
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"个人资料"];
    [ZJNavigationPublic setLeftButtonOnTargetNav:self action:@selector(leftAction) With:[UIImage imageNamed:@"back"]];
}

-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:NO];

}

-(void)setOwnerDataUI
{
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [NSThread detachNewThreadSelector:@selector(getMyPageData) toTarget:self withObject:nil];
}

-(void)getMyPageData
{
    
    [ZJMyPageRequest zjgetUserInfoWithParams:nil result:^(BOOL success, id responseData) {
        
        // 请求成功
        if (success) {
            
            NSLog(@"1111%@",responseData);
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                //
                
                self.phoneNmber = [[responseData objectForKey:@"data"] objectForKey:@"phone"];
                
                self.userName =[[responseData objectForKey:@"data"] objectForKey:@"username"];
                
                if ([[[responseData objectForKey:@"data"] objectForKey:@"image"] isEqualToString:@""]) {
                    
                    self.image = [UIImage imageNamed:@"head-portrait"];
                }else{
                    
                    
                    self.imageUrl = [[responseData objectForKey:@"data"] objectForKey:@"image"];
                    
                }
                
                [self performSelectorOnMainThread:@selector(reloadUI) withObject:nil waitUntilDone:YES];
            }else{
                
                [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"%@",[responseData objectForKey:@"message"]]];
            }
        }
        // 请求失败
        else{

        
        }
    }];
    
    
}

-(void)reloadUI
{
}

-(NSMutableArray *)tableViewdataSource
{
    if (_tableViewdataSource == nil) {
        _tableViewdataSource = [NSMutableArray arrayWithObjects:@[@[@"头像",self.imageUrl],
                               @[@"姓名",self.userName],
                               @[@"手机",self.phoneNmber]],nil];
    }
    return _tableViewdataSource;
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TRUE_1(25), ZJAPPWidth, ZJAPPHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}

#pragma mark tableViewdelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.tableViewdataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.tableViewdataSource[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"owenercell";
    
    ZJOwnerHeaderImageCell *zjOwnerheadercell = [tableView dequeueReusableCellWithIdentifier:str];
    if (zjOwnerheadercell == nil) {
        zjOwnerheadercell = [[[NSBundle mainBundle]loadNibNamed:@"ZJOwnerHeaderImageCell" owner:self options:nil]firstObject];
    }
   
    zjOwnerheadercell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        
        zjOwnerheadercell.imageLabel_1.text = self.tableViewdataSource[indexPath.section][indexPath.row][0];
        zjOwnerheadercell.imageLabel_2.hidden = YES;
        
        if (headerImage == nil) {
            if (self.imageUrl == nil) {
            
                zjOwnerheadercell.headerimageV.image = self.image;
            }else{
            [zjOwnerheadercell.headerimageV sd_setImageWithURL:self.imageUrl placeholderImage:[UIImage imageNamed:@"head-portrait"]];
            }
        }else{
            
        zjOwnerheadercell.headerimageV.image = headerImage;
            
        }
        
        
        zjOwnerheadercell.namedetialLab.hidden = YES;
        
        zjOwnerheadercell.nextbut_2.hidden = YES;
      
    }else{
        
        zjOwnerheadercell.imageLabel_1.hidden = YES;
        zjOwnerheadercell.imageLabel_2.text = self.tableViewdataSource[indexPath.section][indexPath.row][0];
        
        zjOwnerheadercell.headerimageV.hidden = YES;
        zjOwnerheadercell.namedetialLab.text = self.tableViewdataSource[indexPath.section][indexPath.row][1];

        zjOwnerheadercell.nextbut_1.hidden = YES;
    }
    if (indexPath.row == 1) {
        
        zjOwnerheadercell.nextbut_2.hidden = YES;
    }
    return zjOwnerheadercell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return TRUE_1(160/2);
    }else return TRUE_1(90/2);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
    
        [self alterHeadPortrait];
    }
    else if (indexPath.row == 1){
        
        
    }else{
        
        [self gotoTelephoneNumberView];
    }
    
}


-(void)alterHeadPortrait{
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];

}

//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    NSData *dataImage = UIImagePNGRepresentation(newPhoto);
    [UserDeafult setObject:dataImage forKey:@"userIcon"];
    // 压缩图片
    UIImage * newiamge=[ZJUtil uploadStandardImage:newPhoto];
    // 上传图片
    NSMutableArray *imageArr = [NSMutableArray arrayWithObject:newiamge];

    [[ZJDataRequest shareInstance]imagepostDataWithURLString:@"api/regist/changeimage" andParameters:nil imageArray:imageArr timeOut:20 requestSecret:YES resultSecret:YES resultWithBlock:^(BOOL success, id responseData) {
        if (success) {
            NSLog(@"成功");
            NSLog(@"%@",[responseData objectForKey:@"data"]);
        }else
        {
            NSLog(@"失败");
        }
    }];

    headerImage = [UIImage imageWithData:[UserDeafult objectForKey:@"userIcon"]];
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


// 手机号
-(void)gotoTelephoneNumberView
{
    
    ZJChangeTelNumberController *changTelVC = [[ZJChangeTelNumberController alloc]initWithNibName:@"ZJChangeTelNumberController" bundle:nil];
    
    [self.navigationController pushViewController:changTelVC animated:YES];
    
}

@end
