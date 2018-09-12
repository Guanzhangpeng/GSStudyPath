//
//  GSExtensibleTableHeader.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/9/11.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSExtensibleTableHeader.h"
#import "GSCustomNavBar.h"
@interface GSExtensibleTableHeader ()<UITableViewDelegate,UITableViewDataSource>{
    UIImageView *bgView;
    CGRect originalFrame;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GSCustomNavBar *customNavBar;
@end

@implementation GSExtensibleTableHeader
static const CGFloat headHeight = 200.0f;
static NSString *const cellID = @"cellID";

#pragma mark --getter method
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREENSIZE.width, SCREENSIZE.height ) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREENSIZE.width, headHeight)];
        headerView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = headerView;
    }
    return _tableView;
}
-(GSCustomNavBar *)customNavBar{
    if (!_customNavBar) {
        _customNavBar = [[GSCustomNavBar alloc] init];
        _customNavBar.backgroundColor = [UIColor clearColor];
        _customNavBar.titleColor = [UIColor whiteColor];
        _customNavBar.title = @"可拉伸头部控件";
        _customNavBar.leftImage = @"nav_back";
        _customNavBar.rightImage = @"navigationbar_pop_highlighted";
        
        __weak typeof(self) weakSelf = self;
        _customNavBar.leftBtnAction = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _customNavBar;
}
#pragma mark --system method
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
     [self.view addSubview:self.tableView];
     [self setupHeaderImg];
    [self.view addSubview:self.customNavBar];
   
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   [self.navigationController setNavigationBarHidden:YES animated:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)setupHeaderImg{
    bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREENSIZE.width, headHeight)];
    bgView.image = [UIImage imageNamed:@"10"];
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    bgView.clipsToBounds = YES;
    originalFrame = bgView.frame;
    [self.view addSubview:bgView];
}
#pragma mark --tableView dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第 %ld 行",indexPath.row];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset=scrollView.contentOffset.y;//向上滑动，offset是增加的，向下滑动，offset是减少的。
    if (yOffset < headHeight) {//当滑动到导航栏底部之前
        CGFloat colorAlpha = yOffset/headHeight;//0-1
        self.customNavBar.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:colorAlpha];
        _customNavBar.leftImage = @"nav_back";
        _customNavBar.rightImage = @"navigationbar_pop_highlighted";
        self.customNavBar.titleColor = [UIColor orangeColor];
    }else
    {
        self.customNavBar.backgroundColor=[UIColor whiteColor];
        _customNavBar.leftImage = @"tabbar_compose_background_icon_return";
        _customNavBar.rightImage = @"navigationbar_pop";
        self.customNavBar.titleColor = [UIColor darkGrayColor];
    }
    
    //向上移动效果，处理放大效果
    if (yOffset>0) {
        bgView.frame=({
            CGRect frame=originalFrame;
            frame.origin.y=originalFrame.origin.y-yOffset;
            frame;
        });
    }else
    {
        bgView.frame=({
            CGRect frame=originalFrame;
            frame.size.height=originalFrame.size.height-yOffset;
            frame.size.width = frame.size.height*(originalFrame.size.width/originalFrame.size.height);
            frame.origin.x=originalFrame.origin.x-(frame.size.width-originalFrame.size.width)/2;
            frame;
        });
    }
}
@end
