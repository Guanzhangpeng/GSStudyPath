//
//  GSAddressFirstHeaderView.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/29.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSAddressFirstHeaderView.h"
#import "GSSelectButton.h"

@implementation GSAddressFirstHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.contentView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 0.f, 200.f, 30.f)];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:14.f];
        titleLabel.text = [NSString stringWithFormat:@"当前:长沙全城"];
        [self addSubview:titleLabel];
        
        GSSelectButton *citySelectBtn = [GSSelectButton buttonWithType:UIButtonTypeCustom];
        [citySelectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [citySelectBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [citySelectBtn setTitle:@"切换区县" forState:UIControlStateNormal];
        [citySelectBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [citySelectBtn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
        [citySelectBtn addTarget:self action:@selector(citySelect:) forControlEvents:UIControlEventTouchUpInside];
        citySelectBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100.f, 0.f, 80.f, 30.f);
        [self addSubview:citySelectBtn];
    }
    return self;
}
- (void)citySelect:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (self.delegate) {
        [self.delegate citySelectAction:btn.selected];
    }
}
@end
