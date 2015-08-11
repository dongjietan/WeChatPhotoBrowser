//
//  FriendCell.h
//  WeChatPhotoBrowser
//
//  Created by Jay on 15/8/2.
//  Copyright (c) 2015年 Jay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriendCellDelegate <NSObject>
- (void)networkImageShow:(UIView *)view indexPath:(NSIndexPath *)indexPath photos:(NSArray *)photos;
@end

@interface FriendCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, strong) NSArray *photoItemArray;

- (CGFloat)height;
@end
