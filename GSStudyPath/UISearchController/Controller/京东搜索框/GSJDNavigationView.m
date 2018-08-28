//
//  GSJDNavigationView.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/24.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSJDNavigationView.h"
#import "Masonry.h"

@implementation GSJDNavigationView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setNavigationView];
    }
    return self;
}
- (void)setNavigationView{
    //扫一扫按钮
    _scanBtn = [GSJDButton buttonWithType:UIButtonTypeCustom];
    [_scanBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [_scanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_scanBtn setImage:[UIImage imageNamed:@"scan_white"] forState:UIControlStateNormal];
    [_scanBtn addTarget:self action:@selector(scanAction) forControlEvents:UIControlEventTouchUpInside];
    _scanBtn.frame = CGRectMake(10.f, 7.f, 30.f, 33.f);
    [self addSubview:_scanBtn];
    
    //搜索框
    _searchView = [[UIImageView alloc] initWithFrame:CGRectMake(50.f, 8.f, SCREENSIZE.width - 100.f, 28.f)];
    _searchView.userInteractionEnabled = YES;
    UIImage *searchImg = [UIImage imageNamed:@"searchBar_white"];
    searchImg = [searchImg stretchableImageWithLeftCapWidth:30.f topCapHeight:0.f];
    _searchView.image = searchImg;
     [self addSubview:_searchView];
    UITapGestureRecognizer *searchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAction)];
    [_searchView addGestureRecognizer:searchTap];
    
    //创建label
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.f, 0.f, _searchView.gs_width - 30.f, _searchView.gs_height)];
    textLabel.text = @"京东超级品牌日";
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:14.f];
    textLabel.textAlignment = NSTextAlignmentLeft;
    [_searchView addSubview:textLabel];
    
    //语音按钮
    _audioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *audioImg = [UIImage imageNamed:@"voice_white"];
    CGFloat audioBtnWidth = 12.f;
    CGFloat audioBtnHeight = audioImg.size.height * audioImg.size.width / audioBtnWidth;
    _audioBtn.frame = CGRectMake(_searchView.gs_width - 20.f, (_searchView.gs_height - audioBtnHeight)/2, audioBtnWidth, audioBtnHeight);
    [_audioBtn setBackgroundImage:audioImg forState:UIControlStateNormal];
    [_audioBtn addTarget:self action:@selector(audioAction) forControlEvents:UIControlEventTouchUpInside];
    [_searchView addSubview:_audioBtn];
    
    //消息按钮
    _messageBtn = [GSJDButton buttonWithType:UIButtonTypeCustom];
    [_messageBtn setTitle:@"消息" forState:UIControlStateNormal];
    [_messageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_messageBtn setImage:[UIImage imageNamed:@"message_white"] forState:UIControlStateNormal];
    [_messageBtn addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
    _messageBtn.frame = CGRectMake(SCREENSIZE.width - 40.f, 7.f, 30.f, 33.f);
    [self addSubview:_messageBtn];

}

#pragma mark --action
- (void)scanAction{
    if (self.scanActionBlock) {
        self.scanActionBlock();
    }
}

- (void)searchAction{
    if (self.searchActionBlock) {
        self.searchActionBlock();
    }
}
- (void)audioAction{
    if (self.audioActionBlock) {
        self.audioActionBlock();
    }
}
- (void)messageAction{
    if (self.messageActionBlock) {
        self.messageActionBlock();
    }
}
@end
