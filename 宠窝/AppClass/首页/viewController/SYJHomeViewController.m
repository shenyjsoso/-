//
//  SYJHomeViewController.m
//  宠窝
//
//  Created by soso on 2018/1/21.
//  Copyright © 2018年 soso. All rights reserved.
//

#import "SYJHomeViewController.h"
#import "SYJHomeTableViewCell.h"
#import "SYJminiTableViewCell.h"
#import "SYJInfoViewController.h"
#import "SYJGoodsInfo.h"
#import "SYJmodel.h"
static NSString * firstcell = @"SYJHomeTableViewCell";
static NSString * minicell = @"SYJminiTableViewCell";
@interface SYJHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) UITableView  *miniTableView;
@property (nonatomic, strong) NSMutableArray *dataArray; // 数据
@property (nonatomic, strong) NSMutableArray *minidataArray; // 数据
@property (nonatomic, strong) NSIndexPath *lastPath;  // 单选
@property (nonatomic, assign) BOOL isRepeatRolling;  // 是否重复滚动

@property(nonatomic,strong)NSMutableArray *infoAry;
@end

@implementation SYJHomeViewController
#pragma mark - 懒加载
-(NSMutableArray*)infoAry
{
    if (!_infoAry) {
        _infoAry=[SYJmodel dataArr];
    }
    return _infoAry;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)minidataArray {
    if (!_minidataArray) {
        _minidataArray = [NSMutableArray arrayWithObjects:@"狗窝",@"猫窝",@"其他", nil];
    }
    return _minidataArray;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"找窝";
    self.isRepeatRolling = NO; // 默认NO
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.miniTableView];
//    self.miniTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVBAR_HEIGHT+STATUS_HEIGHT)];
    view.backgroundColor=NAVBAR_Color;
    [self.view addSubview:view];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVBAR_HEIGHT)];
    lab.text=@"找窝";
    lab.font=[UIFont systemFontOfSize:18];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.textColor=[UIColor whiteColor];
    [view addSubview:lab];
    CGPoint cen=view.center;
    cen.y+=STATUS_HEIGHT/2;
    lab.center=cen;

}

#pragma mark ***********tableview代理**********
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.miniTableView == tableView) {
        return 1;
    } else {
        return self.infoAry.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.miniTableView==tableView) {
        return self.infoAry.count;
    }
    else
    {
        SYJmodel *model=self.infoAry[section];
        
        return model.info.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.miniTableView) {
        return 50;
    } else {
        return 110;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.miniTableView) {
        return 0;
    } else {
        return 30;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
        return CGFLOAT_MIN;
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (tableView==self.tableView) {
//        return self.minidataArray[section];
//    }
//    else return nil;
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == _miniTableView) {
        return nil;
    } else {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/4*3, 30)];
        headView.backgroundColor = SYJColor(254.f, 230.f, 206.f, 1);
        
        UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth/4*3-15, 30)];
      //  headLabel.frame=headView.frame;
        [headView addSubview:headLabel];
        
        headLabel.textColor = SYJColor(255, 127, 0, 1);
        headLabel.font = [UIFont systemFontOfSize:16];
        headLabel.textAlignment=NSTextAlignmentLeft;
        headLabel.text = self.minidataArray[section];
        return headView;
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.miniTableView==tableView) {
        SYJminiTableViewCell *leftCell=[tableView dequeueReusableCellWithIdentifier:minicell forIndexPath:indexPath];
        leftCell.selectionStyle =UITableViewCellSelectionStyleNone;
        leftCell.titleLabel.text=self.minidataArray[indexPath.row];
        NSInteger row = [indexPath row];
        NSInteger oldRow = [_lastPath row];
        if (row == oldRow && _lastPath!=nil) {
            // 被选中状态
            leftCell.contentView.backgroundColor =SYJColor(255, 230, 204, 1);
            leftCell.titleLabel.textColor = SYJColor(255, 127, 0, 1);
        }else{
            leftCell.contentView.backgroundColor = [UIColor clearColor];
            leftCell.titleLabel.textColor = SYJColor(120, 120, 120, 1);
        }
        return leftCell;
    }
    else
    {
    SYJHomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:firstcell forIndexPath:indexPath];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
        SYJmodel *model=self.infoAry[indexPath.section];
        SYJGoodsInfo *info=model.info[indexPath.row];
        
        cell.nameLbl.text=info.name;
        cell.priceLbl.text=[NSString stringWithFormat:@"¥%@/天",info.price];
        cell.people.text=[NSString stringWithFormat:@"%@人付款",info.people];
        cell.pictureimage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",info.pictures[0]]];
      //  [cell.pictureimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld-%ld-0",indexPath.section,indexPath.row]]];
        
    return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_miniTableView == tableView) {
        NSInteger newRow = [indexPath row];
        NSInteger oldRow = (self .lastPath !=nil)?[self .lastPath row]:-1;
        if (newRow != oldRow) {
            SYJminiTableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
            newCell.contentView.backgroundColor = SYJColor(255, 230, 204, 1);
            newCell.titleLabel.textColor = SYJColor(255, 127, 0, 1);
            SYJminiTableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.lastPath];
            oldCell.contentView.backgroundColor = [UIColor clearColor];
            oldCell.titleLabel.textColor = SYJColor(120, 120, 120, 1);
        }
        self.lastPath = indexPath;
        self.isRepeatRolling = YES;
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    else 
    {
        SYJmodel *model=self.infoAry[indexPath.section];
        SYJGoodsInfo *info=model.info[indexPath.row];
        
        SYJInfoViewController *infovc=[[SYJInfoViewController alloc]init];
        infovc.name=info.name;
        infovc.people=info.people;
        infovc.price=info.price;
        infovc.pictures=info.pictures;
        infovc.size=info.size;
        infovc.colour=info.colour;
        infovc.suitable=info.suitable;
        infovc.row=indexPath.row;
        infovc.section=indexPath.section;
        
        [self.navigationController pushViewController:infovc animated:YES];
    }
}

#pragma mark *************访问器************
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth/4, NAVBAR_HEIGHT+STATUS_HEIGHT, ScreenWidth/4*3, ScreenHeight-TABBAR_HEIGHT-NAVBAR_HEIGHT-STATUS_HEIGHT) style:UITableViewStyleGrouped];
        //cell与cell之间的线
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.separatorColor=SYJColor(223, 223, 223, 1);
        //_tableView.backgroundColor=SYJColor(248, 248, 248, 1);
//        UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 24)];
//        _tableView.tableFooterView=footerView;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        [_tableView registerNib:[UINib nibWithNibName:@"SYJHomeTableViewCell" bundle:nil] forCellReuseIdentifier:firstcell];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}
-(UITableView*)miniTableView
{
    if (_miniTableView==nil) {
        _miniTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT+STATUS_HEIGHT, ScreenWidth/4, ScreenHeight-TABBAR_HEIGHT-NAVBAR_HEIGHT-STATUS_HEIGHT) style:UITableViewStylePlain];
        _miniTableView.delegate=self;
        _miniTableView.dataSource=self;
        _miniTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//        _miniTableView.estimatedRowHeight = 0;
//        _miniTableView.estimatedSectionFooterHeight = 0;
//        _miniTableView.estimatedSectionHeaderHeight = 0;
        _miniTableView.showsVerticalScrollIndicator = NO; // 隐藏滚动条
        [_miniTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [_miniTableView registerNib:[UINib nibWithNibName:@"SYJminiTableViewCell" bundle:nil] forCellReuseIdentifier:minicell];
        _miniTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _miniTableView;
}
#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 滑动视图上移动画
   // [self viewUpAnimationWihtScrollView:scrollView];
    if (scrollView == self.tableView) {
        //取出当前显示的最顶部的cell的indexpath
        //当前tableview页面可见的分区属性 indexPathsForVisibleRows
        // 取出显示在 视图 且最靠上 的 cell 的 indexPath
        // 判断tableView是否滑动到最底部
        CGFloat height = scrollView.frame.size.height;
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
        if (bottomOffset <= height) {
            NSIndexPath *bottomIndexPath = [[self.tableView indexPathsForVisibleRows] lastObject];
            NSIndexPath *moveIndexPath = [NSIndexPath indexPathForRow:bottomIndexPath.section inSection:0];
            if (self.isRepeatRolling == NO) { // 防止重复滚动
                [self.miniTableView selectRowAtIndexPath:moveIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
            }
        } else {
            NSIndexPath *topIndexPath = [[self.tableView indexPathsForVisibleRows]firstObject];
            NSIndexPath *moveIndexPath = [NSIndexPath indexPathForRow:topIndexPath.section inSection:0];
            if (self.isRepeatRolling == NO) { // 防止重复滚动
                [self.miniTableView selectRowAtIndexPath:moveIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
            }
        }
    }
            else{
        return;
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isRepeatRolling = NO;
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
