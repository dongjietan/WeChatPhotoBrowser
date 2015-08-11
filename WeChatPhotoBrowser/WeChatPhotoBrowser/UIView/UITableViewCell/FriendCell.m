//
//  FriendCell.m
//  WeChatPhotoBrowser
//
//  Created by Jay on 15/8/2.
//  Copyright (c) 2015年 Jay. All rights reserved.
//

#import "FriendCell.h"
#import "UIImageView+WebCache.h"

#define SDPhotoGroupImageMarginRight 27

#define SDPhotoGroupEachLineImageCount 3
#define SDPhotoGroupImageSpace 4

@interface FriendCell (){
    NSArray *photos;
    NSArray *contentViews;
}

@end

@implementation FriendCell

- (void)awakeFromNib {
    // Initialization code
    self.heightConstraint.constant = 0.5f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setPhotoItemArray:(NSArray *)photoItemArray
{
    [contentViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _photoItemArray = photoItemArray;
    NSMutableArray *mArrayImageView = [NSMutableArray array];
    NSMutableArray *mArrayContentView = [NSMutableArray array];
    for (NSInteger i = 0; i < photoItemArray.count; ++i) {
        NSString *urlString = [photoItemArray objectAtIndex:i];
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor clearColor];
        contentView.layer.masksToBounds = YES;
        UIImageView *imgV = [[UIImageView alloc] init];
        [imgV sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"default"]];
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        imgV.tag = i;
        imgV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
        [imgV addGestureRecognizer:tapGesture];
        [contentView addSubview:imgV];
        [self addSubview:contentView];
        [mArrayImageView addObject:imgV];
        [mArrayContentView addObject:contentView];
    }
    photos = [NSArray arrayWithArray:mArrayImageView];
    contentViews = [NSArray arrayWithArray:mArrayContentView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat originY = self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 11;
    
    NSUInteger imageCount = self.photoItemArray.count;
    if (imageCount > 0) {
        CGFloat width = [self imageWidth];
        CGFloat height = width;
        
        [contentViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            long rowIndex = idx / SDPhotoGroupEachLineImageCount;
            int columnIndex = idx % SDPhotoGroupEachLineImageCount;
            CGFloat x = self.nameLabel.frame.origin.x + columnIndex * (width + SDPhotoGroupImageSpace);
            CGFloat y = originY + rowIndex * (height + SDPhotoGroupImageSpace);
            view.frame = CGRectMake(x, y, width, height);
            
            UIImageView *imgV = [view.subviews firstObject];
            imgV.frame = CGRectMake(0, 0, width, height);
        }];
    }
}

- (CGFloat)imageWidth{
    CGFloat width = (self.frame.size.width - self.nameLabel.frame.origin.x - SDPhotoGroupImageMarginRight - SDPhotoGroupImageSpace * 2) / SDPhotoGroupEachLineImageCount;
    return width;
}

- (CGFloat)height{
    NSUInteger imageCount = self.photoItemArray.count;
    int totalRowCount = ((CGFloat)imageCount - 1) / SDPhotoGroupEachLineImageCount + 1;
    CGFloat width = [self imageWidth];
    CGFloat height = 100 + totalRowCount * width + (totalRowCount - 1) * SDPhotoGroupImageSpace;
    return height;
}

- (void)imageClick:(UITapGestureRecognizer *)sender
{
    UIView *imageView = sender.view;
    UITableView *parentTableView = [self parentTableView];
    id delegate = parentTableView.delegate;
    if (delegate && [delegate respondsToSelector:@selector(networkImageShow:indexPath:photos:)]) {
        [(id<FriendCellDelegate>)delegate networkImageShow:imageView indexPath:[parentTableView indexPathForCell:self] photos:photos];
    }
}

- (UITableView *)parentTableView {
    // iterate up the view hierarchy to find the table containing this cell/view
    UIView *aView = self.superview;
    while(aView != nil) {
        if([aView isKindOfClass:[UITableView class]]) {
            return (UITableView *)aView;
        }
        aView = aView.superview;
    }
    return nil; // this view is not within a tableView
}

@end
