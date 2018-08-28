//
//  GSSearchResultVC.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/22.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSSearchResultVC.h"

@interface GSSearchResultVC ()

@end

@implementation GSSearchResultVC
    static NSString *const cellID = @"cellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

-(void)setFilterDataArray:(NSArray *)filterDataArray{
    _filterDataArray = filterDataArray;
    [self.tableView reloadData];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filterDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = self.filterDataArray[indexPath.row];
    return cell;
}
@end
