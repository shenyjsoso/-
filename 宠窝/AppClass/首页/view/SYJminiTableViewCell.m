//
//  SYJminiTableViewCell.m
//  宠窝
//
//  Created by soso on 2018/1/24.
//  Copyright © 2018年 soso. All rights reserved.
//

#import "SYJminiTableViewCell.h"

@implementation SYJminiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.contentView.backgroundColor = selected ? SYJColor(255, 230, 204, 1) : [UIColor clearColor];
    //    self.highlighted = selected;
    self.titleLabel.textColor =  selected ? SYJColor(255, 127, 0, 1) : SYJColor(120, 120, 120, 1);
}

@end
