//
//  GSAlipayHomeVC2.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/9/26.
//  Copyright © 2018年 管章鹏. All rights reserved.
//
#define ToolViewH    (140)
#define GridViewH   (240)
#import "GSAlipayHomeVC2.h"
#import "GSAlipayHomeTableView.h"
#import "GSAlipayToolView.h"
#import "MJRefresh.h"
@interface GSAlipayHomeVC2 ()<UITableViewDelegate>{
    CGFloat _topOffsetY;
    CGFloat _laseContentOffsetY;
}

@property (nonatomic, strong) GSAlipayHomeTableView *tableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *headToolView;
@property (nonatomic, strong) UIView *headGridView;

@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UIView *mainNavView;
@property (nonatomic,strong) UIView *coverNavView;
@end

@implementation GSAlipayHomeVC2
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
    // Do any additional setup after loading the view.
    _topOffsetY = ToolViewH + GridViewH;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.mainNavView];
    [self.view addSubview:self.coverNavView];
    
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.headView];
    [self.headView addSubview:self.headToolView];
    [self.headView addSubview:self.headGridView];
}
#pragma mark -- scrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _laseContentOffsetY = scrollView.contentOffset.y;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY <= -_topOffsetY) {
        self.headView.frame = CGRectMake(0.f, offsetY, SCREEN_WIDTH, _topOffsetY);
        
        CGRect newFrame = self.headToolView.frame;
        newFrame.origin.y = 0;
        self.headToolView.frame = newFrame;
    }else  if(offsetY < -GridViewH ) {
        offsetY = _topOffsetY + offsetY;
        CGRect newFrame = self.headToolView.frame;
        newFrame.origin.y = offsetY/2;
        self.headToolView.frame = newFrame;
        //处理透明度
        CGFloat alpha = (1 - offsetY/ToolViewH*1.5 ) > 0 ? (1 - offsetY/ToolViewH*1.5 ) : 0;
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
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat tableViewOffsetY = scrollView.contentOffset.y;
    
    if (tableViewOffsetY < -(GridViewH + ToolViewH) || tableViewOffsetY > -GridViewH) {
        return;
    }
    
    if (tableViewOffsetY > _laseContentOffsetY) {
        // 向上滑
        if (tableViewOffsetY > -(GridViewH + ToolViewH) + 30) {
            [self.tableView setContentOffset:CGPointMake(0, -GridViewH) animated:YES];
        } else {
            [self.tableView setContentOffset:CGPointMake(0, -(GridViewH + ToolViewH)) animated:YES];
        }
    } else {
        // 向下滑
        if (tableViewOffsetY < -GridViewH - 30) {
            [self.tableView setContentOffset:CGPointMake(0, -(GridViewH + ToolViewH)) animated:YES];
        } else {
            [self.tableView setContentOffset:CGPointMake(0, -GridViewH) animated:YES];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat tableViewOffsetY = scrollView.contentOffset.y;
    
    if (tableViewOffsetY < -(GridViewH + ToolViewH) || tableViewOffsetY > -GridViewH) {
        return;
    }
    
    if (tableViewOffsetY > _laseContentOffsetY) {
        // 向上滑
        if (tableViewOffsetY > -(GridViewH + ToolViewH) + 20) {
            [self.tableView setContentOffset:CGPointMake(0, -GridViewH) animated:YES];
        } else {
            [self.tableView setContentOffset:CGPointMake(0, -(GridViewH + ToolViewH)) animated:YES];
        }
    } else {
        // 向下滑
        if (tableViewOffsetY < -GridViewH - 20) {
            [self.tableView setContentOffset:CGPointMake(0, -(GridViewH + ToolViewH)) animated:YES];
        } else {
            [self.tableView setContentOffset:CGPointMake(0, -GridViewH) animated:YES];
        }
    }
}


#pragma mark -- getter method
-(GSAlipayHomeTableView *)tableView{
    if (!_tableView) {
        _tableView = [[GSAlipayHomeTableView alloc] initWithFrame:CGRectMake(0.f, Height_TopBar, SCREEN_WIDTH, SCREEN_HEIGHT - Height_TopBar) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake((ToolViewH + GridViewH), 0, 0, 0);
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake((GridViewH + GridViewH), 0, 0, 0);
    }
    return _tableView;
}
-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0.f, -_topOffsetY, SCREENSIZE.width, _topOffsetY)];
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
