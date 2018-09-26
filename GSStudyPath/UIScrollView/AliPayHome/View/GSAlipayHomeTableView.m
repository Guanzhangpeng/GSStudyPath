//
//  GSAlipayHomeTableView.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/9/20.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSAlipayHomeTableView.h"
#import "MJRefresh.h"
#import "GSAlipayHomeCell.h"
@interface GSAlipayHomeTableView()<UITableViewDataSource>{
    NSInteger _numberRows;
}

@end
@implementation GSAlipayHomeTableView
static NSString *const cellID = @"AlipayHomeCell";
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        _numberRows = 5;
        self.dataSource = self;
        self.scrollEnabled = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[GSAlipayHomeCell class] forCellReuseIdentifier:cellID];
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return self;
}
-(void)loadNewData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mj_header endRefreshing];
        [self reloadData];
    });
}
-(void)loadMoreData{
    _numberRows += 5;
   [self reloadData];
    if (self.contentSizeAction) {
        self.contentSizeAction(self.contentSize);
    }
}

-(void)setContentOffsetY:(CGFloat)contentOffsetY{
    if (![self.mj_header isRefreshing]) {
        self.contentOffset = CGPointMake(0.f, contentOffsetY);
    }
}
#pragma mark -- tableView dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _numberRows;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GSAlipayHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    return cell;
}
@end
