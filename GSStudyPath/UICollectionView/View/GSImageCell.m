//
//  GSImageCell.m
//  UICollectionViewLayout
//
//  Created by 管章鹏 on 2018/7/4.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSImageCell.h"

@interface GSImageCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
@implementation GSImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.layer.borderWidth = 3;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.cornerRadius = 3;
    self.imageView.clipsToBounds = YES;
}

- (void)setImage:(NSString *)image
{
    _image = [image copy];
    
    self.imageView.image = [UIImage imageNamed:image];
}

@end
