//
//  SYJbespeakViewController.m
//  宠窝
//
//  Created by soso on 2018/3/1.
//  Copyright © 2018年 soso. All rights reserved.
//

#import "SYJbespeakViewController.h"
#import "STPickerSingle.h"
#import "STPickerDate.h"

@interface SYJbespeakViewController ()<UITextFieldDelegate, STPickerSingleDelegate, STPickerDateDelegate>
@property(nonatomic,strong)YTKKeyValueStore *store;
@end

@implementation SYJbespeakViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.store=[[YTKKeyValueStore alloc]initDBWithName:@"my.db"];
    self.navigationItem.title=@"预约";
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVBAR_HEIGHT+STATUS_HEIGHT)];
    view.backgroundColor=SYJColor(255, 26, 0, 1);
    [self.view addSubview:view];
    self.datetxtfield.delegate=self;
    self.numberDay.delegate=self;
}
- (IBAction)putin:(UIButton *)sender {
    if (self.datetxtfield.text.length>0&&self.numberDay.text.length
        >0) {
        NSLog(@"%ld,%ld",self.section,self.row);
        
        NSMutableArray *as=[self.store getObjectById:[[NSUserDefaults standardUserDefaults]objectForKey:@"ID"] fromTable:goodstable];
        NSMutableArray *goodsAry=[NSMutableArray array];
        if (as) {
            goodsAry=[as mutableCopy];
        }
        
        
        NSMutableDictionary*goods=[NSMutableDictionary dictionary];
        [goods setValue:[NSString stringWithFormat:@"%ld",self.row] forKey:@"row"];
        [goods setValue:[NSString stringWithFormat:@"%ld",self.section] forKey:@"section"];
        
        [goods setValue:self.datetxtfield.text forKey:@"time"];
        [goods setValue:self.numberDay.text forKey:@"day"];
        [goods setValue:@"" forKey:@"myidea"];
        [goodsAry addObject:goods];
        [self.store putObject:goodsAry withId:[[NSUserDefaults standardUserDefaults]objectForKey:@"ID"] intoTable:goodstable];
        //测试
        NSMutableArray *aas=[self.store getObjectById:[[NSUserDefaults standardUserDefaults]objectForKey:@"ID"] fromTable:goodstable];
        
        NSLog(@"订单完成%@",aas);
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [SYJProgressHUD showMessage:@"请填写信息" inView:self.view afterDelayTime:1];
    }
}
#pragma mark - --- delegate 视图委托 ---

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

    
    if (textField == self.numberDay) {
        [self.numberDay resignFirstResponder];
        
        NSMutableArray *arrayData = [NSMutableArray array];
        for (int i = 1; i < 1000; i++) {
            NSString *string = [NSString stringWithFormat:@"%d", i];
            [arrayData addObject:string];
        }
        
        STPickerSingle *single = [[STPickerSingle alloc]init];
        [single setArrayData:arrayData];
        [single setTitle:@"请选择天数"];
        [single setTitleUnit:@"天"];
        [single setDelegate:self];
        [single show];
    }
    
    
    if (textField == self.datetxtfield) {
        [self.datetxtfield resignFirstResponder];
        STPickerDate *datePicker = [[STPickerDate alloc]initWithDelegate:self];
        [datePicker show];
    }
    
}



- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle
{
    NSString *text = [NSString stringWithFormat:@"%@ 天", selectedTitle];
    self.numberDay.text = text;
}

- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString *text = [NSString stringWithFormat:@"%ld年%ld月%ld日", (long)year, (long)month, (long)day];
    self.datetxtfield.text = text;
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
