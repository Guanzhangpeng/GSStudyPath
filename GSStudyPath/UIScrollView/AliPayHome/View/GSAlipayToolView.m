//
//  GSAlipayToolView.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/9/20.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSAlipayToolView.h"
#pragma mark --GSItemModel
@implementation GSItemModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)ItemWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end


#pragma mark --GSToolButton
@interface GSToolButton()
@property (nonatomic, strong) GSToolViewStyle *style;
@end
@implementation GSToolButton
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
-(instancetype)initWithStyle:(GSToolViewStyle *)style{
    if (self = [super init]){
        self.style = style;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.style.isHaveTitle) {
        CGFloat imageW = self.style.imageSize.width ;
        CGFloat imageH = self.style.imageSize.height;
        CGFloat imageX = (self.frame.size.width - imageW) / 2;
        self.imageView.frame = CGRectMake(imageX, 0.f, imageW, imageH);
        CGFloat titleY = imageH + self.style.titleMargin;
        self.titleLabel.frame = CGRectMake(0, titleY, self.frame.size.width, 15.0f);
    }else{
        self.imageView.frame = self.bounds;
        self.titleLabel.frame = CGRectZero;
    }
    
}
-(void)setItemModel:(GSItemModel *)itemModel{
    _itemModel = itemModel;
    [self setImage:[UIImage imageNamed:itemModel.image] forState:UIControlStateNormal];
    [self setTitle:itemModel.title forState:UIControlStateNormal];
}

@end

#pragma mark --GSToolViewStyle
@implementation GSToolViewStyle

- (instancetype)init
{
    if (self = [super init]) {
        self.column = 4;
        self.paddingleftAndRight = 15.f;
        self.paddingTop = 15.f;
        self.itemSize = CGSizeMake(50.f,80.f);
        
        self.titleMargin = 15.f;
        self.titleColor = [UIColor whiteColor];
        self.imageSize = CGSizeMake(50.f, 50.f);
        self.haveTitle = YES;//默认是有title的;
    }
    return self;
    
}
@end

#pragma mark --GSAlipayToolView
@interface GSAlipayToolView()
@property (nonatomic, strong) NSMutableArray<GSToolButton *> *toolButtonArray;
@property (nonatomic, strong) GSToolViewStyle *toolStyle;
@end
@implementation GSAlipayToolView


-(instancetype)initWithFrame:(CGRect)frame Style:(GSToolViewStyle *)style
{
    if (self = [super initWithFrame:frame]) {
       self.toolButtonArray = [[NSMutableArray alloc] init];
        self.toolStyle = style;
    }
    return self;
}


-(void)setToolItems:(NSArray<NSDictionary *> *)toolItems{
    _toolItems = toolItems;
    //字典转模型
    [toolItems enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
        GSItemModel *itemModel = [GSItemModel ItemWithDict:dic];
        GSToolButton *toolButton = [[GSToolButton alloc] initWithStyle:self.toolStyle];
        [toolButton setTitleColor:self.toolStyle.titleColor forState:UIControlStateNormal];
        toolButton.itemModel = itemModel;
        [toolButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:toolButton];
        [self.toolButtonArray addObject:toolButton];
    }];
}

-(void)layoutSubviews{
    [super layoutSubviews];
  
    CGFloat buttonW = self.toolStyle.itemSize.width;
    CGFloat buttonH = self.toolStyle.itemSize.height;
    
    CGFloat buttonX = self.toolStyle.paddingleftAndRight;
    CGFloat buttonY = self.toolStyle.paddingTop;
    CGFloat margin = (self.frame.size.width - self.toolStyle.paddingleftAndRight *2 - buttonW * self.toolStyle.column )/(self.toolStyle.column -1);
  
    for (int i = 0; i<self.toolButtonArray.count; i++) {
        GSToolButton *toolButton = self.toolButtonArray[i];
        NSInteger rowNumber = i / self.toolStyle.column;
        NSInteger columnNumber = i % self.toolStyle.column;
        buttonX = self.toolStyle.paddingleftAndRight + columnNumber * (buttonW + margin);
        buttonY = self.toolStyle.paddingTop + rowNumber * (buttonH +self.toolStyle.paddingTop);
        toolButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}
-(void)buttonAction:(GSToolButton *)button{
    if (self.toolItemAction) {
        self.toolItemAction(button.itemModel);
    }
}
@end


