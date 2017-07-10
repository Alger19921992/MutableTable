//
//  MTApplication.h
//  MutableTable
//
//  Created by pengzhu on 2017/7/10.
//  Copyright © 2017年 Alger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTRequest.h"
#import "MTResponse.h"

@interface MTApplication : NSObject

+ (MTApplication*) sharedApplication;

- (void) postWithRequest:(MTRequest *)request onSuccess:(void (^)(MTResponse *))success onFailure:(void (^)())failure;

@end
