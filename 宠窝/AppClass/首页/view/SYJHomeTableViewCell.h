//
//  SYJHomeTableViewCell.h
//  宠窝
//
//  Created by soso on 2018/1/24.
//  Copyright © 2018年 soso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYJHomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pictureimage;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *people;

@end
