//
//  SYJOrderTableViewCell.m
//  宠窝
//
//  Created by soso on 2018/2/27.
//  Copyright © 2018年 soso. All rights reserved.
//

#import "SYJOrderTableViewCell.h"

@implementation SYJOrderTableViewCell
- (IBAction)orderVC:(UIButton *)sender {
    if (self.block) {
        self.block();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
