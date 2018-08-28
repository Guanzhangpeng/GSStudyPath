//
//  GSJDSearchVC.h
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/25.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSJDSearchBar.h"
@class GSJDSearchVC;
@protocol GSSearchControllerDelegate <NSObject>
@optional

- (void)didPresentSearchController:(GSJDSearchVC *)searchController;
- (void)didDismissSearchController:(GSJDSearchVC *)searchController;

@end

@protocol GSSearchResultsUpdating <NSObject>
@required
// Called when the search bar's text or scope has changed or when the search bar becomes first responder.
- (void)updateSearchResultsForSearchController:(GSJDSearchVC *)searchController;
@end
@interface GSJDSearchVC : UIViewController

@property (nullable, nonatomic, weak) id <GSSearchResultsUpdating> searchResultsUpdater;
@property (nullable, nonatomic, weak) id <GSSearchControllerDelegate> delegate;
@property (nonatomic, strong, readonly) GSJDSearchBar *searchBar;
@property (nullable, nonatomic, strong, readonly) UIViewController *searchResultsController;

- (instancetype)initWithSearchResultsController:(nullable UIViewController *)searchResultsController;
@end
