//
//  ZPSegmentView.m
//  ZPSegmentBarOC
//
//  Created by 管章鹏 on 2017/4/1.
//  Copyright © 2017年 zswangzp@163.com. All rights reserved.
//

#import "ZPSegmentView.h"


@interface ZPSegmentView()
@property(nonatomic,strong)NSArray * titles;
@property(nonatomic,strong)NSArray * childVcs;
@property(nonatomic,strong)UIViewController * parentVc;
@property(nonatomic,strong)ZPSegmentBarStyle * style;

@end

@implementation ZPSegmentView

-(void)setupWithtitles:(NSArray<NSString *>*)titles style:(ZPSegmentBarStyle *)style childVcs:(NSArray<UIViewController*>*)childVcs parentVc:(UIViewController *)parentVc
{
    
    self.titles=titles;
    self.childVcs=childVcs;
    self.parentVc=parentVc;
    self.style=style;
    
    //1.0 新建ZPSegmentBarTitle
    CGRect titleFrame=CGRectMake(0, 64, self.width,self.style.titleHeight);
    ZPSegmentBarTitle * segmentBarTitle =[[ZPSegmentBarTitle alloc]initWithFrame:titleFrame];
    [segmentBarTitle setupWithTitles:self.titles style:self.style];
    [self addSubview:segmentBarTitle];
    segmentBarTitle.backgroundColor=self.style.titleViewBG;
    
    //2.0 新建ZPSegmentContent
    CGRect contentFrame=CGRectMake(0, CGRectGetMaxY(segmentBarTitle.frame), self.width, self.height-segmentBarTitle.height);
    ZPSegmentBarContent * contentView=[[ZPSegmentBarContent alloc]initWithFrame:contentFrame];
    [contentView setupWithChildVcs:self.childVcs parentVc:self.parentVc];
    self.contentView = contentView;
    [self addSubview:contentView];
    
    segmentBarTitle.delegate = contentView;
    
    contentView.delegate = segmentBarTitle;
    
    
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
      
        
    }
    return self;
}

#pragma mark 数据懒加载
//-(NSArray *)titles
//{
//    if (!_titles) {
//        _titles=[NSArray array];
//    }
//    return _titles;
//}
//-(NSArray *)childVcs
//{
//    if (_childVcs) {
//        _childVcs=[NSArray array];
//    }
//    return _childVcs;
//}
//-(UIViewController *)parentVc
//{
//    if (!_parentVc) {
//        _parentVc = [[UIViewController alloc]init];
//        
//    }
//    return _parentVc;
//}
@end
