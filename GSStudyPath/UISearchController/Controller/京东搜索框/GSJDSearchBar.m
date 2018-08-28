//
//  GSJDSearchBar.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/25.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSJDSearchBar.h"

@implementation GSJDSearchBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:14.f];
        self.backgroundColor = GSColor(240, 243, 245);
        self.layer.cornerRadius = 5.f;
        self.placeholder = @"京东超级品牌日";
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 28.f, 28.f)];
        UIImageView *searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(8.f, 7.5f, 13.f, 13.f)];
        searchIcon.image = [UIImage imageNamed:@"search_gray"];
        [leftView addSubview:searchIcon];
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return self;
}
@end
