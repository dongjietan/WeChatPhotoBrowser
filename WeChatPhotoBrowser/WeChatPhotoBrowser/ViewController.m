//
//  ViewController.m
//  WeChatPhotoBrowser
//
//  Created by Jay on 15/7/21.
//  Copyright (c) 2015年 Jay. All rights reserved.
//

#import "ViewController.h"
#import "JDPhotoGroup.h"

@interface ViewController ()<JDPhotoGroupDelegate>{
    NSArray *datas;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self generateDatas];
}

- (void)generateDatas{
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; ++i) {
        NSInteger amount = arc4random() % 9 + 1;
        [mArray addObject:[self generateDatasWithAmount:amount]];
    }
    datas = [NSArray arrayWithArray:mArray];
}

//模拟数据
- (NSArray *)generateDatasWithAmount:(NSInteger)amount{
    NSArray *networkImages =
                    @[@"http://www.netbian.com/d/file/20150519/f2897426d8747f2704f3d1e4c2e33fc2.jpg",
                      @"http://www.netbian.com/d/file/20130502/701d50ab1c8ca5b5a7515b0098b7c3f3.jpg",
                      @"http://www.netbian.com/d/file/20110418/48d30d13ae088fd80fde8b4f6f4e73f9.jpg",
                      @"http://www.netbian.com/d/file/20150318/869f76bbd095942d8ca03ad4ad45fc80.jpg",
                      @"http://www.netbian.com/d/file/20110424/b69ac12af595efc2473a93bc26c276b2.jpg",
                      @"http://www.netbian.com/d/file/20140522/3e939daa0343d438195b710902590ea0.jpg",
                      @"http://www.netbian.com/d/file/20141018/7ccbfeb9f47a729ffd6ac45115a647a3.jpg",
                      @"http://www.netbian.com/d/file/20140724/fefe4f48b5563da35ff3e5b6aa091af4.jpg",
                      @"http://www.netbian.com/d/file/20140529/95e170155a843061397b4bbcb1cefc50.jpg"];
    
    NSInteger index = arc4random() % networkImages.count;
    NSArray *mArray = [networkImages subarrayWithRange:NSMakeRange(index, networkImages.count - index)];
    return mArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *images = [datas objectAtIndex:indexPath.row];
    return images.count / 4 * 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *images = [datas objectAtIndex:indexPath.row];
    
    JDPhotoGroup *photoGroup = [[JDPhotoGroup alloc] init];
    photoGroup.indexPath = indexPath;
    photoGroup.delegate = self;
    photoGroup.photoItemArray = images;
    [cell addSubview:photoGroup];
    
    return cell;
}

#pragma mark - JDPhotoGroupDelegate
- (void)networkImageShow:(UIView *)view indexPath:(NSIndexPath *)indexPath photos:(NSArray *)photos{
    NSArray *images = [datas objectAtIndex:indexPath.row];
    
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypeZoom index:view.tag photoModelBlock:^NSArray *{
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:images.count];
        for (NSUInteger i = 0; i < images.count; i++) {
            PhotoModel *pbModel = [[PhotoModel alloc] init];
            pbModel.mid = images[i];
            pbModel.image_HD_U = images[i];
            
            //源frame
            UIImageView *imgV = [photos objectAtIndex:i];
            NSAssert(imgV, @"imgV should not be nil");
            pbModel.sourceImageView = imgV;
            [modelsM addObject:pbModel];
        }
        return modelsM;
    }];
}
@end
