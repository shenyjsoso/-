//
//  SYJTabBarController.m
//  
//
//  Created by soso on 2017/11/28.
//  Copyright © 2017年 soso. All rights reserved.
//

#import "SYJTabBarController.h"
#import "SYJHomeViewController.h"


#import "SYJMeViewController.h"
#import "SYJNavigationController.h"

@interface SYJTabBarController ()

@end

@implementation SYJTabBarController

+(void)initialize{
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName]=SYJColor(191, 191, 191, 1);
    
    NSMutableDictionary *selectedAttrs=[NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName]=NAVBAR_Color;
    
    //  通过appearance统一设置所有UITabBarItem的文字属性
    //  后面带有UI_APPEARANCE_SELECTOR的方法，都可以通过appearance对象统一设置
    UITabBarItem *item=[UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //if 使tabBarController中管理的viewControllers都符合 UIRectEdgeNone
//    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
//        [self setEdgesForExtendedLayout: UIRectEdgeNone];
//    }
    //去掉tabBar顶部线条
//    CGRect rect = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self.tabBar setBackgroundImage:img];
//    [self.tabBar setShadowImage:img];
    
    
    self.tabBar.translucent=NO;

    
    SYJHomeViewController *home=[[SYJHomeViewController alloc]init];
    [self SetupChildController:home
                         image:@"首页1"
                 Selectedimage:@"首页2"
                         title:@"找窝"];
    
    
    SYJMeViewController *Me=[[SYJMeViewController alloc]init];
    [self SetupChildController:Me
                         image:@"个人1"
                 Selectedimage:@"个人2"
                         title:@"萌宠"];
    
}
-(void)SetupChildController:(UIViewController *)ChildController  image:(NSString *)image Selectedimage:(NSString *)Selectedimage title:(NSString *)title{
    
    ChildController.tabBarItem.title=title;
    ChildController.tabBarItem.image=[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ChildController.tabBarItem.selectedImage=
    [[UIImage imageNamed:Selectedimage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    SYJNavigationController *nav=[[SYJNavigationController alloc]initWithRootViewController:ChildController];
    [self addChildViewController:nav];
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
