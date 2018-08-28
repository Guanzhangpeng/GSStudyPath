//
//  GSWaterFlowVC.m
//  UICollectionViewLayout
//
//  Created by 管章鹏 on 2018/7/4.
//  Copyright © 2018年 管章鹏. All rights reserved.
//   流水布局

#import "GSWaterFlowVC.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "GSWaterFlowLayout.h"
#import "GSShop.h"
#import "GSShopCell.h"
@interface GSWaterFlowVC ()<GSWaterFlowLayoutDelegate>
@property (nonatomic, strong) NSMutableArray *shops;
@end

@implementation GSWaterFlowVC

- (NSMutableArray *)shops
{
    if (_shops == nil) {
        self.shops = [NSMutableArray array];
    }
    return _shops;
}

static NSString *const ID = @"shop";

-(instancetype)init{
    GSWaterFlowLayout *layout = [[GSWaterFlowLayout alloc] init];
    layout.delegate = self;
    //    layout.sectionInset = UIEdgeInsetsMake(100, 20, 40, 30);
    //    layout.columnMargin = 20;
    //    layout.rowMargin = 30;
    //    layout.columnsCount = 4;
    
    return [self initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
       self.title = @"瀑布流";
    
    // 1.初始化数据
    NSArray *shopArray = [GSShop mj_objectArrayWithFilename:@"1.plist"];
    [self.shops addObjectsFromArray:shopArray];
 
    // 3.增加刷新控件
    [self.collectionView registerNib:[UINib nibWithNibName:@"GSShopCell" bundle:nil] forCellWithReuseIdentifier:ID];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
}

- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shopArray = [GSShop mj_objectArrayWithFilename:@"1.plist"];
        [self.shops addObjectsFromArray:shopArray];
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
    });
}

#pragma mark - <GSWaterFlowLayoutDelegate>
- (CGFloat)waterflowLayout:(GSWaterFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    GSShop *shop = self.shops[indexPath.item];
    return shop.h / shop.w * width;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GSShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    return cell;
}

@end
