
//
//  GSJDSearchHistory.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/25.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSJDSearchHistory.h"

@implementation GSJDSearchHistory
static NSString *const cellID = @"cellID";
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    }
    return self;
}

#pragma mark -- UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!_historyData.count) {
        return 1;
    }
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.historyData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    //热搜
    if (indexPath.section == 0 && indexPath.row == 0) {
        if(!self.historyData.count){
            [self createHotSearchHistory:cell hasHistory:NO];
        }else{
            [self createHotSearchHistory:cell hasHistory:YES];
        }
    }
    //历史搜索
    else{
        if(indexPath.row == 0){
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont systemFontOfSize:16.f];
        }else{
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        }
       
        cell.textLabel.text = self.historyData[indexPath.row];
    }
    return cell;
}
#pragma mark -- UITableViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollAction) {
        self.scrollAction();
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (!self.historyData.count) {
            return 250;
        }
        return 80;
    }
    else if(indexPath.section == 1 && indexPath.row > 1){
        return 44;
    }
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section !=0 && self.hotBtnAction  ) {
        self.hotBtnAction(self.historyData[indexPath.row]);
    }
}
- (void)createHotSearchHistory:(UITableViewCell *)cell hasHistory:(BOOL)hasHistory{
    
    //创建热门搜索记录
    UIView *hotSearchView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREENSIZE.width, 80.f)];
    hotSearchView.backgroundColor = [UIColor clearColor];
    [cell addSubview:hotSearchView];
    
    UILabel *hotTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 0.f, 100.f, 30.f)];
    hotTitleLabel.text = @"热搜";
    hotTitleLabel.backgroundColor = [UIColor clearColor];
    hotTitleLabel.font = [UIFont systemFontOfSize:15.f];
    [hotSearchView addSubview:hotTitleLabel];
    
    //热搜词汇数组
    NSArray *hotSearchWords = @[@"美特斯邦威", @"黄尾袋鼠", @"孕妇袜", @"广角镜头手机", @"唇彩唇蜜", @"汽车坐垫", @"应急启动电源", @"钢笔", @"鼠标垫护腕", @"不粘锅煎锅", @"橄榄调和油", @"铝框拉杆箱"];
    
    if (hasHistory) {
        UIScrollView *hotSearchScrollView = [[ UIScrollView alloc] initWithFrame:CGRectMake(0.f, 30.f, SCREENSIZE.width, 50.f)];
        hotSearchScrollView.showsHorizontalScrollIndicator = NO;
        hotSearchScrollView.showsVerticalScrollIndicator = NO;
        [hotSearchView addSubview:hotSearchScrollView];
        CGFloat xCoordinate = 15.f;
        for (int i=0; i<hotSearchWords.count; i++) {
            NSString *hotWords = hotSearchWords[i];
            CGSize hotWordSize = [hotWords sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]}];
            UIButton *hotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            hotBtn.frame = CGRectMake(xCoordinate, 10.f, hotWordSize.width + 20.f, 30.f);
            hotBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
            hotBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [hotBtn setTitle:hotWords forState:UIControlStateNormal];
            [hotBtn addTarget:self action:@selector(hotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [hotSearchScrollView addSubview:hotBtn];
            xCoordinate = CGRectGetMaxX(hotBtn.frame) + 15.f;
            hotBtn.layer.cornerRadius = 6.0f;
            hotBtn.layer.masksToBounds = YES;
            hotBtn.backgroundColor = [UIColor grayColor];
        }
        hotSearchScrollView.contentSize = CGSizeMake(xCoordinate, 0.f);
    }else{
        CGFloat yCoordinate = 40.f;
        CGFloat xCoordinate = 15.f;
        for (int i=0; i<hotSearchWords.count; i++) {
            NSString *hotWords = hotSearchWords[i];
            CGSize hotWordSize = [hotWords sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]}];
            if (xCoordinate + hotWordSize.width + 15 > SCREENSIZE.width) {
                xCoordinate = 15.f;
                yCoordinate += 45.f;
            }
            UIButton *hotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            hotBtn.frame = CGRectMake(xCoordinate, yCoordinate, hotWordSize.width + 20.f, 30.f);
            hotBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
            hotBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [hotBtn setTitle:hotWords forState:UIControlStateNormal];
            [hotSearchView addSubview:hotBtn];
            
            xCoordinate = CGRectGetMaxX(hotBtn.frame) + 15.f;
            hotBtn.layer.cornerRadius = 6.0f;
            hotBtn.layer.masksToBounds = YES;
            hotBtn.backgroundColor = [UIColor grayColor];
        }
        hotSearchView.gs_height = yCoordinate + 45.f;
    }
}

#pragma mark action
- (void)hotBtnAction:(UIButton *)hotBtn{
    if (self.hotBtnAction) {
        
        self.hotBtnAction(hotBtn.titleLabel.text);
    }
}
@end
