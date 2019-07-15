//
//  ReusableVC.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2019/7/15.
//  Copyright © 2019 管章鹏. All rights reserved.
//

#import "ReusableVC.h"
#import "IndexedTableView.h"
#import "UIColor+Utils.h"
@interface ReusableVC ()<UITableViewDelegate,UITableViewDataSource,IndexedTableViewDataSource>{
    IndexedTableView *indexedTabelView;//带索引条的tableView
    UIButton *reloadButton;
    NSMutableArray *dataSource;
}

@end

@implementation ReusableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}
- (void)setupUI{
    indexedTabelView = [[IndexedTableView alloc] initWithFrame:CGRectMake(0, 88 + 40, SCREEN_WIDTH, SCREEN_HEIGHT - UPHEIGHT - 40) style:UITableViewStylePlain];
    indexedTabelView.dataSource = self;
    indexedTabelView.delegate = self;
    indexedTabelView.indexedDataSource  = self;
    [self.view addSubview:indexedTabelView];
    
    reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reloadButton.frame = CGRectMake(0, 88, SCREEN_WIDTH, 40);
    reloadButton.backgroundColor = [UIColor colorWithRGB:0xF1831E];
    [reloadButton setTitle:@"刷新" forState:UIControlStateNormal];
    [reloadButton addTarget:self action:@selector(reloadAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reloadButton];
    
    dataSource = [NSMutableArray array];
    for (int i = 1; i<= 100; i++) {
        [dataSource addObject:@(i)];
    }
}
#pragma mark IndexedTableViewDataSource
-(NSArray<NSString *> *)indexTitlesForIndexdTableView:(UITableView *)tableView{
    //奇数次调用返回6个字母，偶数次调用返回11个
    static BOOL change = NO;
    
    if (change) {
        change = NO;
        return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K"];
    }
    else{
        change = YES;
        return @[@"A",@"B",@"C",@"D",@"E",@"F"];
    }
}
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"reuseId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //如果重用池当中没有可重用的cell，那么创建一个cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    // 文案设置
    cell.textLabel.text = [[dataSource objectAtIndex:indexPath.row] stringValue];
    
    //返回一个cell
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)reloadAction{
    NSLog(@"reloadData");
    [indexedTabelView reloadData];
}
@end
