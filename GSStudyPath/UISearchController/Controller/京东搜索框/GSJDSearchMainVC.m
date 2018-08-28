//
//  GSJDSearchMainVC.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/25.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSJDSearchMainVC.h"
#import "GSJDSearchVC.h"
#import "GSSearchResultVC.h"
#import "GSJDButton.h"
#import "GSCountryModal.h"
#import "GSJDSearchHistory.h"
@interface GSJDSearchMainVC ()<GSSearchResultsUpdating,GSSearchControllerDelegate,CAAnimationDelegate>{
    GSJDButton *_scanBtn;
    GSJDButton *_messageBtn;
}
@property (nonatomic, strong) GSJDSearchVC *searchVC;
@property (nonatomic, strong) GSJDSearchHistory *historyView;

@end

@implementation GSJDSearchMainVC

#pragma mark -- getter method
-(GSJDSearchVC *)searchVC{
    if (!_searchVC) {
        
        GSSearchResultVC *resultVC = [[GSSearchResultVC alloc] init];
        _searchVC = [[GSJDSearchVC alloc] initWithSearchResultsController:resultVC];
        _searchVC.delegate = self;
        _searchVC.searchResultsUpdater = self;
    }
    return _searchVC;
}
-(GSJDSearchHistory *)historyView{
    if (!_historyView) {
        CGFloat yCoordinate = 64.f;
        if(GS_iPhoneX){
            yCoordinate = 88.f;
        }
        _historyView = [[GSJDSearchHistory alloc] initWithFrame:CGRectMake(0.f, yCoordinate, SCREENSIZE.width, SCREENSIZE.height) style:UITableViewStyleGrouped];
        
        if (@available (iOS 11, *)) {
            _historyView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        __weak typeof(self) weakSelf = self;
        _historyView.scrollAction = ^{
            [weakSelf.searchVC.searchBar resignFirstResponder];
        };
        _historyView.hotBtnAction = ^(NSString *searchData) {
            NSLog(@"%@",searchData);
            [weakSelf messageAction];
        };
        
        _historyView.historyData =  @[@"历史记录", @"笔记本", @"iPhone7", @"化妆品", @"台式机"];
        
    }
    return _historyView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationView];
    [self.view addSubview:self.historyView];
    [self.searchVC.searchBar becomeFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //扫一扫按钮动画
    [UIView animateWithDuration:0.2f animations:^{
        self.searchVC.searchBar.frame = ({
            CGRect frame = self.searchVC.searchBar.frame;
            frame.origin.x -= 40;
            frame.size.width += 40;
            frame;
        });
        self->_scanBtn.alpha = 0.f;
    }];
    
    //消息按钮动画
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration = 0.2f;
    anim.fromValue = @1;
    anim.toValue = @0;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.delegate = self;
    [_messageBtn.layer addAnimation:anim forKey:nil];
}

- (void)setNavigationView{
    
    CGFloat yCoordinate = 20.f;
    if (GS_iPhoneX) {
        yCoordinate = 44.f;
    }
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0.f, yCoordinate, SCREENSIZE.width, 44.f)];
    [self.view addSubview:navView];
    
    //扫一扫按钮
    _scanBtn = [GSJDButton buttonWithType:UIButtonTypeCustom];
    [_scanBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [_scanBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_scanBtn setImage:[UIImage imageNamed:@"scan_gray"] forState:UIControlStateNormal];
    _scanBtn.frame = CGRectMake(10.f, 7.f, 30.f, 33.f);
    [navView addSubview:_scanBtn];
    
    //消息按钮
    _messageBtn = [GSJDButton buttonWithType:UIButtonTypeCustom];
    [_messageBtn setTitle:@"消息" forState:UIControlStateNormal];
    [_messageBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_messageBtn setImage:[UIImage imageNamed:@"message_gray"] forState:UIControlStateNormal];
    _messageBtn.frame = CGRectMake(SCREENSIZE.width - 40.f, 7.f, 30.f, 33.f);
    [_messageBtn addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:_messageBtn];
    
    //添加搜索框
    self.searchVC.searchBar.frame = CGRectMake(50.f, 8.f, SCREENSIZE.width - 100.f, 28.f);
    [navView addSubview:self.searchVC.searchBar];
}

#pragma mark --CAAnimationDelegate
-(void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag{
    if ([anim.keyPath isEqualToString:@"transform.scale"]) {
        
        _messageBtn.noImage = YES;
        [_messageBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        anim1.duration = 0.2f;
        anim1.fromValue = @0;
        anim1.toValue = @1;
        anim1.fillMode = kCAFillModeForwards;
        anim1.removedOnCompletion = NO;
        [_messageBtn.layer addAnimation:anim1 forKey:nil];
    }
}
- (void)messageAction{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"searchVCRemove" object:nil];
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}

#pragma mark --GSSearchControllerDelegate
-(void)didPresentSearchController:(GSJDSearchVC *)searchController{
    //添加searchVC
    [self addChildViewController:searchController];
    [self.view addSubview:searchController.view];
}
-(void)didDismissSearchController:(GSJDSearchVC *)searchController{
    [searchController removeFromParentViewController];
    [searchController.view removeFromSuperview];
}
#pragma mark --GSSearchResultsUpdating
-(void)updateSearchResultsForSearchController:(GSJDSearchVC *)searchController{
    GSSearchResultVC *resultVC = (GSSearchResultVC *)searchController.searchResultsController;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF CONTAINS %@)",searchController.searchBar.text];
    NSArray *dataArray = [GSCountryModal sharedDataModal].dataArray;
    NSArray *filterArray = [dataArray filteredArrayUsingPredicate:predicate];
    filterArray = searchController.searchBar.text > 0 ? filterArray : dataArray;
    resultVC.filterDataArray = filterArray;
}
@end
