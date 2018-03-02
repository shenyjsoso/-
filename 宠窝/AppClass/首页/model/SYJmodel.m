//
//  SYJmodel.m
//  宠窝
//
//  Created by soso on 2018/3/1.
//  Copyright © 2018年 soso. All rights reserved.
//

#import "SYJmodel.h"

@implementation SYJmodel
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(NSMutableArray*)dataArr
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Goods" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray  *shops = [NSMutableArray array];
    for (NSDictionary *dict in array)
    {
        NSMutableArray  *sh = [NSMutableArray array];
        SYJmodel *s = [[SYJmodel alloc] initWithDict:dict];
        for (NSDictionary *dic in s.info) {
            SYJGoodsInfo *info=[[SYJGoodsInfo alloc]initWithDict:dic];
            [sh addObject:info];
        }
        s.info=sh;
        [shops addObject:s];
    }
    return shops;
}
@end
