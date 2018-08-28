//
//  GSJDSearchVC.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/25.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSJDSearchVC.h"


@interface GSJDSearchVC (){
    GSJDSearchBar *_searchBar;
    UIViewController *_searchResultsController;
}

@end

@implementation GSJDSearchVC

#pragma mark -- getter method
- (GSJDSearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[GSJDSearchBar alloc] init];
        [_searchBar addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    }
    return _searchBar;
}
- (void)textChange{
    if (self.searchBar.text.length == 1 && self.delegate) {
        [self.delegate didPresentSearchController:self];
    }
    if (self.searchBar.text.length == 0 && self.delegate) {
        [self.delegate didDismissSearchController:self];
    }
    
    if (self.searchResultsUpdater) {
        [self.searchResultsUpdater updateSearchResultsForSearchController:self];
    }
}
-(instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController{
    self = [super init];
    if (searchResultsController) {
        _searchResultsController = searchResultsController;
        CGFloat yCoordinate = 64.f;
        if (GS_iPhoneX) {
            yCoordinate = 88.f;
        }
        self.view.frame = CGRectMake(0.f, yCoordinate, SCREENSIZE.width, SCREENSIZE.height);
        [self addChildViewController:_searchResultsController];
        _searchResultsController.view.frame = self.view.bounds;
        [self.view addSubview:_searchResultsController.view];
    }
    return self;
}
@end
