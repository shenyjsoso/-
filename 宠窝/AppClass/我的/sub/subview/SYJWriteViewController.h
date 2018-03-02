//
//  SYJWriteViewController.h
//  宠窝
//
//  Created by soso on 2018/2/27.
//  Copyright © 2018年 soso. All rights reserved.
//

#import "SYJBaseViewController.h"
typedef void(^SYJWriteViewControllerBlock)(void);
@interface SYJWriteViewController : SYJBaseViewController
@property(nonatomic,copy)SYJWriteViewControllerBlock block;
@property (nonatomic, strong) UITextView *textView;
@property(nonatomic,copy)NSString *row;
@end
