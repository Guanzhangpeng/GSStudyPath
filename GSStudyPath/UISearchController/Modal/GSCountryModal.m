
//
//  GSCountryModal.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/22.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSCountryModal.h"

@implementation GSCountryModal
static GSCountryModal *__countryModal;
+(instancetype)sharedDataModal{
    return __countryModal;
}

+(void)initialize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!__countryModal) {
            __countryModal = [[GSCountryModal alloc] init];
        }
    });
}

-(instancetype)init{
    if (!__countryModal) {
        if ( self = [super init]) {
            
            //加载数据
            NSString *path = [[NSBundle mainBundle] pathForResource:@"country" ofType:@"txt"];
            NSString *countryStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            _dataArray = [countryStr componentsSeparatedByString:@"\n"];
        }
    }
    return self;
}
@end
