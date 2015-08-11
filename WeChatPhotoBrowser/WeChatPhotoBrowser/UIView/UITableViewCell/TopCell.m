//
//  TopCell.m
//  WeChatPhotoBrowser
//
//  Created by Jay on 15/8/2.
//  Copyright (c) 2015年 Jay. All rights reserved.
//

#import "TopCell.h"

@implementation TopCell

- (void)awakeFromNib {
    // Initialization code
    self.avatarView.layer.borderWidth = 0.5;
    self.avatarView.layer.borderColor = [UIColor grayColor].CGColor;
    self.avatarImageView.layer.borderWidth = 1.5;
    self.avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
