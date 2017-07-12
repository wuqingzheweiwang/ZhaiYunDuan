//
//  ZJDebtDetailViewController.m
//  债云端
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJDebtDetailViewController.h"
#import "ZJPayMoneyViewController.h"
#import "NPPicPreviewController.h"
#define LineWidth  (ZJAPPWidth-25*6)/3
#define kImageView_W   (ZJAPPWidth - 45 - 30) / 3
#define kImageToImageWidth   45/2
@interface ZJDebtDetailViewController ()

@end

@implementation ZJDebtDetailViewController
{

    __weak IBOutlet UIScrollView *DebtBackScrollview;
    
    __weak IBOutlet UIView *DebtProgressView;//债事进度 第一个大view

    __weak IBOutlet UIView *OneLineview;

    __weak IBOutlet UILabel *DebtprogressLabel;

    __weak IBOutlet UIView *grayView;

    __weak IBOutlet UIView *DebtInfomationView; //债事信息 第二个大view

    __weak IBOutlet UILabel *DebtinfoLabel;
    __weak IBOutlet UIView *twoLineview;
    NSString *debtorderid;
    
    NSMutableArray * imagePlistl;//存放图片地址

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    debtorderid=[NSString string];
    imagePlistl=[NSMutableArray array];
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"债事详情"];
    
    [self requestData];
    
}
-(void)requestData
{
    
    NSString * action=[NSString stringWithFormat:@"api/debtrelation/detail?relationId=%@",self.DetailID];
    [self showProgress];
    [ZJDeBtManageRequest GetDebtManageDetailInfoRequestWithActions:action result:^(BOOL success, id responseData) {
        [self dismissProgress];
        NSLog(@"%@",responseData);
        if (success) {
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                [self createUIWith:[responseData objectForKey:@"data"]];
            }else{
            [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:@"请求失败"];
        }
        
    }];
    
}
- (void)createUIWith:(NSDictionary *)infoDic
{
    if ([infoDic objectForKey:@"orderId"]) {
        debtorderid=[NSString stringWithFormat:@"%@",[infoDic objectForKey:@"orderId"]];
    }
    DebtBackScrollview.width=ZJAPPWidth;
    DebtBackScrollview.height=ZJAPPHeight;
    DebtBackScrollview.top=0;
    DebtBackScrollview.left=0;
    DebtBackScrollview.hidden=NO;
    
    //上面
    DebtProgressView.top=0;
    DebtProgressView.left=0;
    DebtProgressView.width=ZJAPPWidth;
    DebtProgressView.height=120;
    
    DebtprogressLabel.top=0;
    DebtprogressLabel.left=15;
    DebtprogressLabel.width=100;
    DebtprogressLabel.height=30;
    
    OneLineview.left=0;
    OneLineview.top=29;
    OneLineview.height=1;
    OneLineview.width=ZJAPPWidth;
    NSString * workflowStatus=[NSString stringWithFormat:@"%@",[infoDic objectForKey:@"workflowStatus"]];
    if ([workflowStatus isEqualToString:@"0"]) {
        self.Btntype=1;
    }else if([workflowStatus isEqualToString:@"1"]){
        self.Btntype=2;
    }else if([workflowStatus isEqualToString:@"2"]){
        self.Btntype=3;
    }else if([workflowStatus isEqualToString:@"3"]){
        self.Btntype=4;
    }
    [self createProgressView];
    
    grayView.top=110;
    grayView.left=0;
    grayView.width=ZJAPPWidth;
    if ([[infoDic objectForKey:@"payStatus"]integerValue]==0) {
        grayView.height=30;
        UILabel * textlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, 30)];
        textlabel.font=ZJ_FONT(12);
        textlabel.textColor=ZJColor_666666;
        textlabel.textAlignment=NSTextAlignmentCenter;
        [grayView addSubview:textlabel];
        NSString *testStr =@"您未付费备案，解债服务无法继续进行，点击付费";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:testStr];
        [str addAttribute:NSForegroundColorAttributeName value:HexRGB(colorLong(@"42a5f5")) range:NSMakeRange(18, 4)];
         textlabel.attributedText = str;
        UIButton * payBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        payBtn.frame=CGRectMake(ZJAPPWidth/2, 0, ZJAPPWidth/2, 30);
        [payBtn addTarget:self action:@selector(payBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [grayView addSubview:payBtn];
        DebtProgressView.height=140;
    }else if ([[infoDic objectForKey:@"payStatus"]integerValue]==1){
        grayView.height=10;
    }
    //下面
    DebtInfomationView.left=0;
    DebtInfomationView.top=DebtProgressView.bottom;
    DebtInfomationView.width=ZJAPPWidth;
    DebtInfomationView.height=ZJAPPHeight-DebtInfomationView.height;
    
    DebtinfoLabel.top=0;
    DebtinfoLabel.left=0;
    DebtinfoLabel.width=ZJAPPWidth;
    DebtinfoLabel.height=30;
    
    twoLineview.top=29;
    twoLineview.left=0;
    twoLineview.width=ZJAPPWidth;
    twoLineview.height=1;

    //录入时间
    UIView * lurushijianview=[self createLabelWith:@"录入时间" andWithText:[NSString stringWithFormat:@"%@",[infoDic objectForKey:@"createTime"]]];
    lurushijianview.top=twoLineview.bottom+15;
    [DebtInfomationView addSubview:lurushijianview];
    //债事进展
    NSString * jinzhan=[NSString string];
    if (self.Btntype==1) {
        jinzhan=@"已提交";
    }else if (self.Btntype==2){
        jinzhan=@"统筹中";
    }else if (self.Btntype==3){
        jinzhan=@"解债中";
    }else if (self.Btntype==4){
        jinzhan=@"已解债";
    }
    UIView * zhaishijinzhanview=[self createLabelWith:@"债事进展" andWithText:jinzhan];
    zhaishijinzhanview.top=lurushijianview.bottom;
    [DebtInfomationView addSubview:zhaishijinzhanview];
    //债权人证件号
    UIView * zhaiquanrenHaomaview=[self createLabelWith:@"债权人证号" andWithText:[NSString stringWithFormat:@"%@",[[infoDic objectForKey:@"to"] objectForKey:@"idCode"]]];
    zhaiquanrenHaomaview.top=zhaishijinzhanview.bottom;
    [DebtInfomationView addSubview:zhaiquanrenHaomaview];
    //债权人名称
    UIView * zhaiquanrennameview=[self createLabelWith:@"债权人名称" andWithText:[NSString stringWithFormat:@"%@",[[infoDic objectForKey:@"to"] objectForKey:@"name"]]];
    zhaiquanrennameview.top=zhaiquanrenHaomaview.bottom;
    [DebtInfomationView addSubview:zhaiquanrennameview];
    //债务人证件号
    UIView * zhaiwurenHaomaview=[self createLabelWith:@"债务人证号" andWithText:[NSString stringWithFormat:@"%@",[[infoDic objectForKey:@"from"] objectForKey:@"idCode"]]];
    zhaiwurenHaomaview.top=zhaiquanrennameview.bottom;
    [DebtInfomationView addSubview:zhaiwurenHaomaview];
    //债务人名称
    UIView * zhaiwurennameview=[self createLabelWith:@"债务人名称" andWithText:[NSString stringWithFormat:@"%@",[[infoDic objectForKey:@"from"] objectForKey:@"name"]]];
    zhaiwurennameview.top=zhaiwurenHaomaview.bottom;
    [DebtInfomationView addSubview:zhaiwurennameview];
    //债事类型
    NSString * zhaishileixing;
    if ([[infoDic objectForKey:@"genre"] integerValue]==1) {
        zhaishileixing=@"货币";
    }else if ([[infoDic objectForKey:@"genre"] integerValue]==2){
        zhaishileixing=@"非货币";
    }
    UIView * zhaishileixingview=[self createLabelWith:@"债事类型" andWithText:zhaishileixing];
    zhaishileixingview.top=zhaiwurennameview.bottom;
    [DebtInfomationView addSubview:zhaishileixingview];
    //债事性质
    NSString * zhaishixingzhi;
    if ([[infoDic objectForKey:@"natureOf"] integerValue]==1) {
        zhaishixingzhi=@"个人";
    }else if ([[infoDic objectForKey:@"natureOf"] integerValue]==2){
        zhaishixingzhi=@"企业";
    }
    UIView * zhaishixingzhiview=[self createLabelWith:@"债事性质" andWithText:zhaishixingzhi];
    zhaishixingzhiview.top=zhaishileixingview.bottom;
    [DebtInfomationView addSubview:zhaishixingzhiview];
    //是否诉讼
    NSString * isorsusong;
    if ([[infoDic objectForKey:@"lawsuit"] integerValue]==0) {
        isorsusong=@"否";
    }else if ([[infoDic objectForKey:@"lawsuit"] integerValue]==1){
        isorsusong=@"是";
    }
    UIView * isorsusongview=[self createLabelWith:@"是否诉讼" andWithText:isorsusong];
    isorsusongview.top=zhaishixingzhiview.bottom;
    [DebtInfomationView addSubview:isorsusongview];
    //主体金额
    UIView * zhutimoneyview=[self createLabelWith:@"主体金额" andWithText:[NSString stringWithFormat:@"%@元",[infoDic objectForKey:@"amout"]]];
    zhutimoneyview.top=isorsusongview.bottom;
    [DebtInfomationView addSubview:zhutimoneyview];
    //债事发生时间
    UIView * recordTimeview=[self createLabelWith:@"债事发生时间" andWithText:[NSString stringWithFormat:@"%@",[infoDic objectForKey:@"recordTime"]]];
    recordTimeview.top=zhutimoneyview.bottom;
    [DebtInfomationView addSubview:recordTimeview];
    //备注
    UIView * remarkview=[self createLabelWith:@"备注" andWithText:[NSString stringWithFormat:@"%@",[infoDic objectForKey:@"remark"]]];
    remarkview.top=recordTimeview.bottom;
    [DebtInfomationView addSubview:remarkview];
    //是否有债务人偿还欠款及利息的证据
    NSString * isproof;
    if ([[infoDic objectForKey:@"proof"] integerValue]==0) {
        isproof=@"否";
    }else if ([[infoDic objectForKey:@"proof"] integerValue]==1){
        isproof=@"是";
    }
    UIView * isproofview=[self createLabelWith:@"是否有债务人偿还欠款及利息的证据" andWithText:isproof];
    isproofview.top=remarkview.bottom;
    [DebtInfomationView addSubview:isproofview];
    //是否有担保或者抵押的证明材料
    NSString * ismortgagee;
    if ([[infoDic objectForKey:@"mortgagee"] integerValue]==0) {
        ismortgagee=@"否";
    }else if ([[infoDic objectForKey:@"mortgagee"] integerValue]==1){
        ismortgagee=@"是";
    }
    UIView * ismortgageeview=[self createLabelWith:@"是否有担保或者抵押的证明材料" andWithText:ismortgagee];
    ismortgageeview.top=isproofview.bottom;
    [DebtInfomationView addSubview:ismortgageeview];
    //是否有债务转让证明材料
    NSString * isattorn;
    if ([[infoDic objectForKey:@"attorn"] integerValue]==0) {
        isattorn=@"否";
    }else if ([[infoDic objectForKey:@"attorn"] integerValue]==1){
        isattorn=@"是";
    }
    UIView * isattornview=[self createLabelWith:@"是否有债务转让证明材料" andWithText:isattorn];
    isattornview.top=ismortgageeview.bottom;
    [DebtInfomationView addSubview:isattornview];
    //是否曾涉及诉讼、公证及支付令等法律文书
    NSString * islawsuit;
    if ([[infoDic objectForKey:@"lawsuit"] integerValue]==0) {
        islawsuit=@"否";
    }else if ([[infoDic objectForKey:@"lawsuit"] integerValue]==1){
        islawsuit=@"是";
    }
    UIView * islawsuitview=[self createLabelWith:@"是否曾涉及诉讼、公证及支付令等法律文书" andWithText:islawsuit];
    islawsuitview.top=isattornview.bottom;
    [DebtInfomationView addSubview:islawsuitview];
    //身份证明
    NSArray * identificationArray=[infoDic objectForKey:@"identification"];
    NSString * identificationString=[NSString string];
    for (int i = 0; i<identificationArray.count; i++) {
        if ([[identificationArray objectAtIndex:i]isEqualToString:@"1"]) {
            identificationString=[NSString stringWithFormat:@"营业执照副本复印件 %@",identificationString];
        }
        if ([[identificationArray objectAtIndex:i]isEqualToString:@"2"]) {
            identificationString=[NSString stringWithFormat:@"%@ 组织机构代码证复印件",identificationString];
        }
        if ([[identificationArray objectAtIndex:i]isEqualToString:@"3"]) {
            identificationString=[NSString stringWithFormat:@"%@ 法人身份证复印件",identificationString];
        }
    }
    UIView * identificationview=[self createLabelWith:@"身份证明" andWithText:identificationString];
    identificationview.top=islawsuitview.bottom;
    [DebtInfomationView addSubview:identificationview];
    //票据证明
    NSArray * evidenceArray=[infoDic objectForKey:@"evidence"];
    NSString * evidenceString=[NSString string];
    for (int i = 0; i<evidenceArray.count; i++) {
        if ([[evidenceArray objectAtIndex:i]isEqualToString:@"1"]) {
            evidenceString=[NSString stringWithFormat:@"合同 %@",evidenceString];
        }
        if ([[evidenceArray objectAtIndex:i]isEqualToString:@"2"]) {
            evidenceString=[NSString stringWithFormat:@"%@ 收据",evidenceString];
        }
        if ([[evidenceArray objectAtIndex:i]isEqualToString:@"3"]) {
            evidenceString=[NSString stringWithFormat:@"%@ 借据",evidenceString];
        }
        if ([[evidenceArray objectAtIndex:i]isEqualToString:@"4"]) {
            evidenceString=[NSString stringWithFormat:@"%@ 欠据",evidenceString];
        }
        if ([[evidenceArray objectAtIndex:i]isEqualToString:@"5"]) {
            evidenceString=[NSString stringWithFormat:@"%@ 协议",evidenceString];
        }
        if ([[evidenceArray objectAtIndex:i]isEqualToString:@"6"]) {
            evidenceString=[NSString stringWithFormat:@"%@ 信件",evidenceString];
        }
        if ([[evidenceArray objectAtIndex:i]isEqualToString:@"7"]) {
            evidenceString=[NSString stringWithFormat:@"%@ 电报",evidenceString];
        }
        if ([[evidenceArray objectAtIndex:i]isEqualToString:@"8"]) {
            evidenceString=[NSString stringWithFormat:@"%@ 提货单",evidenceString];
        }
        if ([[evidenceArray objectAtIndex:i]isEqualToString:@"9"]) {
            evidenceString=[NSString stringWithFormat:@"%@ 仓单发票",evidenceString];
        }
        if ([[evidenceArray objectAtIndex:i]isEqualToString:@"10"]) {
            evidenceString=[NSString stringWithFormat:@"%@ 其他",evidenceString];
        }
    }
    UIView * evidenceview=[self createLabelWith:@"票据证明" andWithText:evidenceString];
    evidenceview.top=identificationview.bottom;
    [DebtInfomationView addSubview:evidenceview];
    //电子数据
    NSArray * electronArray=[infoDic objectForKey:@"electron"];
    NSString * electronString=[NSString string];
    for (int i = 0; i<electronArray.count; i++) {
        if ([[electronArray objectAtIndex:i]isEqualToString:@"1"]) {
            electronString=[NSString stringWithFormat:@"微信 %@",electronString];
        }
        if ([[electronArray objectAtIndex:i]isEqualToString:@"2"]) {
            electronString=[NSString stringWithFormat:@"%@ QQ",electronString];
        }
        if ([[electronArray objectAtIndex:i]isEqualToString:@"3"]) {
            electronString=[NSString stringWithFormat:@"%@ MSN",electronString];
        }
        if ([[electronArray objectAtIndex:i]isEqualToString:@"4"]) {
            electronString=[NSString stringWithFormat:@"%@ 微博",electronString];
        }
        if ([[electronArray objectAtIndex:i]isEqualToString:@"5"]) {
            electronString=[NSString stringWithFormat:@"%@ 其他",electronString];
        }
    }
    UIView * electronview=[self createLabelWith:@"电子数据" andWithText:electronString];
    electronview.top=evidenceview.bottom;
    [DebtInfomationView addSubview:electronview];
    //图片
    NSArray * picListarray=[infoDic objectForKey:@"picList"];
    if (picListarray.count>12) {
        NSString * compendString=[NSString string];
        for (int i=0; i<picListarray.count; i++) {
            compendString=[compendString stringByAppendingString:[NSString stringWithFormat:@"%@",[picListarray objectAtIndex:i]]];
        }
        NSArray * imageplist=[compendString componentsSeparatedByString:@","];
        [imagePlistl addObjectsFromArray:imageplist];
        UIView * imagebackview=[self createNineImageView:imageplist];
        imagebackview.top=electronview.bottom;
        [DebtInfomationView addSubview:imagebackview];
        DebtInfomationView.height=imagebackview.bottom;
        [DebtBackScrollview setContentSize:CGSizeMake(0, DebtInfomationView.bottom+15)];
    }else{
        [imagePlistl addObjectsFromArray:picListarray];
        UIView * imagebackview=[self createNineImageView:picListarray];
        imagebackview.top=electronview.bottom;
        [DebtInfomationView addSubview:imagebackview];
        DebtInfomationView.height=imagebackview.bottom;
        [DebtBackScrollview setContentSize:CGSizeMake(0, DebtInfomationView.bottom+15)];
    }
}
//创建进度view
-(void)createProgressView
{
    UIView * ProgressView=[[UIView alloc]initWithFrame:CGRectMake(0, 30, ZJAPPWidth, 80)];
    [DebtProgressView addSubview:ProgressView];
    //1
    UIImageView * Oneimageview=[[UIImageView alloc]initWithFrame:CGRectMake(25, 20, 25, 25)];
    [ProgressView addSubview:Oneimageview];
    UILabel *Onelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 60, 12)];
    Onelabel.centerX=Oneimageview.centerX;
    Onelabel.text=@"已提交";
    Onelabel.textAlignment=NSTextAlignmentCenter;
    Onelabel.textColor=ZJColor_666666;
    Onelabel.font=ZJ_FONT(12);
    [ProgressView addSubview:Onelabel];
    UIView * onelineview=[[UIView alloc]initWithFrame:CGRectMake(Oneimageview.right, 20+25/2, LineWidth, 1)];
    [ProgressView addSubview:onelineview];
   
    //2
    UIImageView * twoimageview=[[UIImageView alloc]initWithFrame:CGRectMake(Oneimageview.right+LineWidth, 20, 25, 25)];
    [ProgressView addSubview:twoimageview];
    UILabel *twolabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 60, 12)];
    twolabel.centerX=twoimageview.centerX;
    twolabel.text=@"统筹中";
    twolabel.textAlignment=NSTextAlignmentCenter;
    twolabel.textColor=ZJColor_666666;
    twolabel.font=ZJ_FONT(12);
    [ProgressView addSubview:twolabel];
    
    UIView * twolineview=[[UIView alloc]initWithFrame:CGRectMake(twoimageview.right, 20+25/2, LineWidth, 1)];
    [ProgressView addSubview:twolineview];
    
    //3
    UIImageView * Threeimageview=[[UIImageView alloc]initWithFrame:CGRectMake(twoimageview.right+LineWidth, 20, 25, 25)];
    [ProgressView addSubview:Threeimageview];
    UILabel *Threelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 60, 12)];
    Threelabel.centerX=Threeimageview.centerX;
    Threelabel.text=@"解债中";
    Threelabel.textAlignment=NSTextAlignmentCenter;
    Threelabel.textColor=ZJColor_666666;
    Threelabel.font=ZJ_FONT(12);
    [ProgressView addSubview:Threelabel];
    UIView * threelineview=[[UIView alloc]initWithFrame:CGRectMake(Threeimageview.right, 20+25/2, LineWidth, 1)];
    [ProgressView addSubview:threelineview];
    
    
    
    UIImageView * Fourimageview=[[UIImageView alloc]initWithFrame:CGRectMake(Threeimageview.right+LineWidth, 20, 25, 25)];
    [ProgressView addSubview:Fourimageview];
    UILabel *Fourlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 60, 12)];
    Fourlabel.centerX=Fourimageview.centerX;
    Fourlabel.text=@"已解债";
    Fourlabel.textAlignment=NSTextAlignmentCenter;
    Fourlabel.textColor=ZJColor_666666;
    Fourlabel.font=ZJ_FONT(12);
    [ProgressView addSubview:Fourlabel];
    
    if (_Btntype==1) {
        Oneimageview.image=[UIImage imageNamed:@"detailedProgresssuccess"];
        twoimageview.image=[UIImage imageNamed:@"detailedProgress2"];
        Threeimageview.image=[UIImage imageNamed:@"detailedProgress3"];
        Fourimageview.image=[UIImage imageNamed:@"detailedProgress4"];
        
        onelineview.backgroundColor=ZJColor_red;
        twolineview.backgroundColor=ZJColor_dddddd;
        threelineview.backgroundColor=ZJColor_dddddd;
        
    }else if (_Btntype==2){
        Oneimageview.image=[UIImage imageNamed:@"detailedProgresssuccess"];
        twoimageview.image=[UIImage imageNamed:@"detailedProgresssuccess"];
        Threeimageview.image=[UIImage imageNamed:@"detailedProgress3"];
        Fourimageview.image=[UIImage imageNamed:@"detailedProgress4"];
        
        onelineview.backgroundColor=ZJColor_red;
        twolineview.backgroundColor=ZJColor_red;
        threelineview.backgroundColor=ZJColor_dddddd;

    }else if (_Btntype==3){
        Oneimageview.image=[UIImage imageNamed:@"detailedProgresssuccess"];
        twoimageview.image=[UIImage imageNamed:@"detailedProgresssuccess"];
        Threeimageview.image=[UIImage imageNamed:@"detailedProgresssuccess"];
        Fourimageview.image=[UIImage imageNamed:@"detailedProgress4"];
        
        onelineview.backgroundColor=ZJColor_red;
        twolineview.backgroundColor=ZJColor_red;
        threelineview.backgroundColor=ZJColor_red;
        
    }else if (_Btntype==4){
        Oneimageview.image=[UIImage imageNamed:@"detailedProgresssuccess"];
        twoimageview.image=[UIImage imageNamed:@"detailedProgresssuccess"];
        Threeimageview.image=[UIImage imageNamed:@"detailedProgresssuccess"];
        Fourimageview.image=[UIImage imageNamed:@"detailedProgresssuccess"];
        
        onelineview.backgroundColor=ZJColor_red;
        twolineview.backgroundColor=ZJColor_red;
        threelineview.backgroundColor=ZJColor_red;
    
    }
    
}
//自定义
- (UIView *)createLabelWith:(NSString *)title andWithText:(NSString *)text
{
    UIView * labelview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, 0)];
    UILabel  * label=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, ZJAPPWidth-30, 0)];
    label.textColor=ZJColor_666666;
    label.font=ZJ_FONT(15);
    label.numberOfLines=0;
    NSString * textsring=[NSString stringWithFormat:@"%@：%@",title,text];
    
    NSMutableAttributedString * mastring = [[NSMutableAttributedString alloc]initWithString:textsring];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];//调整行间距
    
    [mastring addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textsring length])];
    [mastring addAttribute:NSFontAttributeName value:label.font range:NSMakeRange(0, mastring.length)];
    label.attributedText = mastring;
    
    CGFloat width = label.width;
    
    CGRect rect = [mastring boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    label.height = rect.size.height;
    [labelview addSubview:label];
    labelview.height=label.height;
    return labelview;
}
/**
 *  九宫格
 *
 */
- (UIView *)createNineImageView:(NSArray *)imageArr {
    
    UIView * imageBackView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, 0)];
    for (int i=0; i<imageArr.count; i++) {
        NSString * newImage=[imageArr objectAtIndex:i];
        UIImageView * imageView=[[UIImageView alloc] initWithFrame:CGRectMake(15 + (i % 3) * (kImageView_W + kImageToImageWidth), 20 + (i / 3) * (kImageView_W + kImageToImageWidth), kImageView_W, kImageView_W)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:newImage] placeholderImage:[UIImage imageNamed:@"backGroundDefault"]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [imageBackView addSubview:imageView];
        imageBackView.bottom=imageView.bottom+20;
        
        UIButton *imageButton = [[UIButton alloc] initWithFrame:CGRectMake(15 + (i % 3) * (kImageView_W + kImageToImageWidth), 20 + (i / 3) * (kImageView_W + kImageToImageWidth), kImageView_W, kImageView_W)];
        [imageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        imageButton.backgroundColor=[UIColor clearColor];
        imageButton.tag = 250 + i;
        [imageBackView addSubview:imageButton];
    }
    return imageBackView;
}

//解债方案Btn
- (IBAction)JieZhaiBtnAction:(id)sender {
}
//付费
- (void)payBtnAction
{
    ZJPayMoneyViewController * zjDdVC=[[ZJPayMoneyViewController alloc]initWithNibName:@"ZJPayMoneyViewController" bundle:nil];
    zjDdVC.isManager=ZJisBankManegerYes;
    zjDdVC.orderid=debtorderid;
    zjDdVC.type=@"1";
    zjDdVC.payAmount = self.payAmount;
    [zjDdVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:zjDdVC animated:YES];
}

/**
 *  图片点击事件
 */
- (void)imageButtonAction:(UIButton *)button
{
    NPPicPreviewController *picPreviewVC = [[NPPicPreviewController alloc] init];
    picPreviewVC.urlimages = imagePlistl;
    picPreviewVC.offsetX = ZJAPPWidth*(button.tag-250);
    [self.navigationController pushViewController:picPreviewVC animated:NO];
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
