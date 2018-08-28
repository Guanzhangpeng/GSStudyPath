
//
//  GSAddressTableView.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/28.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSAddressTableView.h"
@interface GSAddressTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation GSAddressTableView
static NSString *const cellID = @"cellID";
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if(self = [super initWithFrame:frame style:style]){
        self.dataSource = self;
        self.delegate   = self;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    }
    return self;
}

#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cityArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = self.cityArr[indexPath.row];
    return cell;
}
@end
