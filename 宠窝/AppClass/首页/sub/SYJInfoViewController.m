//
//  SYJInfoViewController.m
//  宠窝
//
//  Created by soso on 2018/1/25.
//  Copyright © 2018年 soso. All rights reserved.
//

#import "SYJInfoViewController.h"
#import "SYJMoreViewController.h"
#import "SYJPhotoTableViewCell.h"
#import "SYJphotoCollectionViewCell.h"
#import "SYJGoodsTableViewCell.h"
#import "SYJParameterTableViewCell.h"
#import "SYJbespeakViewController.h"
static NSString *cellId = @"SYJphotoCollectionViewCell";
static NSString * PhotocellID=@"SYJPhotoTableViewCell";
static NSString * GoodscellID=@"SYJGoodsTableViewCell";
static NSString * ParametercellID=@"SYJParameterTableViewCell";
@interface SYJInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIButton *bottomBtn;
@property (nonatomic, strong) UITableView  *tableView;

@property(nonatomic,strong)SYJPhotoTableViewCell *photoCell;
@property(nonatomic,strong)SYJGoodsTableViewCell *GoodsCell;
@property(nonatomic,strong)SYJParameterTableViewCell *ParameterCell;
@end

@implementation SYJInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"商品详情";
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVBAR_HEIGHT+STATUS_HEIGHT)];
    view.backgroundColor=SYJColor(255, 26, 0, 1);
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomBtn];
    [self.view addSubview:view];
  
}
-(void)viewWillAppear:(BOOL)animated
{
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)button
{
    NSLog(@"点击了预约");
    SYJbespeakViewController *bespeak=[[SYJbespeakViewController alloc]init];
    bespeak.row=self.row;
    bespeak.section=self.section;
    bespeak.price=self.price;
    [self.navigationController pushViewController:bespeak animated:YES];
}
#pragma mark ***********tableview代理**********
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==3) {
        return 6;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return ScreenWidth;
    }
    else if (indexPath.section==1)
    {
        return 110;
    }
    else if(indexPath.section==2)
    {
        return 110;
    }
    else
    {
        return 60;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==2) {
        return 8;
    }
    else if (section==3)
    {
        return 30;
    }
    else
        return 0;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==3) {
        UIView *view=[[UIView alloc]init];
        view.backgroundColor=SYJColor(248, 248, 248, 1);
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
        lbl.text=@"   用户评价";
        lbl.font=[UIFont systemFontOfSize:15];
        [view addSubview:lbl];
        return view;
    }
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=SYJColor(248, 248, 248, 1);
    return view;
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        self.photoCell=[tableView dequeueReusableCellWithIdentifier:PhotocellID forIndexPath:indexPath];
        //取消选中状态
        self.photoCell.selectionStyle =UITableViewCellSelectionStyleNone;
        [self.photoCell.collectionView registerNib:[UINib nibWithNibName:@"SYJphotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellId];
        self.photoCell.collectionView.dataSource=self;
        self.photoCell.collectionView.delegate=self;
        self.photoCell.collectionView.pagingEnabled=YES;
        return self.photoCell;
    }
    else if(indexPath.section==1)
    {
        self.GoodsCell=[tableView dequeueReusableCellWithIdentifier:GoodscellID forIndexPath:indexPath];
        self.GoodsCell.selectionStyle =UITableViewCellSelectionStyleNone;
        self.GoodsCell.nameLbl.text=self.name;
        self.GoodsCell.peopleLbl.text=[NSString stringWithFormat:@"月销量:%@",self.people];
        self.GoodsCell.priceLbl.text=[NSString stringWithFormat:@"¥%@/天",self.price];
        
        return self.GoodsCell;
    }
    else if(indexPath.section==2)
    {
        self.ParameterCell=[tableView dequeueReusableCellWithIdentifier:ParametercellID forIndexPath:indexPath];
        self.ParameterCell.selectionStyle=UITableViewCellSelectionStyleNone;
        self.ParameterCell.sizeLbl.text=[NSString stringWithFormat:@"尺码:%@",self.size];
        self.ParameterCell.colourLbl.text=[NSString stringWithFormat:@"颜色:%@",self.colour];
        self.ParameterCell.suitableLbl.text=[NSString stringWithFormat:@"适用对象:%@",self.suitable];
        return self.ParameterCell;
    }
    else
    {
        // 定义唯一标识
        static NSString *CellIdentifier = @"Cell";
        // 通过indexPath创建cell实例 每一个cell都是单独的
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.textLabel.text=@"小白:很方便";
            cell.textLabel.font=[UIFont systemFontOfSize:14];
            cell.textLabel.textColor=SYJColor(150, 150, 150, 1);
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
        }
        return cell;
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.photoCell.collectionView)
    {
        int page = scrollView.contentOffset.x / scrollView.frame.size.width;
        //    NSLog(@"%d", page);
        // 设置页码
        self.photoCell.pagecontrol.currentPage = page;
    }
}
#pragma mark ***********CollectionView代理**********
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  3;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth, ScreenWidth);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SYJphotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.image.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.pictures[indexPath.row]]];
    return cell;
}
//两个cell之间的间距（同一行的cell的间距）
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    //    if (collectionView.tag==21||collectionView.tag==22) {
//    return 0.01;
//
//}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
#pragma mark *************访问器************
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-50) style:UITableViewStylePlain];
        //cell与cell之间的线
        _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor=SYJColor(248, 248, 248, 1);

        [_tableView registerNib:[UINib nibWithNibName:@"SYJPhotoTableViewCell" bundle:nil] forCellReuseIdentifier:PhotocellID];
         [_tableView registerNib:[UINib nibWithNibName:@"SYJGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:GoodscellID];
        
        [_tableView registerNib:[UINib nibWithNibName:@"SYJParameterTableViewCell" bundle:nil] forCellReuseIdentifier:ParametercellID];
        _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

-(UIButton*)bottomBtn
{
    if (_bottomBtn==nil) {
        _bottomBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 50)];
        [_bottomBtn addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
        [_bottomBtn setTitle:@"预约" forState:UIControlStateNormal];
        _bottomBtn.backgroundColor=[UIColor redColor];
    }
    return _bottomBtn;
}





@end
