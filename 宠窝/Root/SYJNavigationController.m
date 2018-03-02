//
//  SYJNavigationController.m
//  
//
//  Created by soso on 2017/11/28.
//  Copyright © 2017年 soso. All rights reserved.
//

#import "SYJNavigationController.h"
#import "UIImage+SYJImage.h"
@interface SYJNavigationController ()

@end

@implementation SYJNavigationController
#pragma mark - load初始化一次
+ (void)load
{
    [self setUpBase];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
+ (void)setUpBase
{
    UINavigationBar *bar = [UINavigationBar appearance];
//    bar.barTintColor = [UIColor redColor];
    [bar setTintColor:[UIColor whiteColor]];
//    bar.translucent = YES;
    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[UIImage new]];
    // 设置导航栏的字体颜色
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:18];;
    bar.titleTextAttributes = attributes;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        // 就有滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
        //返回按钮自定义
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -15;
        
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(0, 0, 33, 33);
        
        if (@available(ios 11.0,*)) {
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -15,0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -10,0, 0);
        }
        
        [button addTarget:self action:@selector(backButtonTapClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 点击
- (void)backButtonTapClick {
    
    [self popViewControllerAnimated:YES];
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
