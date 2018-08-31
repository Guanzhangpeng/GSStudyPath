//
//  GSQQHeaderView.h
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/30.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GSQQFriendsGroup;

@interface GSQQHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) GSQQFriendsGroup *friendsGroup;
@property (nonatomic, strong) void(^headerViewAction)(void);

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
