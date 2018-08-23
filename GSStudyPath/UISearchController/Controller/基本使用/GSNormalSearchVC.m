//
//  GSNormalSearchVC.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/22.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSNormalSearchVC.h"
#import "GSCountryModal.h"
#import "GSSearchResultVC.h"

@interface GSNormalSearchVC ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate>{
    NSArray *_dataArray;//数据源
    NSArray *_filterArray;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation GSNormalSearchVC
static NSString *const CellID = @"cellID";
#pragma mark --getter method
-(UISearchController *)searchController{
    if (!_searchController) {
        //创建UISearchController,当ResultsController为nil的时候当前控制器就是结果控制器
        GSSearchResultVC *resultVC = [[GSSearchResultVC alloc] init];
        _searchController = [[UISearchController alloc] initWithSearchResultsController:resultVC];
        _searchController.hidesNavigationBarDuringPresentation = YES;//当搜索框激活时, 是否隐藏导航条 default is YES;
        _searchController.dimsBackgroundDuringPresentation = YES;//当搜索框激活时, 是否添加一个透明视图 default is YES
        _searchController.searchBar.placeholder = @"查找您所在的区域";//搜索框占位符
        _searchController.delegate = self;
        _searchController.searchResultsUpdater = self;
    }
    return _searchController;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        
        //适配iOS 11,在 `iOS 11`环境中UISearchBar不是添加到UISearchControllerView中 而是被添加到了 导航栏中了
        if (@available(iOS 11, *)) {
            self.navigationItem.searchController = self.searchController;
            self.navigationItem.hidesSearchBarWhenScrolling = NO;
        } else {
            self.tableView.tableHeaderView = self.searchController.searchBar;
        }
      
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    }
    return _tableView;
}
#pragma mark --系统回调方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SearchController基本使用";
    _dataArray = [GSCountryModal sharedDataModal].dataArray;
    _filterArray = _dataArray;
    self.definesPresentationContext = YES;
    [self.view addSubview:self.tableView];
    
//    [self customSearchBarStyle];
    
}
//自定义SearchBar 样式
- (void)customSearchBarStyle{
    //将Cancel 修改为 【取消】
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"取消"];
//    [self.searchCtrl.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
    
    //改变 🔍 的位置
     [self.searchController.searchBar setPositionAdjustment:UIOffsetMake(100.f, 0.f) forSearchBarIcon:UISearchBarIconSearch];
    
    //修改取消文字颜色以及光标的颜色
    self.searchController.searchBar.tintColor = [UIColor redColor];
    
    //bar's background iOS 11 环境中貌似不起作用
//    self.searchController.searchBar.barTintColor = [UIColor yellowColor];
    
    //为searchBar 设置图片
    [self.searchController.searchBar setImage:[UIImage imageNamed:@"voice_gray"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [self.searchController.searchBar setImage:[UIImage imageNamed:@"message_gray"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    [self.searchController.searchBar setImage:[UIImage imageNamed:@"message_gray"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateHighlighted];
    
    //修改文字样式（在iOS 11 环境中拿不到该属性）
    UITextField *textField = [self.searchController.searchBar valueForKey:@"_searchField"];
    textField.textColor = [UIColor blueColor];
    textField.font = [UIFont systemFontOfSize:15.f];
    
    //占位文字
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //取消上下两条线
    for (UIView *view in self.searchController.searchBar.subviews.firstObject.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view removeFromSuperview];
        }
    }
    
    if (@available(iOS 11, *)) {
        for (UIView *view in textField.subviews) {
            if ([view isKindOfClass:NSClassFromString(@"_UISearchBarSearchFieldBackgroundView")]) {
                [view removeFromSuperview];
            }

        }
    }
}
#pragma mark --UISearchResultsUpdating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF CONTAINS %@)",searchController.searchBar.text];
    _filterArray = [_dataArray filteredArrayUsingPredicate:predicate];
    _filterArray = searchController.searchBar.text.length > 0 ? _filterArray : _dataArray;
    GSSearchResultVC *resultVC = (GSSearchResultVC *) searchController.searchResultsController;
    resultVC.filterDataArray = _filterArray;
//    [self.tableView reloadData];
}

#pragma mark --UISearchControllerDelegate
-(void)willPresentSearchController:(UISearchController *)searchController{
    
    NSLog(@"将要弹出searchController");
}
-(void)willDismissSearchController:(UISearchController *)searchController{
    NSLog(@"将要消失searchController");
}

#pragma mark --UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _filterArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.textLabel.text = _filterArray[indexPath.row];
    return cell;
}
@end
