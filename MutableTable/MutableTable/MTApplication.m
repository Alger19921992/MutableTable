//
//  MTApplication.m
//  MutableTable
//
//  Created by pengzhu on 2017/7/10.
//  Copyright © 2017年 Alger. All rights reserved.
//

#import "MTApplication.h"

@implementation MTApplication

static MTApplication* _sharedInstance = nil;

+ (MTApplication*) sharedApplication
{
    @synchronized([MTApplication class])
    {
        if(!_sharedInstance)
            _sharedInstance = [[self alloc]init];
        return _sharedInstance;
    }
    return nil;
}

- (void) postWithRequest:(MTRequest *)request onSuccess:(void (^)(MTResponse *))success onFailure:(void (^)())failure{
    int value = arc4random() % 10;
    if (value < 4) {
        MTResponse *response = [[MTResponse alloc] init];
        MTModel *data = [[MTModel alloc] init];
        response.data = data;
        sleep(2);
        success(response);
    }else {
        sleep(2);
        failure();
    }
}

@end
