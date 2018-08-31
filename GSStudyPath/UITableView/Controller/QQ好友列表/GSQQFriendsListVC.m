//
//  GSQQFriendsListVC.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/30.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSQQFriendsListVC.h"
#import "GSQQFriendsGroup.h"
#import "GSQQFriendModal.h"
#import "GSQQHeaderView.h"
@interface GSQQFriendsListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *friendsArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GSQQFriendsListVC

static NSString *const cellID = @"cellID";
#pragma mark -- getter method
-(NSArray *)friendsArray{
    if (!_friendsArray) {
       NSString *path = [[NSBundle mainBundle] pathForResource:@"friends" ofType:@"plist"];
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dataArray) {
            [tempArray addObject:[GSQQFriendsGroup friendsGroupWithDict:dict]];
        }
        
        _friendsArray = tempArray;
    }
    return _friendsArray;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}
#pragma mark --system method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
}
#pragma mark -- UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.friendsArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    GSQQFriendsGroup *friendsGroup = self.friendsArray[section];
    return friendsGroup.isOpen ? friendsGroup.friends.count : 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    GSQQFriendsGroup *friendsGroup = self.friendsArray[indexPath.section];
    GSQQFriendModal *friendModal = friendsGroup.friends[indexPath.row];
    cell.textLabel.text = friendModal.name;
    cell.textLabel.textColor = friendModal.isVip ? [UIColor redColor] : [UIColor blackColor];
    cell.imageView.image = [UIImage imageNamed:friendModal.icon];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    GSQQHeaderView *headerView = [GSQQHeaderView headerViewWithTableView:tableView];
    headerView.friendsGroup = self.friendsArray[section];
    headerView.headerViewAction = ^{
        [self.tableView reloadData];
    };
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.f;
}
@end
