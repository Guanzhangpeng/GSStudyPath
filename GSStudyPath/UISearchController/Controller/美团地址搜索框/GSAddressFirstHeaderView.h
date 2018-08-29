//
//  GSAddressFirstHeaderView.h
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/29.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol headerViewDelegate <NSObject>
@required
- (void)citySelectAction:(BOOL)isSelect;
@end
@interface GSAddressFirstHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<headerViewDelegate> delegate;
@end
