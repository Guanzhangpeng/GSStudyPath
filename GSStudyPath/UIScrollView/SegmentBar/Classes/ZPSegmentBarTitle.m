//
//  ZPSegmentBar.m
//  ZPSegmentBarOC
//
//  Created by 管章鹏 on 2017/3/30.
//  Copyright © 2017年 zswangzp@163.com. All rights reserved.
//

#import "ZPSegmentBarTitle.h"
#import "UIView+ZPSegmentBar.h"
#import "ZPSegmentBarStyle.h"
#import "ZPSegmentBarContent.h"

@interface ZPSegmentBarTitle()<ZPSegmentBarContentDelegate>
{
    NSInteger _currentIndex;
    
}
@property(nonatomic,strong) UIScrollView * scrollView;
@property(nonatomic,strong) ZPSegmentBarStyle * style;
@property(nonatomic,strong) NSArray<NSString *>* titles;
@property(nonatomic,strong) NSMutableArray<UILabel *> * titleLbls;

@property(nonatomic,strong) NSArray * normalColorRGB;
@property(nonatomic,strong) NSArray * selectedColorRGB;
@property(nonatomic,strong) NSMutableArray * deltaColorRGB;



/**
 底部指示器
 */
@property(nonatomic,strong) UIView * bottomLine;


/**
 遮盖
 */
@property(nonatomic,strong) UIView * coverView;

@end
@implementation ZPSegmentBarTitle

-(void)setupWithTitles:(NSArray<NSString *> *)titles style:(ZPSegmentBarStyle *)style
{    
    self.titles=titles;
    self.style=style;
    _currentIndex = 0 ;
    
    //1.0 初始化UIScrollView
    [self addSubview:self.scrollView];
    
    //2.0 初始化UILabel并且布局
    [self setuptitlelabes];
    
    //3.0 添加bottomLine并且布局
    if (self.style.isShowBottomLine) {
        [self setupBottomLine];
    }

    //4.0 添加CoverView并且布局
    if (self.style.isShowCover) {
        [self setupCoverView];
    }
}



#pragma mark 初始化TitleLabel
-(void)setuptitlelabes
{
    for (int i=0;i<self.titles.count;i++)
    {
        //初始化title
        UILabel * lblTitle = [[UILabel alloc]init];
        lblTitle.text=self.titles[i];
        lblTitle.tag=i;
        lblTitle.textAlignment=NSTextAlignmentCenter;
        lblTitle.font=self.style.titleFont;
        lblTitle.textColor = i==0? self.style.selecteColor :self.style.normalColor;
        lblTitle.userInteractionEnabled=YES;
        
        //添加点击手势;
        UITapGestureRecognizer * tapGes =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
        [lblTitle addGestureRecognizer:tapGes];
        
        [self.scrollView addSubview:lblTitle];
        [self.titleLbls addObject:lblTitle];
    }
    
    //如果不能够滚动计算文字之间的间距;
    CGFloat calculteMargin = 0 ;
    CGFloat titleLabelX = 0 ;
    CGFloat titleLabelY = 0 ;
    CGFloat titleLabelW = 0 ;
    NSMutableDictionary * attribute=[NSMutableDictionary dictionary];
    attribute[NSFontAttributeName]=self.style.titleFont;
    
    if (!self.style.isScrollEnabled)
    {
        CGFloat totalWidth = 0 ;
        for(UILabel * title in self.titleLbls)
        {
            titleLabelW= [title.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.style.titleHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.width;
            
            totalWidth += titleLabelW;
            
        }
        calculteMargin = (self.width - totalWidth)/self.titleLbls.count;
        
        if (calculteMargin < self.style.titleMargin) {
            calculteMargin = self.style.titleMargin;
        }
    }
    
    //布局titleLabel的frame
    for (int index=0; index<self.titleLbls.count; index++) {
   
        UILabel * title=self.titleLbls[index];
        
        titleLabelW= [title.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.style.titleHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.width;
        
        //标题能够滚动
        if(self.style.isScrollEnabled)
        {
            titleLabelX = index==0 ? self.style.titleMargin * 0.5 : CGRectGetMaxX(self.titleLbls[index-1].frame)+self.style.titleMargin;
        }
        else
        {
            titleLabelX = index==0 ? calculteMargin * 0.5 : CGRectGetMaxX(self.titleLbls[index-1].frame)+calculteMargin;
        }
        
        title.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, self.style.titleHeight);

    }
    
    //如果titleView可以滚动设置ContentSize范围;
    if (self.style.isScrollEnabled) {
        self.scrollView.contentSize=CGSizeMake(CGRectGetMaxX(self.titleLbls.lastObject.frame)+self.style.titleMargin*0.5, 0);
    }
    
    
    //让第一个按钮处于选中状态;
    if (self.style.isNeedScale) {
        self.titleLbls.firstObject.transform= CGAffineTransformMakeScale(self.style.maxScale, self.style.maxScale);
    }
}

#pragma mark 初始化BottomLine
-(void)setupBottomLine
{
    [self.scrollView addSubview:self.bottomLine];
    self.bottomLine.frame=self.titleLbls.firstObject.frame;
    self.bottomLine.height=self.style.bottomLineHeight;
    self.bottomLine.y=self.height-self.style.bottomLineHeight;
}

#pragma mark 初始化CoverView
-(void)setupCoverView
{
    [self.scrollView insertSubview:self.coverView atIndex:0];
    CGFloat coverViewX = self.titleLbls.firstObject.x - self.style.coverViewMargin;
    CGFloat coverViewY = (self.style.titleHeight - self.style.coverViewHeight) * 0.5;
    CGFloat coverViewH = self.style.coverViewHeight;
    CGFloat coverViewW = self.titleLbls.firstObject.width + self.style.coverViewMargin * 2;

    self.coverView.frame= CGRectMake(coverViewX, coverViewY, coverViewW, coverViewH);
}


#pragma mark 按钮的点击事件
-(void)titleClick:(UITapGestureRecognizer  *)tapGes
{
    UILabel * targetLabel =(UILabel *)tapGes.view ;
    
    //如果是之前点击的按钮则不再继续执行;
    if (_currentIndex == targetLabel.tag) {
        return;
    }
    
    //获取UILabel
    UILabel * sourceLabel = self.titleLbls[_currentIndex];
    
    sourceLabel.textColor = self.style.normalColor;
    targetLabel.textColor = self.style.selecteColor;
    
    
    if (self.style.isShowBottomLine) {
        //调整bottomLine的位置;
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomLine.width=targetLabel.width;
            self.bottomLine.centerX=targetLabel.centerX;
        }];
    }
    
   

    //调整选中titleLabel的尺寸;
    if(self.style.isNeedScale)
    {
        [UIView animateWithDuration:0.25 animations:^{
            sourceLabel.transform=CGAffineTransformIdentity;
            targetLabel.transform = CGAffineTransformMakeScale(self.style.maxScale, self.style.maxScale);
            
        }];
    }

    //调整CoverView的位置;
    if (self.style.isShowCover) {
        [UIView animateWithDuration:0.25 animations:^{
            
            self.coverView.x = targetLabel.x - self.style.coverViewMargin;
            self.coverView.width = targetLabel.width + self.style.coverViewMargin * 2;
            
        }];
    }
    
    //执行代理方法
    if ([self.delegate respondsToSelector:@selector(segmentBarTitle:fromIndex:toIndex:)]) {
        
        [self.delegate segmentBarTitle:self fromIndex:_currentIndex toIndex:targetLabel.tag];
        
    }
     _currentIndex = targetLabel.tag;
    
    //调整titleLabel的位置;
    if (self.style.isScrollEnabled) {
        [self adjustLabelPosition];
    }
}
#pragma mark 调整titleLabel的位置
-(void)adjustLabelPosition
{
    //如果标题不能滚动,则不再继续;
    if (!self.style.isScrollEnabled) {
        return;
    }
    UILabel * targetlabel = self.titleLbls[_currentIndex];
    
    CGFloat offsetX=targetlabel.centerX - self.scrollView.width * 0.5;
    
    if (offsetX < 0) {
        offsetX=0;
    }
    CGFloat maxOffsetX =self.scrollView.contentSize.width - self.scrollView.width;
    
    if (offsetX >maxOffsetX ) {
        offsetX=maxOffsetX;
    }
    
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark -- ZPSegmentBarContentDelegate
-(void)segmentBarContent:(ZPSegmentBarContent *)segmentBarContent targetIndex:(NSInteger)targetIndex
{
    _currentIndex=targetIndex;
    
    [self adjustLabelPosition];
    
    
}

-(void)segmentBarContent:(ZPSegmentBarContent *)segmentBarContent didSelectedIndex:(NSInteger)selectedIndex fromIndex:(NSInteger)fromIndex process:(CGFloat)process
{

    //1.0 获取UILabel
    UILabel * sourceLabel = self.titleLbls[fromIndex];
    UILabel * targetLabel = self.titleLbls[selectedIndex];
    
    _currentIndex=selectedIndex;
    
    //让第一个选项 是正常的颜色
    if(self.style.isDealFirstItem && selectedIndex != 0 && fromIndex != 0)
    {
        UILabel *firstLabel = self.titleLbls[0];
        firstLabel.textColor = self.style.normalColor;
        firstLabel.transform = CGAffineTransformMakeScale(1.0 , 1.0);
        
    }

    //2.0 颜色渐变
    sourceLabel.textColor= [UIColor colorWithRed:[self.selectedColorRGB[0] floatValue]-[self.deltaColorRGB[0] floatValue] * process green:[self.selectedColorRGB[1] floatValue]-[self.deltaColorRGB[1] floatValue] * process blue:[self.selectedColorRGB[2] floatValue]-[self.deltaColorRGB[2] floatValue] * process alpha:1.0];
    
    targetLabel.textColor = [UIColor colorWithRed:[self.normalColorRGB[0] floatValue]+[self.deltaColorRGB[0] floatValue] * process green:[self.normalColorRGB[1] floatValue]+[self.deltaColorRGB[1] floatValue] * process blue:[self.normalColorRGB[2] floatValue]+[self.deltaColorRGB[2] floatValue] * process alpha:1.0];
    
    //3.0 文字缩放
    if(self.style.isNeedScale)
    {
        CGFloat deltaScale = self.style.maxScale - 1.0 ;
        
        [UIView animateWithDuration:0.25 animations:^{
            sourceLabel.transform=CGAffineTransformMakeScale(self.style.maxScale - deltaScale * process, self.style.maxScale - deltaScale * process);
            targetLabel.transform = CGAffineTransformMakeScale(1.0 + deltaScale * process, 1.0 + deltaScale * process);
        }];
    }
    CGFloat deltaX = targetLabel.x - sourceLabel.x;
    CGFloat deltaWidth = targetLabel.width - sourceLabel.width;
    
    //4.0 改变bottomLine的位置;
    if (self.style.isShowBottomLine)
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomLine.x= sourceLabel.x + deltaX * process;
            self.bottomLine.width=sourceLabel.width + deltaWidth * process;
        }];
    }
    
    //5.0 遮盖效果
    if(self.style.isShowCover)
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.coverView.x=sourceLabel.x+deltaX * process -self.style.coverViewMargin;
            self.coverView.width = sourceLabel.width +deltaWidth * process+ self.style.coverViewMargin * 2;
        }];
    }
    
}



#pragma mark 数据懒加载

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        
        scrollView.showsVerticalScrollIndicator=NO;
        scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView=scrollView;
    }
    return _scrollView;
}
-(NSMutableArray<UILabel *> *)titleLbls{
    if (!_titleLbls) {
        _titleLbls=[NSMutableArray array];
    }
    return _titleLbls;
}

-(UIView *)bottomLine
{
    if (!_bottomLine) {

        UIView * bottomLine=[[UIView alloc]init];
        bottomLine.backgroundColor=self.style.bottomLineColor;
        _bottomLine=bottomLine;
    }
    return _bottomLine;
}
-(UIView *)coverView
{
    if (!_coverView) {
        
        _coverView=[[UIView alloc]init];
        _coverView.backgroundColor=self.style.coverViewColor;
        _coverView.alpha=self.style.coverViewAlpha;
        _coverView.layer.cornerRadius=self.style.coverViewRadius;
        _coverView.layer.masksToBounds=YES;
        
        
    }
    return  _coverView;
}

#pragma mark -- 颜色相关方法
-(NSArray *)normalColorRGB{
    if (!_normalColorRGB) {
        _normalColorRGB=[NSArray array];
        _normalColorRGB = [self getRGBWithColor:self.style.normalColor];
    }
    return _normalColorRGB;
}
-(NSArray *)selectedColorRGB{
    if (!_selectedColorRGB) {
        _selectedColorRGB=[NSArray array];
        _selectedColorRGB=[self getRGBWithColor:self.style.selecteColor];
    }
    return _selectedColorRGB;
}
-(NSMutableArray *)deltaColorRGB{
    if (!_deltaColorRGB) {
        _deltaColorRGB=[NSMutableArray array];
        
        _deltaColorRGB[0]=@([self.selectedColorRGB[0] floatValue] - [self.normalColorRGB[0] floatValue]);
        _deltaColorRGB[1]=@([self.selectedColorRGB[1] floatValue] - [self.normalColorRGB[1] floatValue]);
        _deltaColorRGB[2]=@([self.selectedColorRGB[2] floatValue] - [self.normalColorRGB[2] floatValue]);
    }
    return _deltaColorRGB;
}

- (NSArray *)getRGBWithColor:(UIColor *)color
{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red), @(green), @(blue), @(alpha)];
}

@end
