//
//  GSAlipayToolView.h
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/9/20.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface GSItemModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ItemWithDict: (NSDictionary *)dict;

@end


@class GSItemModel;
@interface GSToolButton : UIButton
@property (nonatomic, strong) GSItemModel *itemModel;
@property (nonatomic, assign) CGSize imageSize;
@end


@interface GSToolViewStyle : NSObject
/*GSAlipayToolView 属性**/
@property (nonatomic, assign) CGFloat paddingleftAndRight;
@property (nonatomic, assign) CGFloat paddingTop;
@property (nonatomic, assign) NSInteger column;
@property (nonatomic, assign) CGSize itemSize;

/* 属性**/
@property (nonatomic, assign) CGFloat titleMargin;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign, getter=isHaveTitle) BOOL haveTitle;
@end

@interface GSAlipayToolView : UIView
@property (nonatomic, strong) NSArray <NSDictionary *> *toolItems;
@property (nonatomic, strong) void(^toolItemAction)(GSItemModel *);
- (instancetype)initWithFrame:(CGRect)frame Style:(GSToolViewStyle *)style;
@end
