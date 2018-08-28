//
//  GSDateVC.m
//  UICollectionViewLayout
//
//  Created by 管章鹏 on 2018/7/5.
//  Copyright © 2018年 管章鹏. All rights reserved.
//  日历

#import "GSDateVC.h"
#import "GSDateCell.h"
#import "GSDateHeaderView.h"
#import "GSDate.h"
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
@interface GSDateVC ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dateArray;

@end

@implementation GSDateVC

static NSString * const cellID = @"GSDateCell";
static NSString * const cellHeaderID = @"GSDateHeaderView";


#pragma mark 数据懒加载
-(NSMutableArray *)dateArray{
    if (!_dateArray) {
        _dateArray = [NSMutableArray array];
    }
    return _dateArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日历";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(ScreenWidth/7, ScreenWidth/7);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing= 0;
    layout.headerReferenceSize = CGSizeMake(ScreenWidth, 60);
    
    CGRect frame = CGRectMake(0, 100, ScreenWidth, 500);
    self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GSDateCell class]) bundle:nil] forCellWithReuseIdentifier:cellID];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GSDateHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellHeaderID];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    [self dateHandler:[NSDate date]];
}
- (void)dateHandler:(NSDate *)date{
    [self.dateArray removeAllObjects];
    
    //计算当月共有多少天
    NSInteger totalDays = [GSDate totalDaysInMonthFromDate:date];
    
    //计算一个月的第一天星期几
    NSInteger firstDayInMonth = [GSDate weekDayMonthOfFirstDayFromStr:@"2018-01-01"];
    
    for (int i=0; i<firstDayInMonth; i++) {
        [self.dateArray addObject:@""];
    }
    for (int i=0; i<totalDays; i++) {
        [self.dateArray addObject:@(i+1)];
    }
    

    
    [_collectionView reloadData];
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.dateArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GSDateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.dateStr = [self.dateArray[indexPath.item] description];
    cell.backgroundColor = [UIColor whiteColor];
    return  cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellHeaderID forIndexPath:indexPath];
        if (headerView == nil) {
            headerView = [[UICollectionReusableView alloc] init];
            
        }
        return  headerView;
    }
    return  nil;
}
#pragma mark <UICollectionViewDelegate>
//点击item方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
}
//取消点击item方法
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}
@end
