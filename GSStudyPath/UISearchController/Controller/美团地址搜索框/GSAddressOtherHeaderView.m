//
//  GSAddressOtherHeaderView.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/29.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSAddressOtherHeaderView.h"
@interface GSAddressOtherHeaderView()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation GSAddressOtherHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 0.f, 200.f, 30.f)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.textColor = [UIColor grayColor];
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setText:(NSString *)text {
    _text = text;
    _titleLabel.text = _text;
}
@end
