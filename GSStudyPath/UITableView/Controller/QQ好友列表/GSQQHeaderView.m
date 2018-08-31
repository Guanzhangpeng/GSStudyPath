//
//  GSQQHeaderView.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/30.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSQQHeaderView.h"
#import "GSQQFriendsGroup.h"
@interface GSQQHeaderView()
@property (nonatomic, weak) UIButton *titleBtn;
@property (nonatomic, weak) UILabel *onlineLabel;
@end
@implementation GSQQHeaderView

+(instancetype)headerViewWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"QQHeaderCellID";
    GSQQHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellID];
    if (!headerView) {
        headerView = [[GSQQHeaderView alloc] initWithReuseIdentifier:cellID];
    }
    return headerView;
}
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleBtn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
        [titleBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateSelected];
        titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        titleBtn.contentEdgeInsets = UIEdgeInsetsMake(0.f, 10.f, 0.f, 0.f);
        titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0.f, 15.f, 0.f, 0.f);
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:17.f];
        [titleBtn addTarget:self action:@selector(titleBtnAction:) forControlEvents:UIControlEventTouchUpInside];        
        [self.contentView addSubview:titleBtn];
        self.titleBtn = titleBtn;        
        //在线好友数
        UILabel *onLineLabel = [[UILabel alloc] init];
        onLineLabel.textColor = [UIColor darkGrayColor];
        onLineLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:onLineLabel];
        self.onlineLabel = onLineLabel;
    }
    return self;
}
- (void)titleBtnAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.friendsGroup.open = !self.friendsGroup.open;
    if (self.headerViewAction) {
        self.headerViewAction();
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleBtn.frame = self.bounds;
    self.onlineLabel.frame = CGRectMake(self.gs_width - 150.f -15.f, 0.f, 150.f, self.gs_height);
}
-(void)setFriendsGroup:(GSQQFriendsGroup *)friendsGroup{
    _friendsGroup = friendsGroup;
    [self.titleBtn setTitle:friendsGroup.name forState:UIControlStateNormal];
    self.onlineLabel.text = [NSString stringWithFormat:@"%ld/%ld",friendsGroup.online,friendsGroup.friends.count];
    
    //避免Cell选中状态的循环利用问题
    self.titleBtn.selected =  friendsGroup.isOpen;
}

@end
