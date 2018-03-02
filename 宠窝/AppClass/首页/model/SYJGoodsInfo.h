//
//  SYJGoodsInfo.h
//  宠窝
//
//  Created by soso on 2018/3/1.
//  Copyright © 2018年 soso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYJGoodsInfo : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *pictures;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *people;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *colour;
@property (nonatomic, copy) NSString *suitable;
//+(NSArray*)dataArr;
- (id)initWithDict:(NSDictionary *)dict;
@end
