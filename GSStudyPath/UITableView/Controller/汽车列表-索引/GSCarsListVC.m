//
//  GSCarsListVC.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/28.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSCarsListVC.h"
#import "GSCarModal.h"
#import "GSCarsGroup.h"

@interface GSCarsListVC ()
@property (nonatomic, strong) NSArray<GSCarsGroup *> *dataArray;
@end

@implementation GSCarsListVC

static NSString *const cellID = @"cellID";
#pragma mark getter method
-(NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = [GSCarsGroup carsGroup];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"汽车列表";
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GSCarsGroup *carsGroup = self.dataArray[section];
    return carsGroup.cars.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    GSCarsGroup *carsGroup = self.dataArray[indexPath.section];
    GSCarModal *carModal = carsGroup.cars[indexPath.row];
    cell.textLabel.text = carModal.name;
    
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    GSCarsGroup *carsGroup = self.dataArray[section];
    return carsGroup.title;
}
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
//    NSMutableArray *arrayM = [NSMutableArray array];
//    for (int i=0; i<self.dataArray.count; i++) {
//        [arrayM addObject:self.dataArray[i].title];
//    }
//    return arrayM;
    
    //KVC取值的对象是一个数组，同样返回一个数组
    return [self.dataArray valueForKeyPath:@"title"];
}
@end
