//
//  GSMTAddressMainVC.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/28.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSMTAddressMainVC.h"
#import "GSSegmentedControl.h"
#import "GSAddressTableView.h"
#import "GSMTAddressModal.h"
@interface GSMTAddressMainVC ()

@property (nonatomic, strong) GSAddressTableView *addressTableView;
@property (nonatomic, strong) GSMTAddressModal   *dataModal;

@end

@implementation GSMTAddressMainVC

#pragma mark -- getter method
-(GSAddressTableView *)addressTableView{
    if (!_addressTableView) {
        CGFloat yCoordinate = 0.f;
        _addressTableView = [[GSAddressTableView alloc] initWithFrame:CGRectMake(0.f, yCoordinate, SCREENSIZE.width, SCREENSIZE.height) style:UITableViewStylePlain];
        _addressTableView.cityDataDict = self.dataModal.cityDataDict;
        _addressTableView.cityArr = self.dataModal.cityArr;
        __weak typeof(self) weakSelf = self;
        _addressTableView.selectCityAction = ^(NSString *city) {
            [weakSelf closeAction];
            NSLog(@"当前选中的城市:%@",city);
        };
    }
    return _addressTableView;
}
- (GSMTAddressModal *)dataModal{
    if (!_dataModal) {
        _dataModal = [[GSMTAddressModal alloc] init];
    }
    return _dataModal;
}

#pragma mark -- system method
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationBar];
    [self.view addSubview:self.addressTableView];
}

- (void)setupNavigationBar{
    //关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0.f, 0.f, 20.f, 20.f);
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"closeBtn"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    
    //区域选择SegmentedControl
    GSSegmentedControl *segmentC = [[GSSegmentedControl alloc] initWithItems:@[@"国内",@"海外"]];
    self.navigationItem.titleView = segmentC;
}

- (void)closeAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
