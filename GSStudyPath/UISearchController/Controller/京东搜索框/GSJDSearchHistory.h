//
//  GSJDSearchHistory.h
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/25.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface GSJDSearchHistory : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *historyData;
@property (nonatomic, strong) void(^scrollAction)(void);
@property (nonatomic, strong) void(^hotBtnAction)(NSString *);

@end
