//
//  SYJLogInViewController.m
//  宠窝
//
//  Created by soso on 2018/1/21.
//  Copyright © 2018年 soso. All rights reserved.
//

#import "SYJLogInViewController.h"
#import "SYJTabBarController.h"
@interface SYJLogInViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)YTKKeyValueStore *store;
@end

@implementation SYJLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =SYJColor(225, 239, 252, 1);
    //页面手势
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    self.store=[[YTKKeyValueStore alloc]initDBWithName:@"my.db"];
    [self.store createTableWithName:usertable];
    [self.store createTableWithName:goodstable];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (IBAction)jumpTORoot:(UIButton *)sender {
    if (!(self.photoTxt.text.length>0&&self.passwordTxt.text>0)) {
        [SYJProgressHUD showMessage:@"请输入正确的账号和密码" inView:self.view afterDelayTime:1];
        return;
    }

    NSMutableDictionary *dic=[self.store getObjectById:self.photoTxt.text fromTable:usertable];
    if (!dic) {
        [SYJProgressHUD showMessage:@"用户不存在" inView:self.view afterDelayTime:1];
        return;
    }
    NSString *str=dic[@"password"];
    if (str==self.passwordTxt.text) {
        [[NSUserDefaults standardUserDefaults]setObject:self.photoTxt.text forKey:@"ID"];
        SYJTabBarController *tab=[[SYJTabBarController alloc]init];
        CATransition *anim = [[CATransition alloc] init];
        anim.type = @"rippleEffect";
        anim.duration = 1.0;
        [self.view.window.layer addAnimation:anim forKey:nil];
        [self presentViewController:tab animated:YES completion:nil];
    }
    else{
        [SYJProgressHUD showMessage:@"账号或密码错误" inView:self.view afterDelayTime:1];
    }

}
- (IBAction)forgetBtn:(UIButton *)sender {
    if (!(self.photoTxt.text.length>0&&self.passwordTxt.text>0)) {
        [SYJProgressHUD showMessage:@"请输入正确的账号和密码" inView:self.view afterDelayTime:1];
        return;
    }
    NSMutableDictionary *dic=[self.store getObjectById:self.photoTxt.text fromTable:usertable];
    if (!dic) {
        [SYJProgressHUD showMessage:@"用户不存在" inView:self.view afterDelayTime:1];
    }
    else{
        NSMutableDictionary *user=[dic mutableCopy];
        [user setValue:self.passwordTxt.text forKey:@"password"];
        [self.store putObject:user withId:self.photoTxt.text intoTable:usertable];
        [SYJProgressHUD showMessage:@"修改成功" inView:self.view afterDelayTime:1];
    }
    
}
- (IBAction)registerBtn:(UIButton *)sender {
    NSMutableDictionary *dic=[self.store getObjectById:self.photoTxt.text fromTable:usertable];
    if (dic) {
        [SYJProgressHUD showMessage:@"用户已存在" inView:self.view afterDelayTime:1];
        return;
    }
    if (self.photoTxt.text.length>0&&self.passwordTxt.text.length>0) {
        
        NSMutableDictionary*user=[NSMutableDictionary dictionary];
        [user setValue:self.passwordTxt.text forKey:@"password"];
        [self.store putObject:user withId:self.photoTxt.text intoTable:usertable];
        [SYJProgressHUD showMessage:@"注册成功" inView:self.view afterDelayTime:1];
    }
    else{
        [SYJProgressHUD showMessage:@"请输入正确的账号和密码" inView:self.view afterDelayTime:1];
    }

}

#pragma textField代理
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGFloat offset = self.view.frame.size.height - (textField.frame.origin.y+textField.frame.size.height+216+50);
    NSLog(@"偏移高度为 --- %f",offset);
    if (offset<=0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = offset;
            self.view.frame = frame;
        }];
    }
    return YES;
}
    
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
    }];
    [textField resignFirstResponder];
    return YES;
}
    
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
    }];
    [self.view endEditing:YES];
}



@end
