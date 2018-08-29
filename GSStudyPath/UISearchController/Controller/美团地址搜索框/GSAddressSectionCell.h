//
//  GSAddressSectionCell.h
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/29.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^btnActionBlock) (NSString *cityString);

@interface GSAddressSectionCell : UITableViewCell
@property (nonatomic, strong) btnActionBlock btnBlock;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cityArr:(NSArray *)cityArr;

@end
