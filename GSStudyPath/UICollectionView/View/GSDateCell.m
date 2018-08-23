//
//  GSDateCell.m
//  UICollectionViewLayout
//
//  Created by 管章鹏 on 2018/7/5.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSDateCell.h"

@interface GSDateCell()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end
@implementation GSDateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDateStr:(NSString *)dateStr{
    _dateStr = [dateStr copy];
    self.dateLabel.text = dateStr;
}

@end
