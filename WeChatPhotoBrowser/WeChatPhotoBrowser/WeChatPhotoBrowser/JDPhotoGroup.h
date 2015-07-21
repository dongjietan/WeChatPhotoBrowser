//
//  JDPhotoGroup.h
//  WeChatPhotoBrowser
//
//  Created by Jay on 15/7/21.
//  Copyright (c) 2015年 Jay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoBroswerVC.h"

@protocol JDPhotoGroupDelegate <NSObject>

- (void)networkImageShow:(UIView *)view indexPath:(NSIndexPath *)indexPath photos:(NSArray *)photos;

@end


@interface JDPhotoGroup : UIView

@property (nonatomic, strong) NSArray *photoItemArray;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) id<JDPhotoGroupDelegate> delegate;

@end
