//
//  SYJWriteViewController.m
//  宠窝
//
//  Created by soso on 2018/2/27.
//  Copyright © 2018年 soso. All rights reserved.
//

#import "SYJWriteViewController.h"

@interface SYJWriteViewController ()
@property(nonatomic,strong)YTKKeyValueStore *store;
@end

@implementation SYJWriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.store=[[YTKKeyValueStore alloc]initDBWithName:@"my.db"];
    self.navigationItem.title=@"评价";
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVBAR_HEIGHT+STATUS_HEIGHT)];
    view.backgroundColor=SYJColor(120, 120, 120, 1);
    [self.view addSubview:view];
    
    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(0, STATUS_HEIGHT+NAVBAR_HEIGHT, ScreenWidth, 200)];
 
    self.textView.font=[UIFont systemFontOfSize:18];
//    self.textView.textColor=SYJColor(122, 122, 122, 1);
    self.textView.backgroundColor=SYJColor(240, 240, 240, 1);
    [self.view addSubview:self.textView];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(finish)];
    self.navigationItem.rightBarButtonItem=right;
    //页面手势
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
}
-(void)finish
{
    NSMutableArray *as=[self.store getObjectById:[[NSUserDefaults standardUserDefaults]objectForKey:@"ID"] fromTable:goodstable];
    NSMutableArray *goodsAry=[NSMutableArray array];
    if (as) {
        goodsAry=[as mutableCopy];
    }

    NSMutableDictionary *dic=goodsAry[[self.row longLongValue]];
    NSMutableDictionary *dica=[dic mutableCopy];
    NSLog(@"字典%@",dic);
    [dica setValue:self.textView.text forKey:@"myidea"];
    [goodsAry replaceObjectAtIndex:[self.row longLongValue] withObject:dica];

    [self.store putObject:goodsAry withId:[[NSUserDefaults standardUserDefaults]objectForKey:@"ID"] intoTable:goodstable];
    
    if (self.block) {
        self.block();
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma 手势
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
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
