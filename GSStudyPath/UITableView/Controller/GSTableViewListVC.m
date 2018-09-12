//
//  GSTableViewListVC.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/28.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSTableViewListVC.h"
@interface GSTableViewListVC ()

@end

@implementation GSTableViewListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UITableView的使用";
    self.dataArray = @[@"GSCarsListVC",@"GSQQFriendsListVC",@"GSExtensibleTableHeader"];
    self.titleArray = @[@"汽车列表--带索引",@"QQ好友列表",@"可拉伸头部控件"];
}
@end
