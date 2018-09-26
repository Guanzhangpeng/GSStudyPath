//
//  GSAlipayHomeCell.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/9/20.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSAlipayHomeCell.h"
#import "Masonry.h"
#define k1PX ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)

@implementation TableViewCellContentView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, k1PX);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextMoveToPoint(context, 0, k1PX / 2);
    CGContextAddLineToPoint(context, rect.size.width, k1PX / 2);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 0, rect.size.height - k1PX / 2);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height - k1PX / 2);
    CGContextStrokePath(context);
}

@end


@interface GSAlipayHomeCell()

@property (nonatomic, strong) TableViewCellContentView *container;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *desLabel;

@end
@implementation GSAlipayHomeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_setupSubviews];
        [self p_layoutSubviews];
    }
    return self;
}

#pragma mark - private
- (void)p_setupSubviews {
    [self.contentView addSubview:self.container];
    [self.container addSubview:self.iconView];
    [self.container addSubview:self.titleLabel];
    [self.container addSubview:self.timeLabel];
    [self.container addSubview:self.contentLabel];
    [self.container addSubview:self.desLabel];
}

- (void)p_layoutSubviews {
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.bottom.right.mas_equalTo(0);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.width.height.mas_equalTo(25);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.iconView);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.iconView);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
        make.right.mas_equalTo(-15);
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-15);
    }];
}

#pragma mark - lazy
- (TableViewCellContentView *)container {
    if (!_container) {
        _container = [TableViewCellContentView new];
        _container.backgroundColor = [UIColor whiteColor];
    }
    return _container;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [UIImageView new];
        _iconView.image = [UIImage imageNamed:@"HomeIcon2"];
    }
    
    return _iconView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.text = @"蚂蚁森林";
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.text = @"上午 9:29";
    }
    return _timeLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.text = @"又有好友收了你的绿色能量";
    }
    return _contentLabel;
}

- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [UILabel new];
        _desLabel.textColor = [UIColor lightGrayColor];
        _desLabel.font = [UIFont systemFontOfSize:14];
        _desLabel.text = @"XX在12:04收取";
    }
    return _desLabel;
}
@end
