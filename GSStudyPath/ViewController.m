//
//  ViewController.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/22.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "ViewController.h"
#import "GSNormalSearchVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    GSNormalSearchVC *vc = [[GSNormalSearchVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
