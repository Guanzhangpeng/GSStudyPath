//
//  JDHomeVC.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/24.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "JDHomeVC.h"
#import "GSInfiniteView.h"
#import "GSJDNavigationView.h"
#import "GSJDSearchMainVC.h"
@interface JDHomeVC ()
@property (nonatomic, strong) GSInfiniteView *infiniteView;
@property (nonatomic, strong) GSJDNavigationView *navigationView;
@end

@implementation JDHomeVC

#pragma mark -- getter method
-(GSInfiniteView *)infiniteView{
    if (!_infiniteView) {
        NSArray *imgArray = @[@"S0",@"S1",@"S2",@"S3",@"S4",@"S5"];
        
        CGFloat height = SCREENSIZE.width / 2.f;
        if (GS_iPhoneX) {
            height += 24.f;
            imgArray = @[@"S0X",@"S1X",@"S2X",@"S3X",@"S4X",@"S5X"];
        }
        _infiniteView = [[GSInfiniteView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREENSIZE.width, height)];
        _infiniteView.imgArray = imgArray;
    }
    return _infiniteView;
}
-(GSJDNavigationView *)navigationView{
    if (!_navigationView) {
        CGFloat yCoordinate = 20.f;
        if (GS_iPhoneX) {
            yCoordinate = 44.f;
        }
        __weak typeof(self) weakSelf = self;
        _navigationView = [[GSJDNavigationView alloc] initWithFrame:CGRectMake(0, yCoordinate, SCREENSIZE.width, 44.f)];
        _navigationView.searchActionBlock = ^{
            NSLog(@"搜索");
            [weakSelf goSearchPage];
        };
        _navigationView.scanActionBlock  = ^{
            NSLog(@"扫一扫");
        };
        _navigationView.messageActionBlock = ^{
             NSLog(@"消息");
        };
        _navigationView.audioActionBlock = ^{
             NSLog(@"语音");
        };
        
   }
    return _navigationView;
}
#pragma mark -- system method
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchVCRemove) name:@"searchVCRemove" object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.infiniteView];
    [self.view addSubview:self.navigationView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}
- (void)searchVCRemove{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2f animations:^{
        weakSelf.navigationView.searchView.frame = ({
            CGRect frame = weakSelf.navigationView.searchView.frame;
            frame.origin.x += 40.f;
            frame.size.width -= 40.f;
            frame;
        });
        weakSelf.navigationView.audioBtn.frame = ({
            CGRect frame = weakSelf.navigationView.audioBtn.frame;
            frame.origin.x = weakSelf.navigationView.gs_width - 20.f;
            frame;
        });
    }];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration = 0.2f;
    anim.fromValue = @0;
    anim.toValue = @1;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    [_navigationView.messageBtn.layer addAnimation:anim forKey:nil];
    
}
- (void)goSearchPage{
    _navigationView.searchView.frame = ({
        CGRect frame = _navigationView.searchView.frame;
        frame.origin.x -= 40.f;
        frame.size.width += 40.f;
        frame;
    });
    
    _navigationView.audioBtn.frame = ({
        CGRect frame = _navigationView.audioBtn.frame;
        frame.origin.x = _navigationView.gs_width - 20.f;
        frame;
    });
    
    GSJDSearchMainVC *searchVC = [[GSJDSearchMainVC alloc] init];
    [self addChildViewController:searchVC];
    [self.view addSubview:searchVC.view];
    
}
@end
