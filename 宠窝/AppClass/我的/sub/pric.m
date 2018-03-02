//
//  SYJMoreViewController.m
//  宠窝
//
//  Created by soso on 2018/1/25.
//  Copyright © 2018年 soso. All rights reserved.
//

#import "SYJMoreViewController.h"
#import "SYJOrderTableViewCell.h"
#import "SYJWriteViewController.h"

#import "SYJGoodsInfo.h"
#import "SYJmodel.h"
static NSString * cellID = @"SYJOrderTableViewCell";
@interface SYJMoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView  *tableView;
@property(nonatomic,strong)YTKKeyValueStore *store;
@property(nonatomic,strong)NSMutableArray *infoAry;
@property(nonatomic,strong)NSMutableArray *goodsAry;
@end

@implementation SYJMoreViewController
#pragma mark - 懒加载
-(NSMutableArray*)infoAry
{
    if (!_infoAry) {
        _infoAry=[SYJmodel dataArr];
    }
    return _infoAry;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.store=[[YTKKeyValueStore alloc]initDBWithName:@"my.db"];
    
    self.view.backgroundColor=[UIColor whiteColor];
        UIView *vie=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVBAR_HEIGHT+STATUS_HEIGHT)];
    vie.backgroundColor=SYJColor(120, 120, 120, 1);
    [self.view addSubview:vie];
    self.navigationItem.title=@"我的订单";
    [self.view addSubview:self.tableView];
    
    self.goodsAry=[self.store getObjectById:[[NSUserDefaults standardUserDefaults]objectForKey:@"ID"] fromTable:goodstable];
    
    
    
    
    NSLog(@"%@",self.goodsAry);
    
}
#pragma mark ***********tableview代理**********
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.goodsAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 120;//90
    
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    NSMutableDictionary *goodsDic=self.goodsAry[indexPath.row];

    NSString *roww=goodsDic[@"row"];
    NSString *sectionn=goodsDic[@"section"];
    NSLog(@"%@,%@",roww,sectionn);
    SYJmodel *model=self.infoAry[[sectionn longLongValue]];
    SYJGoodsInfo *info=model.info[[roww longLongValue]];
    
    SYJOrderTableViewCell *ordercell=[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    ordercell.nameLbl.text=info.name;
    ordercell.imageview.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",info.pictures[0]]];
    ordercell.priceLbl.text=info.price;
    ordercell.block = ^{
        SYJWriteViewController *writeVC=[[SYJWriteViewController alloc]init];
        writeVC.block = ^{
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:writeVC animated:YES];
    };
    
    return ordercell;
    
}
#pragma mark *************访问器************
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT+STATUS_HEIGHT, ScreenWidth, ScreenHeight-NAVBAR_HEIGHT-STATUS_HEIGHT) style:UITableViewStylePlain];
        //cell与cell之间的线
        //_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.separatorColor=SYJColor(223, 223, 223, 1);
        _tableView.backgroundColor=[UIColor whiteColor];
        UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 24)];
        _tableView.tableFooterView=footerView;
        _tableView.estimatedRowHeight = 90;
//        _tableView.estimatedSectionFooterHeight = 0;
//        _tableView.estimatedSectionHeaderHeight = 0;
        //_tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        [_tableView registerNib:[UINib nibWithNibName:@"SYJOrderTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
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
