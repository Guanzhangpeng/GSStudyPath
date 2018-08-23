//
//  GSNewsCell.m
//  UICollectionViewLayout
//
//  Created by 管章鹏 on 2018/7/5.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSNewsCell.h"
#import "GSNews.h"
#import "Masonry.h"
@interface GSNewsCell()

@property (nonatomic, strong) UIImageView *newsImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation GSNewsCell

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        //添加图片
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        self.newsImgView = imgView;
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        //添加说明
        UILabel *titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        titleLabel.textColor = [UIColor whiteColor];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.equalTo(self);
            make.height.mas_equalTo(40);
        }];
    }
    return self;
}

-(void)setNews:(GSNews *)news{
    _news = news;
    
     self.newsImgView.image = [UIImage imageNamed:news.icon];
    self.titleLabel.text = [NSString stringWithFormat:@"  %@",news.title];
}
@end
