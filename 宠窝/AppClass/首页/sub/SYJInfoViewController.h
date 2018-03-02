//
//  SYJInfoViewController.h
//  宠窝
//
//  Created by soso on 2018/1/25.
//  Copyright © 2018年 soso. All rights reserved.
//

#import "SYJBaseViewController.h"

@interface SYJInfoViewController : SYJBaseViewController
@property (nonatomic, assign)long row;
@property (nonatomic, assign)long section;

@property (nonatomic, strong) NSArray *pictures;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *people;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *colour;
@property (nonatomic, copy) NSString *suitable;

@end
