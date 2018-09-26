//
//  GSAlipayHomeTableView.h
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/9/20.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSAlipayHomeTableView : UITableView

@property (nonatomic, strong) void(^contentSizeAction)(CGSize contentSize);
@property (nonatomic, assign) CGFloat contentOffsetY;
- (void)loadMoreData;
@end

