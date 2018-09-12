//
//  GSCustomNavBar.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/9/11.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSCustomNavBar.h"

@interface GSCustomNavBar ()

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel  *titleLabel;

@end

@implementation GSCustomNavBar

- (instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0.f, 0.f, [[UIScreen mainScreen] bounds].size.width, 64.0f);
    }
    return self;
}

//懒加载view
- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *bgImg = [UIImage imageNamed:_leftImage];
        [_leftBtn setBackgroundImage:bgImg forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        CGFloat yCoordinate = (44.f - bgImg.size.height) / 2 + 20.f;
        _leftBtn.frame = CGRectMake(15.0f, yCoordinate, bgImg.size.width, bgImg.size.height);
    }
    return _leftBtn;
}
- (void)leftBtnClick{
    if (self.leftBtnAction) {
        self.leftBtnAction();
    }
}

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *bgImg = [UIImage imageNamed:_rightImage];
        [_rightBtn setBackgroundImage:bgImg forState:UIControlStateNormal];
        CGFloat yCoordinate = (44.f - bgImg.size.height) / 2 + 20.f;
        _rightBtn.frame = CGRectMake(self.frame.size.width-15.f - bgImg.size.width, yCoordinate, bgImg.size.width, bgImg.size.height);
        
    }
    return _rightBtn;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = _titleColor;
        _titleLabel.text = _title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.bounds = CGRectMake(0.0f, 0.0f, 200.0f, self.frame.size.height-20.0f);
        _titleLabel.center = CGPointMake(self.frame.size.width/2, (self.frame.size.height+20.0f)/2);
    }
    return _titleLabel;
}

//重写三个setter方法
- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    self.titleLabel.textColor = _titleColor;
}

- (void)setLeftImage:(NSString *)leftImage
{
    _leftImage = leftImage;
    [self.leftBtn setBackgroundImage:[UIImage imageNamed:_leftImage] forState:UIControlStateNormal];
}

- (void)setRightImage:(NSString *)rightImage
{
    _rightImage = rightImage;
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:_rightImage] forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.titleLabel];
}
@end
