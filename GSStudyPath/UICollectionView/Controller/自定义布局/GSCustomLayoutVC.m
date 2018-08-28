//
//  GSCustomLayoutVC.m
//  UICollectionViewLayout
//
//  Created by 管章鹏 on 2018/7/4.
//  Copyright © 2018年 管章鹏. All rights reserved.
// 自定义布局

#import "GSCustomLayoutVC.h"
#import "GSCircleLayout.h"
#import "GSLineLayout.h"
#import "GSStackLayout.h"
#import "GSImageCell.h"

@interface GSCustomLayoutVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation GSCustomLayoutVC

static NSString *const ID = @"GSImageCell";


- (NSMutableArray *)images
{
    if (!_images) {
        self.images = [[NSMutableArray alloc] init];
        
        for (int i = 1; i<=20; i++) {
            [self.images addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"自定义布局";
    
    CGFloat w = self.view.frame.size.width;
    CGRect rect = CGRectMake(0, 100, w, 200);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:[[GSStackLayout alloc] init]];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GSImageCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[GSStackLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[GSCircleLayout alloc] init] animated:YES];
    } else  if ([self.collectionView.collectionViewLayout isKindOfClass:[GSCircleLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[GSLineLayout alloc] init] animated:YES];
    }else{
        [self.collectionView setCollectionViewLayout:[[GSStackLayout alloc] init] animated:YES];
    }
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GSImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.image = self.images[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除模型数据
    [self.images removeObjectAtIndex:indexPath.item];
    
    // 删UI(刷新UI)
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}
@end
