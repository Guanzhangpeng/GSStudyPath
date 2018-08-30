//
//  AppDelegate.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/22.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "AppDelegate.h"
#import "GSTabBarController.h"
#import "GSIntroductionView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[GSTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    
    [GSIntroductionView sharedWithImages:@[@"user_guid1",@"user_guid2",@"user_guid3"]];
    
    return YES;
}
@end
