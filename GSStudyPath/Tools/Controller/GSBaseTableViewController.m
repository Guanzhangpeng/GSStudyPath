//
//  GSBaseTableViewController.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/24.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSBaseTableViewController.h"

@interface GSBaseTableViewController ()

@end

@implementation GSBaseTableViewController
static NSString * const cellID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.tableView.rowHeight = 88;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.tableView reloadData];
}
-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    [self.tableView reloadData];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}
#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id classVC = NSClassFromString(self.dataArray[indexPath.row]);
    id vc = [[classVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end

