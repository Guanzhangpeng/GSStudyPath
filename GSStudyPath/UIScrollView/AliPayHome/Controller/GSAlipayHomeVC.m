//
//  GSAlipayHomeVC.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/9/20.
//  Copyright © 2018年 管章鹏. All rights reserved.
//
#define ToolViewH    (140)
#define GridViewH   (240)
#import "GSAlipayHomeVC.h"
#import "GSAlipayHomeTableView.h"
#import "GSAlipayToolView.h"
#import "MJRefresh.h"
@interface GSAlipayHomeVC ()<UIScrollViewDelegate>{
    CGFloat _topOffsetY;
}

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) GSAlipayHomeTableView *tableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *headToolView;
@property (nonatomic, strong) UIView *headGridView;

@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UIView *mainNavView;
@property (nonatomic,strong) UIView *coverNavView;

@end

@implementation GSAlipayHomeVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _topOffsetY = ToolViewH + GridViewH;
    
    [self.view addSubview:self.mainScrollView];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.mainNavView];
    [self.view addSubview:self.coverNavView];
    
    [self.mainScrollView addSubview:self.headView];
    [self.headView addSubview:self.headToolView];
    [self.headView addSubview:self.headGridView];
    [self.mainScrollView addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    self.tableView.contentSizeAction = ^(CGSize contentSize) {
        [weakSelf updateContentSize:contentSize];
    };
    _mainScrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateContentSize:self.tableView.contentSize];
}
-(void)updateContentSize:(CGSize)size{
    CGSize contentSize = size;
    contentSize.height = size.height + _topOffsetY;
    self.mainScrollView.contentSize = contentSize;
    
    CGRect newFrame = self.tableView.frame;
    newFrame.size.height = size.height;
    self.tableView.frame = newFrame;
}
#pragma mark -- scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY <= 0) {
        self.headView.frame = CGRectMake(0.f, offsetY, SCREENSIZE.width, _topOffsetY) ;
        self.tableView.frame = CGRectMake(0.f, offsetY + _topOffsetY, SCREENSIZE.width, self.tableView.gs_height);
        self.tableView.contentOffsetY = offsetY;
        
        
        CGRect newFrame = self.headToolView.frame;
        newFrame.origin.y = 0;
        self.headToolView.frame = newFrame;
        
        
    }else  if(offsetY < ToolViewH && offsetY > 0) {
        CGRect newFrame = self.headToolView.frame;
        newFrame.origin.y = offsetY/2;
        self.headToolView.frame = newFrame;
        
        //处理透明度
        CGFloat alpha = (1 - offsetY/ToolViewH*2.5 ) > 0 ? (1 - offsetY/ToolViewH*2.5 ) : 0;
        self.headToolView.alpha = alpha;
        if (alpha > 0.5) {
            CGFloat newAlpha = alpha * 2 - 1;
            _mainNavView.alpha = newAlpha;
            _coverNavView.alpha = 0;
        }else {
            CGFloat newAlpha = alpha * 2;
            _mainNavView.alpha = 0;
            _coverNavView.alpha = 1 - newAlpha;
        }
    }
}


-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < -65) {
        [self.tableView.mj_header beginRefreshing];
    }else if(offsetY >0 && offsetY < ToolViewH){
        [self toolViewAnimateWithOffsetY:offsetY];
    }
}
- (void)toolViewAnimateWithOffsetY:(CGFloat)offsetY{
    if (offsetY >= ToolViewH / 2) {
        [self.mainScrollView setContentOffset:CGPointMake(0.f, ToolViewH) animated:YES];
    }else{
        [self.mainScrollView setContentOffset:CGPointMake(0.f, 0.f) animated:YES];
    }
}
-(void)loadMoreData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView loadMoreData];
         [self.mainScrollView.mj_footer endRefreshing];
    });
}
#pragma mark -- getter method
-(UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 64.f, SCREENSIZE.width, SCREENSIZE.height - 64.f)];
        _mainScrollView.delegate = self;
        _mainScrollView.scrollIndicatorInsets = UIEdgeInsetsMake(_topOffsetY, 0.f, 0.f, 0.f);
        
    }
    return _mainScrollView;
}
-(GSAlipayHomeTableView *)tableView{
    if (!_tableView) {
        _tableView = [[GSAlipayHomeTableView alloc] initWithFrame:CGRectMake(0.f, _topOffsetY, SCREENSIZE.width, SCREENSIZE.height  - _topOffsetY) style:UITableViewStylePlain];
        
    }
    return _tableView;
}
-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREENSIZE.width, _topOffsetY)];
        _headView.backgroundColor = [UIColor colorWithRed:27 / 255.0 green:130 / 255.0 blue:209 / 255.0 alpha:1];
    }
    return _headView;
}
-(UIView *)headToolView{
    if (!_headToolView) {
        GSToolViewStyle *style = [[GSToolViewStyle alloc] init];
        style.itemSize = CGSizeMake(50.f, 80.f);
        style.titleMargin = 15.f;
        style.paddingTop = 30.f;
        style.titleColor = [UIColor whiteColor];
        
        GSAlipayToolView *toolView = [[GSAlipayToolView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREENSIZE.width, ToolViewH) Style:style];
        toolView.toolItems = @[
                               @{
                                   @"image":@"homeBarIcon0",
                                   @"title":@"扫一扫"
                                   },
                               @{
                                   @"image":@"homeBarIcon1",
                                   @"title":@"付款"
                                   },
                               @{
                                   @"image":@"homeBarIcon2",
                                   @"title":@"收款码"
                                   },
                               @{
                                   @"image":@"homeBarIcon3",
                                   @"title":@"卡包"
                                   },
                               ];
        toolView.toolItemAction = ^(GSItemModel * itemModel) {
            NSLog(@"点击了: %@",itemModel.title);
        };
        toolView.backgroundColor =  [UIColor clearColor];
        _headToolView = toolView;
    }
    return _headToolView;
}
-(UIView *)headGridView{
    if (!_headGridView) {
        GSToolViewStyle *style = [[GSToolViewStyle alloc] init];
        style.titleColor = [UIColor darkGrayColor];
        style.imageSize = CGSizeMake(29.f, 29.f);
        style.itemSize = CGSizeMake(80.f, 60.f);
        style.titleMargin = 8.f;
        style.paddingTop = 15.f;
        GSAlipayToolView *gridView = [[GSAlipayToolView alloc] initWithFrame:CGRectMake(0.f, ToolViewH, SCREENSIZE.width, GridViewH) Style:style];
        gridView.toolItems = @[
                               @{
                                   @"image":@"i01",
                                   @"title":@"余额宝"
                                   },
                               @{
                                   @"image":@"i02",
                                   @"title":@"转账"
                                   },
                               @{
                                   @"image":@"i03",
                                   @"title":@"信用卡还贷"
                                   },
                               @{
                                   @"image":@"i04",
                                   @"title":@"电影票"
                                   },
                               @{
                                   @"image":@"i05",
                                   @"title":@"红包"
                                   },
                               @{
                                   @"image":@"i06",
                                   @"title":@"亲密付"
                                   },
                               @{
                                   @"image":@"i07",
                                   @"title":@"蚂蚁庄园"
                                   },
                               @{
                                   @"image":@"i08",
                                   @"title":@"火车票"
                                   },
                               @{
                                   @"image":@"i09",
                                   @"title":@"蚂蚁花呗"
                                   },
                               @{
                                   @"image":@"i10",
                                   @"title":@"蚂蚁森林"
                                   },
                               @{
                                   @"image":@"i11",
                                   @"title":@"更多"
                                   },
                               
                               ];
        gridView.toolItemAction = ^(GSItemModel * itemModel) {
            NSLog(@"点击了: %@",itemModel.title);
        };
        gridView.backgroundColor =  [UIColor whiteColor];
        _headGridView = gridView;
    }
    return _headGridView;
}


- (UIView *)navView{
    if (!_navView) {
        CGFloat yCoordinate = 64.f;
        if(KIsiPhoneX){
            yCoordinate = 88.f;
        }
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, yCoordinate)];
        _navView.backgroundColor = [UIColor colorWithRed:27 / 255.0 green:130 / 255.0 blue:209 / 255.0 alpha:1];
    }
    return _navView;
}

- (UIView *)mainNavView{
    if(!_mainNavView){
        CGFloat yCoordinate = Height_TopBar;
        CGFloat payButtonY = (Height_NavBar - 20.f)/2 + Height_StatusBar;
        _mainNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,  SCREENSIZE.width, yCoordinate)];
        _mainNavView.backgroundColor = [UIColor clearColor];
        
        UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [payButton setImage:[UIImage imageNamed:@"home_bill"] forState:UIControlStateNormal];
        [payButton setTitle:@"账单" forState:UIControlStateNormal];
        payButton.titleLabel.font = [UIFont systemFontOfSize:13];
        payButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        payButton.frame = CGRectMake(10.f, payButtonY, 60.f, 20.f);
        [_mainNavView addSubview:payButton];
    }
    return _mainNavView;
}

- (UIView *)coverNavView{
    if(!_coverNavView){
        GSToolViewStyle *style = [[GSToolViewStyle alloc] init];
        style.itemSize = CGSizeMake(27.f, 24.f);
        style.paddingTop = (Height_NavBar - 24.f)/2 + Height_StatusBar;
        style.haveTitle = NO;
        
        CGFloat yCoordinate = Height_TopBar;
        
        GSAlipayToolView *coverNavView = [[GSAlipayToolView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREENSIZE.width * 2/3, yCoordinate) Style:style];
        coverNavView.toolItems = @[
                               @{
                                   @"image":@"pay_mini",
                                   
                                   },
                               @{
                                   @"image":@"scan_mini",
                                   },
                               @{
                                   @"image":@"camera_mini",
                                   }
                               ];
        _coverNavView = coverNavView;
        _coverNavView.alpha = 0.0001f;
    }
    return _coverNavView;
}

@end
