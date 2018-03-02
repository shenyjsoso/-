//
//  SYJmodel.h
//  宠窝
//
//  Created by soso on 2018/3/1.
//  Copyright © 2018年 soso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYJGoodsInfo.h"
@interface SYJmodel : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSMutableArray *info;
+(NSMutableArray*)dataArr;
@end
