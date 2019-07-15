//
//  IndexedTableView.h
//  GSStudyPath
//
//  Created by 管章鹏 on 2019/7/15.
//  Copyright © 2019 管章鹏. All rights reserved.
//
//带索引条的tableView
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IndexedTableViewDataSource <NSObject>

@required
- (NSArray<NSString *>*)indexTitlesForIndexdTableView:(UITableView *)tableView;


@end
@interface IndexedTableView : UITableView
@property (nonatomic, weak) id<IndexedTableViewDataSource> indexedDataSource;
@end

NS_ASSUME_NONNULL_END
