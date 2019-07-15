//
//  IndexedTableView.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2019/7/15.
//  Copyright © 2019 管章鹏. All rights reserved.
//

#import "IndexedTableView.h"
#import "ReusePool.h"
@interface IndexedTableView(){
    ReusePool *reusePool;
    UIView *containView;
}
@end
@implementation IndexedTableView

-(void)reloadData{
    [super reloadData];
    if (reusePool == nil) {
        reusePool = [[ReusePool alloc] init];
    }
    if (containView == nil) {
        containView = [[UIView alloc] init];
        containView.backgroundColor = [UIColor whiteColor];
        
        //避免跟随tableView的滚动而滚动
        [self.superview insertSubview:containView aboveSubview:self];
    }
    
    //标记所有视图为可重用状态
    [reusePool reset];
    
    //刷新索引条
    [self reloadIndexedBar];
}
- (void)reloadIndexedBar{
    //字母索引条的存放内容
    NSArray<NSString *> *indexTitles = nil;
    if ([self.indexedDataSource respondsToSelector:@selector(indexTitlesForIndexdTableView:)]) {
        indexTitles = [self.indexedDataSource indexTitlesForIndexdTableView:self];
    }
    
    //判断字母索引条是否为空
    if(!indexTitles || indexTitles.count == 0){
        [containView setHidden:YES];
        return;
    }
    NSUInteger count = indexTitles.count;
    CGFloat buttonW = 60;
    CGFloat buttonH = self.frame.size.height / count;
    for (int i = 0; i<count; i++) {
        NSString *title = indexTitles[i];
        
        //从重用池中获取一个button
        UIButton *btn = (UIButton *)[reusePool dequeueReusabelView];
        if (btn == nil) {
            btn = [[UIButton alloc] init];
            btn.backgroundColor = [UIColor whiteColor];
            
            //添加到重用池中
            [reusePool addUsingView:btn];
            NSLog(@"创建Button");
        }else{
            NSLog(@"重用Button");
        }
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, i * buttonH, buttonW, buttonH);
        [containView addSubview:btn];
    }
    [containView setHidden:NO];
    containView.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - buttonW, self.frame.origin.y, buttonW, self.frame.size.height);
}
@end
