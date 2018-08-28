
//
//  GSHomeVC.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/23.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSHomeVC.h"
@interface GSHomeVC ()
@end

@implementation GSHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = @[@"GSTableViewListVC",@"GSCollectionListVC",@"GSSearchListVC"];
    self.titleArray = @[@"UITableView的使用",@"UICollectionView的使用",@"UISearchController 的使用"];
}

@end
