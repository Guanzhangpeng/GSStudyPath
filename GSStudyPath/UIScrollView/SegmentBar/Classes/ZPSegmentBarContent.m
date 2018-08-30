//
//  ZPSegmentBarContent.m
//  ZPSegmentBarOC
//
//  Created by 管章鹏 on 2017/3/31.
//  Copyright © 2017年 zswangzp@163.com. All rights reserved.
//

#import "ZPSegmentBarContent.h"
#import "UIView+ZPSegmentBar.h"

#import "ZPSegmentBarTitle.h"

@interface ZPSegmentBarContent()<UICollectionViewDelegate,UICollectionViewDataSource,ZPSegmentBarTitleDelegate>
{
    CGFloat _startOffsetX;
}


@property(nonatomic,strong)NSArray * childVcs;
@property(nonatomic,strong)UIViewController * parentVc;

@end

@implementation ZPSegmentBarContent
static NSString * const contentViewID=@"contentViewID";
-(void)setupWithChildVcs:(NSArray <UIViewController *> *)childVcs parentVc:(UIViewController *)parentVc
{
    self.childVcs=childVcs;
    self.parentVc=parentVc;

    //1.0 将childVcs中的所有子控制器添加到父控制器中;
    for (UIViewController * childVc in childVcs) {
        [self.parentVc addChildViewController:childVc];
    }
    
    //2.0 添加UICollectionView
    [self addSubview:self.collectionView];
}

#pragma  mark---ZPSegmentBarTitleDelegate的代理方法
-(void)segmentBarTitle:(ZPSegmentBarTitle *)segmentBarTitle fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)targetIndex
{
    //1.0 创建indexPath,让collectionView滚动到对应的位置上;
    NSIndexPath * indexPath =[NSIndexPath indexPathForItem:targetIndex inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
    
}

#pragma mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childVcs.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:contentViewID forIndexPath:indexPath];
    
    //移除原有的View
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //创建新的View
    UIViewController * childVC = self.childVcs[indexPath.item];
    childVC.view.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [cell.contentView addSubview:childVC.view];
    
    return  cell;
    
}
#pragma mark ---UIScrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    _startOffsetX=scrollView.contentOffset.x;
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewdidEndScroll];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        
         [self scrollViewdidEndScroll];
    }
}
-(void)scrollViewdidEndScroll
{
    NSInteger targetIndex = floor(self.collectionView.contentOffset.x / self.collectionView.width);
    
    if ([self.delegate respondsToSelector:@selector(segmentBarContent:targetIndex:)]) {
        [self.delegate segmentBarContent:self targetIndex:targetIndex];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sourceIndex = 0 ;
    CGFloat targetIndex = 0 ;
    CGFloat process = 0 ;
    
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    
    //左侧滑动
    if (_startOffsetX < contentOffsetX) {
        
        sourceIndex  =floor((contentOffsetX / self.collectionView.width));
        targetIndex =  sourceIndex+1;
        
        process =(contentOffsetX / self.collectionView.width) - floor((contentOffsetX / self.collectionView.width));
        
        //处理用户手动设置滚动到某个item的情况
        if (self.isCustomScroll) {
            
            if (sourceIndex >self.childVcs.count-1||targetIndex>self.childVcs.count-1||targetIndex<0 ) {
                
                process = 1;
                
                targetIndex = sourceIndex;
            }
        }
        if ((contentOffsetX - _startOffsetX)==self.collectionView.width) {
            process=1;
            targetIndex=sourceIndex;
        }
    }
    //右侧滑动
    else
    {
        targetIndex = floor((contentOffsetX / self.collectionView.width));
        sourceIndex = targetIndex+1;
        process = 1- ((contentOffsetX / self.collectionView.width) - floor((contentOffsetX / self.collectionView.width)));
        
    }
    
    if (sourceIndex >self.childVcs.count-1||targetIndex>self.childVcs.count-1||targetIndex<0 ) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(segmentBarContent:didSelectedIndex:fromIndex:process:)]) {
        [self.delegate segmentBarContent:self didSelectedIndex:targetIndex fromIndex:sourceIndex process:process];
    }
    
}




#pragma mark ---数据懒加载
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize=CGSizeMake(self.width, self.height);
        flowLayout.minimumLineSpacing=0;
        flowLayout.minimumInteritemSpacing=0;
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        UICollectionView * collectionView=[[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        collectionView.showsVerticalScrollIndicator=NO;
        collectionView.showsHorizontalScrollIndicator=NO;
        collectionView.scrollsToTop=NO;
        
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:contentViewID];
        
        collectionView.pagingEnabled=YES;
        collectionView.bounces=NO;
        collectionView.dataSource=self;
        collectionView.delegate=self;
        _collectionView=collectionView;
        
    }
    
    return _collectionView;
}
@end
