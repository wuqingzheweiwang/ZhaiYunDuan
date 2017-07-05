//
//  JHPickView.m
//  SmallCityStory
//
//  Created by Jivan on 2017/5/8.
//  Copyright © 2017年 Jivan. All rights reserved.
//


#import "JHPickView.h"
#import "CityModelData.h"
#import "MySingleton.h"
@interface JHPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    Province *provinceValue;
    City *cityValue;
    District *dictrict;
}
@property (nonatomic,strong)UIView *bgV;

@property (nonatomic,strong)UIButton *cancelBtn;

@property (nonatomic,strong)UIButton *conpleteBtn;


@property (nonatomic,strong)UIPickerView *pickerV;


@property (nonatomic,strong)NSMutableArray *array;

@property (nonatomic,strong) UIView* line ;
/**
 *  所有的省份
 */
@property (nonatomic,strong)NSMutableArray *allProvince;
/**
 *  选中的省份对应的下标
 */
@property (nonatomic,assign)NSInteger      selectRowWithProvince;
/**
 *  选中的市级对应的下标
 */
@property (nonatomic,assign)NSInteger      selectRowWithCity;
/**
 *  选中的县级对应的下标
 */
@property (nonatomic,assign)NSInteger      selectRowWithTown;
/**
 *  城市模型数据
 */
@property (nonatomic,strong)CityModelData  *cityModel;

@property (nonatomic,strong)NSDictionary *allAreaNameAndId;
@end

@implementation JHPickView

-(NSMutableArray *)allProvince{
    if (_allProvince==nil) {
        
        _allProvince= (NSMutableArray *)self.cityModel.data ;
    }
    return _allProvince;
}

-(CityModelData *)cityModel{
    
    if (_cityModel==nil) {
        MySingleton *mySing=[MySingleton shareMySingleton];
        if (mySing.cityModel) {
            _cityModel=mySing.cityModel;
        }
        else{
            NSString *jsonPath=[[NSBundle mainBundle]pathForResource:@"province_data.json" ofType:nil];
            NSData *jsonData=[[NSData alloc]initWithContentsOfFile:jsonPath];
            NSString *stringValue=[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSDictionary *dicValue=[mySing getObjectFromJsonString:stringValue];  // 将本地JSON数据转为对象
            _cityModel=[CityModelData mj_objectWithKeyValues:dicValue];
            mySing.cityModel=_cityModel;
        }
    }
    return _cityModel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.array = [NSMutableArray array];
        
        self.frame = CGRectMake(0, 0, ZJAPPWidth, ZJAPPHeight);
        self.backgroundColor = RGBA(51, 51, 51, 0.8);
        self.bgV = [[UIView alloc]initWithFrame:CGRectMake(0, ZJAPPHeight, ZJAPPWidth, 260*hScale)];
        self.bgV.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bgV];
        
        [self showAnimation];
        //取消
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgV addSubview:self.cancelBtn];

        self.cancelBtn.top = 0;
        self.cancelBtn.left = 0;
        self.cancelBtn.width = TRUE_1(40);
        self.cancelBtn.height = TRUE_1(40);
        
        self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:kfont];
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.cancelBtn setTitleColor:[UIColor colorWithRed:1.00f green:0.59f blue:0.00f alpha:1.00f] forState:UIControlStateNormal];
        //完成
        self.conpleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgV addSubview:self.conpleteBtn];

        self.conpleteBtn.top = self.cancelBtn.top;
        self.conpleteBtn.left = ZJAPPWidth - self.cancelBtn.width;
        self.conpleteBtn.width = self.cancelBtn.width;
        self.conpleteBtn.height = self.cancelBtn.height;
        
        self.conpleteBtn.titleLabel.font = [UIFont systemFontOfSize:kfont];
        [self.conpleteBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.conpleteBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.conpleteBtn setTitleColor:[UIColor colorWithRed:1.00f green:0.59f blue:0.00f alpha:1.00f] forState:UIControlStateNormal];
        
        
        //线
        UIView *line = [UIView new];
        [self.bgV addSubview:line];

        line.top = self.cancelBtn.bottom;
        line.left = 0;
        line.width = ZJAPPWidth;
        line.height = TRUE_1(0.5);
        
        line.backgroundColor = RGBA(224, 224, 224, 1);
        self.line = line ;
        
    }
    return self;
}


#pragma mark - setter、getter
- (void)setArrayType:(ARRAYTYPE)arrayType
{
    _arrayType = arrayType;
    
    if (self.arrayType == AreaArray) {
        
        self.pickerV = [UIPickerView new];
        [self.bgV addSubview:self.pickerV];
        
        self.pickerV.top = self.line.bottom;
        self.pickerV.left = 0;
        self.pickerV.width = ZJAPPWidth;
        self.pickerV.height = self.bgV.height - self.cancelBtn.height-self.line.height;

        self.pickerV.delegate = self;
        self.pickerV.dataSource = self;
        
    }
    switch (arrayType) {
        
          case AreaArray:
        {
            [self getAreaData];
        }
            break ;
        default:
            break;
    }
}

-(void)getAreaData
{
    self.array = self.allProvince ;
}



#pragma mark-----UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    if (self.arrayType == AreaArray) {
        return  3 ;
    }else{
       return self.array.count;
    }
    
   
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSArray * arr = (NSArray *)[self.array objectAtIndex:component];
    
    if (self.arrayType == AreaArray) {
        
        Province *province=self.allProvince[self.selectRowWithProvince];
        City *city=province.child[self.selectRowWithCity];
        if (component==0) return self.allProvince.count;
        if (component==1) return province.child.count;
        if (component==2) return city.child.count;
        return 0;

    }
    else{
        
        return arr.count;
    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label=[[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = ZJ_TRUE_FONT(13);
    label.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    return label;
    
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.arrayType == AreaArray) {
        if (component==0) {                    // 只有点击了第一列才去刷新第二个列对应的数据
            self.selectRowWithProvince=row;   //  刷新的下标
            self.selectRowWithCity=0;
            [pickerView reloadComponent:1];  //   刷新第一,二列
            [pickerView reloadComponent:2];
        }
        else if(component==1){
            self.selectRowWithCity=row;       //  选中的市级的下标
            [pickerView reloadComponent:2];  //   刷新第三列
        }
        else if(component==2){
            self.selectRowWithTown=row;
        }

    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (self.arrayType == AreaArray) {
        NSString *showTitleValue=@"";
        if (component==0){
            Province *province=self.allProvince[row];
            showTitleValue=province.value;
        }
        if (component==1){
            Province *province=self.allProvince[self.selectRowWithProvince];
            City *city=province.child[row];
            showTitleValue=city.value;
        }
        if (component==2) {
            Province *province=self.allProvince[self.selectRowWithProvince];
            City *city=province.child[self.selectRowWithCity];
            District *dictrictObj=city.child[row];
            showTitleValue=dictrictObj.value;
        }
        return showTitleValue;

    }else{
        
        NSArray *arr = (NSArray *)[self.array objectAtIndex:component];
        return [arr objectAtIndex:row % arr.count];
    }
  
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    if ( self.arrayType == AreaArray) {
        
        return (ZJAPPWidth - 30)/3.0;
        
    }else{
        
        return (ZJAPPWidth - 30);
    }
    
}

#pragma mark-----点击方法

- (void)cancelBtnClick{
    
    [self hideAnimation];
    
}

- (void)completeBtnClick{
    
    for (int i = 0; i < self.array.count; i++) {
        
        
       if (self.arrayType == AreaArray) {
            
          if (self.selectRowWithProvince<self.allProvince.count)
          {
            
            provinceValue=self.allProvince[self.selectRowWithProvince];
              
            if (self.selectRowWithCity<provinceValue.child.count)
            {
                
              cityValue=provinceValue.child[self.selectRowWithCity];
                
                if (self.selectRowWithTown<cityValue.child.count)
                {
                
                dictrict=cityValue.child[self.selectRowWithTown];
                    

                    if (_allAreaNameAndId == nil) {
                        _allAreaNameAndId = [[NSDictionary alloc]initWithObjectsAndKeys:provinceValue.value,provinceValue.ID,
                                             cityValue.value,cityValue.ID,
                                             dictrict.value,dictrict.ID,nil];
                    }
                    
                }
                
            }
        
        }
//            fullStr = [self finaSureCity];
           
    }
        
}
    

    //传 值
    if (_delegate && [_delegate respondsToSelector:@selector(PickerSelectorInAllAreaDic:provinceID:cityID:areaID:)]) {
        
        [self.delegate PickerSelectorInAllAreaDic:self.allAreaNameAndId provinceID:provinceValue.ID cityID:cityValue.ID areaID:dictrict.ID];
    }

    [self hideAnimation];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self hideAnimation];
    
}

#pragma mark 拼接最终的值
//-(NSString *)finaSureCity{
//    
//    NSString *linkString;
//    if (self.selectRowWithProvince<self.allProvince.count) {
//        Province *provinceValue=self.allProvince[self.selectRowWithProvince];
//        if (self.selectRowWithCity<provinceValue.city.count) {
//            City *cityValue=provinceValue.city[self.selectRowWithCity];
//            if (self.selectRowWithTown<cityValue.district.count) {
//                District *dictrict=cityValue.district[self.selectRowWithTown];
//                linkString=[NSString stringWithFormat:@"%@ %@ %@",provinceValue.name,cityValue.name,dictrict.name];
//            }
//        }
//    }
//    return linkString;
//}

//隐藏动画
- (void)hideAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.bgV.frame;
        frame.origin.y = ZJAPPHeight;
        self.bgV.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [self.bgV removeFromSuperview];
        [self removeFromSuperview];
        
    }];
    
}

//显示动画
- (void)showAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.bgV.frame;
        frame.origin.y = ZJAPPHeight-260*hScale;
        self.bgV.frame = frame;
    }];
    
}


@end






