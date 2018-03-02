//
//  SYJOrderTableViewCell.h
//  宠窝
//
//  Created by soso on 2018/2/27.
//  Copyright © 2018年 soso. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^orderBolck)(void);
@interface SYJOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *myideaLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property(nonatomic,copy)orderBolck block;
@end
