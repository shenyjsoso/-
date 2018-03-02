//
//  SYJMeViewController.m
//  宠窝
//
//  Created by soso on 2018/1/21.
//  Copyright © 2018年 soso. All rights reserved.
//

#import "SYJMeViewController.h"
#import "SYJMoreViewController.h"
@interface SYJMeViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    NSInteger _btnTag;
}
@property(nonatomic,strong)YTKKeyValueStore *store;
@end

@implementation SYJMeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.store=[[YTKKeyValueStore alloc]initDBWithName:@"my.db"];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVBAR_HEIGHT+STATUS_HEIGHT)];
    view.backgroundColor=NAVBAR_Color;
    [self.view addSubview:view];

    
    self.navigationItem.title=@"我的萌宠";
    self.exitBtn.layer.borderColor=NAVBAR_Color.CGColor;
    self.exitBtn.layer.borderWidth = 1.0f;
    self.exitBtn.layer.cornerRadius=5.0f;
    self.exitBtn.clipsToBounds=YES;
    NSString *myid= [[NSUserDefaults standardUserDefaults]objectForKey:@"ID"];
   NSMutableDictionary *dic=[self.store getObjectById:myid fromTable:usertable];
    if (dic[@"name"]) {
        self.nameLbl.text=[NSString stringWithFormat:@"名字:%@",dic[@"name"]];
    }
    if (dic[@"sex"]) {
        self.sexLbl.text=[NSString stringWithFormat:@"性别:%@",dic[@"sex"]];
    }
    if (dic[@"age"]) {
        self.ageLbl.text=[NSString stringWithFormat:@"年龄:%@",dic[@"age"]];
    }
    if (dic[@"height"]) {
        self.heightLbl.text=[NSString stringWithFormat:@"体重:%@",dic[@"height"]];
    }
    if (dic[@"breed"]) {
        self.breedLbl.text=[NSString stringWithFormat:@"品种:%@",dic[@"breed"]];
    }
    if (dic[@"image100"]) {
        NSData *data=[[NSData alloc]initWithBase64EncodedString:dic[@"image100"] options:0];
        [self.photoBtn setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
    }
    if (dic[@"image101"]) {
        NSData *data=[[NSData alloc]initWithBase64EncodedString:dic[@"image101"] options:0];
        [self.firstBtn setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
    }
    if (dic[@"image102"]) {
        NSData *data=[[NSData alloc]initWithBase64EncodedString:dic[@"image102"] options:0];
        [self.secondBtn setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
    }
    if (dic[@"image103"]) {
        NSData *data=[[NSData alloc]initWithBase64EncodedString:dic[@"image103"] options:0];
        [self.thirdBtn setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
    }
    if (dic[@"image104"]) {
        NSData *data=[[NSData alloc]initWithBase64EncodedString:dic[@"image104"] options:0];
        [self.fourBtn setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
    }
    self.nameLbl.userInteractionEnabled=YES;
    self.sexLbl.userInteractionEnabled=YES;
    self.ageLbl.userInteractionEnabled=YES;
    self.heightLbl.userInteractionEnabled=YES;
    self.breedLbl.userInteractionEnabled=YES;
    
    for (int i=0; i<5; i++) {
        UITapGestureRecognizer *tapRecognizerWeibo=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(write:)];
        switch (i) {
            case 0:
                [self.nameLbl addGestureRecognizer:tapRecognizerWeibo];
                break;
            case 1:
                [self.sexLbl addGestureRecognizer:tapRecognizerWeibo];
                break;
            case 2:
                [self.heightLbl addGestureRecognizer:tapRecognizerWeibo];
                break;
            case 3:
                [self.ageLbl addGestureRecognizer:tapRecognizerWeibo];
                break;
            case 4:
                [self.breedLbl addGestureRecognizer:tapRecognizerWeibo];
                break;
            default:
                break;
        }
    }
    
}

-(void)write:(UITapGestureRecognizer*)tap
{
    NSString *str=nil;
    NSInteger altertag=0;
    switch (tap.view.tag) {
        case 10:
            str=@"名字";
            altertag=10;
            break;
        case 11:
            str=@"性别";
            altertag=11;
            break;
        case 12:
            str=@"体重";
            altertag=12;
            break;
        case 13:
            str=@"年龄";
            altertag=13;
            break;
        case 14:
            str=@"品种";
            altertag=14;
            break;
        default:
            break;
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请填写爱宠的" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=altertag;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.delegate=self;
    [alert show];
}
-(void)viewtap:(UITapGestureRecognizer*)tap
{
    [tap.view removeFromSuperview];
}
- (IBAction)exitBtn:(UIButton *)sender {
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertController *altercon=[UIAlertController alertControllerWithTitle:nil message:@"确定退出吗?" preferredStyle:UIAlertControllerStyleAlert];
    [altercon addAction:cancel];
    [altercon addAction:action];
    
    [self presentViewController:altercon animated:YES completion:nil];

}

- (IBAction)moreOrderfrom:(UIButton *)sender {//更多订单
    SYJMoreViewController *more=[[SYJMoreViewController alloc]init];
    [self.navigationController pushViewController:more animated:YES];
}


- (IBAction)photoBTN:(UIButton *)sender {
    _btnTag=sender.tag;
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    //调用系统相册的类
    pickerController = [[UIImagePickerController alloc]init];
    pickerController.delegate = self;
    //设置选取的照片是否可编辑
    pickerController.allowsEditing = YES;
    UIAlertController *alterController=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *bigphoto = [UIAlertAction actionWithTitle:@"查看大图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIView *mainview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        mainview.backgroundColor=SYJColor(20, 20, 20, 0.9);
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewtap:)];
        mainview.userInteractionEnabled=YES;
        [mainview addGestureRecognizer:tap];
        UIImageView *imageview=[[UIImageView alloc]initWithImage:sender.imageView.image highlightedImage:sender.imageView.image];
        [mainview addSubview:imageview];
        imageview.frame=CGRectMake(0, 0, ScreenWidth, ScreenWidth);
        imageview.center=mainview.center;
//        CATransition *anim = [[CATransition alloc] init];
//        anim.duration = 0.5;
//        [[[UIApplication sharedApplication] keyWindow].layer addAnimation:anim forKey:nil];
        [[UIApplication sharedApplication].keyWindow addSubview:mainview];
        
    }];
    UIAlertAction *PhotoLibraryAction=[UIAlertAction actionWithTitle:@"从相册选择照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //设置相册呈现的样式
        pickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pickerController animated:YES completion:nil];
    }];
    UIAlertAction *CameraLibraryAction=[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //设置相册呈现的样式
        pickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
        [pickerController.navigationController setNavigationBarHidden:YES];
        [self presentViewController:pickerController animated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alterController addAction:bigphoto];
    [alterController addAction:PhotoLibraryAction];
    [alterController addAction:CameraLibraryAction];
    [alterController addAction:cancelAction];
    //alterController.view.tintColor=NAVBAR_Color;
    [self presentViewController:alterController animated:YES completion:nil];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSMutableDictionary *dic=[self.store getObjectById:[[NSUserDefaults standardUserDefaults]objectForKey:@"ID"] fromTable:usertable];
    NSLog(@"原来的字典%@,%@",dic,dic.class);
    NSMutableDictionary *user=[dic mutableCopy];
    if (buttonIndex==1) {
        UITextField *txtfield = [alertView textFieldAtIndex:0];
        switch (alertView.tag) {
            case 10:
                
                [user setObject:txtfield.text forKey:@"name"];
                self.nameLbl.text=[NSString stringWithFormat:@"名字:%@",txtfield.text];
                break;
            case 11:
                [user setObject:txtfield.text forKey:@"sex"];
                self.sexLbl.text=[NSString stringWithFormat:@"性别:%@",txtfield.text];
                break;
            case 12:
                [user setObject:txtfield.text forKey:@"height"];
                self.heightLbl.text=[NSString stringWithFormat:@"体重:%@",txtfield.text];
                break;
            case 13:
                [user setObject:txtfield.text forKey:@"age"];
                self.ageLbl.text=[NSString stringWithFormat:@"年龄:%@",txtfield.text];
                break;
            case 14:
                [user setObject:txtfield.text forKey:@"breed"];
                self.breedLbl.text=[NSString stringWithFormat:@"品种:%@",txtfield.text];
                break;
                
            default:
                break;
        }
        [self.store putObject:user withId:[[NSUserDefaults standardUserDefaults]objectForKey:@"ID"] intoTable:usertable];
    }
    
}

#pragma mark ************imagePickerController代理*************
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //info是所选择照片的信息
    //    UIImagePickerControllerEditedImage//编辑过的图片
    //    UIImagePickerControllerOriginalImage//原图
    //NSLog(@"info::::%@",info);
    //刚才已经看了info中的键值对，可以从info中取出一个UIImage对象，将取出的对象赋给按钮的image
    
    UIButton *button = (UIButton *)[self.view viewWithTag:_btnTag];
    
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [button setImage:[resultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];//如果按钮创建时用的是系统风格UIButtonTypeSystem，需要在设置图片一栏设置渲染模式为"使用原图"
    //[button setBackgroundImage:[resultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    NSMutableDictionary *dic=[self.store getObjectById:[[NSUserDefaults standardUserDefaults]objectForKey:@"ID"] fromTable:usertable];
    NSMutableDictionary *user=[dic mutableCopy];
    
    NSData *imagedata=UIImageJPEGRepresentation(resultImage, 0.9f);
    NSString *imagestr=[imagedata base64EncodedStringWithOptions:0];
    [user setObject:imagestr forKey:[NSString stringWithFormat:@"image%ld",_btnTag]];
    [self.store putObject:user withId:[[NSUserDefaults standardUserDefaults]objectForKey:@"ID"] intoTable:usertable];
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
