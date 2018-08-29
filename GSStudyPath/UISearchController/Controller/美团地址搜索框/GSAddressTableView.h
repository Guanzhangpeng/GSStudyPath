//
//  GSAddressTableView.h
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/28.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GSAddressTableView : UITableView
@property (nonatomic, strong) NSMutableDictionary *cityDataDict;
@property (nonatomic, strong) NSArray      *cityArr;
@property (nonatomic, strong) void(^selectCityAction)(NSString *city);
@end
