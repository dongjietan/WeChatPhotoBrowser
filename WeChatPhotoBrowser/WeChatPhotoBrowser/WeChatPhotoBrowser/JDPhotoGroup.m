//
//  JDPhotoGroup.m
//  WeChatPhotoBrowser
//
//  Created by Jay on 15/7/21.
//  Copyright (c) 2015年 Jay. All rights reserved.
//

#import "JDPhotoGroup.h"
#import "UIImageView+WebCache.h"

#define SDPhotoGroupImageMargin 15
#define SDPhotoGroupEachLineImageCount 4
#define SDPhotoGroupImageSpace 10

@interface JDPhotoGroup ()
{
    NSArray *photos;
}
@end

@implementation JDPhotoGroup


- (void)setPhotoItemArray:(NSArray *)photoItemArray
{
    _photoItemArray = photoItemArray;
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSInteger i = 0; i < photoItemArray.count; ++i) {
        NSString *urlString = [photoItemArray objectAtIndex:i];
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor clearColor];
        contentView.layer.masksToBounds = YES;
        UIImageView *imgV = [[UIImageView alloc] init];
        [imgV sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"sh_banner_default"]];
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        imgV.tag = i;
        imgV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonClick:)];
        [imgV addGestureRecognizer:tapGesture];
        [contentView addSubview:imgV];
        [self addSubview:contentView];
        [mArray addObject:imgV];
    }
    photos = [NSArray arrayWithArray:mArray];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger imageCount = self.photoItemArray.count;
    if (imageCount > 0) {
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        CGFloat width = (screenBounds.size.width - SDPhotoGroupImageMargin * 2 - SDPhotoGroupImageSpace * 3) / SDPhotoGroupEachLineImageCount;
        CGFloat height = width;
        
        [self.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            long rowIndex = idx / imageCount;
            int columnIndex = idx % imageCount;
            CGFloat x = columnIndex * (width + SDPhotoGroupImageSpace);
            CGFloat y = rowIndex * (height + SDPhotoGroupImageSpace);
            view.frame = CGRectMake(x, y, width, height);
            
            UIImageView *imgV = [view.subviews firstObject];
            imgV.frame = CGRectMake(0, 0, width, height);
        }];
        
        int totalRowCount = ((CGFloat)imageCount - 1) / SDPhotoGroupEachLineImageCount + 1;
        self.frame = CGRectMake(SDPhotoGroupImageMargin, SDPhotoGroupImageMargin, screenBounds.size.width - 2 * SDPhotoGroupImageMargin, totalRowCount * height + (totalRowCount - 1) * SDPhotoGroupImageSpace);
    }
}

- (void)buttonClick:(UITapGestureRecognizer *)sender
{
    UIView *imageView = sender.view;
    if (self.delegate && [self.delegate respondsToSelector:@selector(networkImageShow:indexPath:photos:)]) {
        [self.delegate networkImageShow:imageView indexPath:self.indexPath photos:photos];
    }
}

@end
