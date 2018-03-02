//
//  SYJbespeakViewController.h
//  宠窝
//
//  Created by soso on 2018/3/1.
//  Copyright © 2018年 soso. All rights reserved.
//

#import "SYJBaseViewController.h"

@interface SYJbespeakViewController : SYJBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *datetxtfield;
@property (weak, nonatomic) IBOutlet UITextField *numberDay;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@property (nonatomic, copy) NSString *price;
@property (nonatomic, assign)long row;
@property (nonatomic, assign)long section;

@end
