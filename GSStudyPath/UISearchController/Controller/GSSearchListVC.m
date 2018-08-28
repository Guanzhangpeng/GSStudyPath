//
//  GSSearchListVC.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/24.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSSearchListVC.h"
#import "GSNavigationController.h"

@interface GSSearchListVC ()

@end

@implementation GSSearchListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"searchController的使用";
    self.titleArray = @[
                        @"UISearchController 基本使用",
                        @"高仿京东搜索框",
                        @"高仿美团地址搜索"
                        ];
    
    self.dataArray = @[
                        @"GSNormalSearchVC",
                        @"JDHomeVC",
                        @"GSMTAddressMainVC"
                       ];
    
}
#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id classVC = NSClassFromString(self.dataArray[indexPath.row]);
    id vc = [[classVC alloc] init];
    if([self.titleArray[indexPath.row] isEqualToString:@"高仿美团地址搜索"]){
        GSNavigationController *nav = [[GSNavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
         [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
