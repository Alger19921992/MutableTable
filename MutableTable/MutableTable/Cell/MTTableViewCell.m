//
//  MTTableViewCell.m
//  MutableTable
//
//  Created by pengzhu on 2017/7/10.
//  Copyright © 2017年 Alger. All rights reserved.
//

#import "MTTableViewCell.h"

@implementation MTTableViewCell
@synthesize isLoading;

- (void)showWithData:(MTModel *)data {
    isLoading = NO;
    if (data != nil) {
        self.textLabel.text = @"加载成功";
    }
    else {
        self.textLabel.text = @"重新加载";
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reload)];
        [self.contentView addGestureRecognizer:tap];
    }
}

- (void)reload {
    if (!isLoading) {
        self.textLabel.text = @"加载中...";
        isLoading = YES;
        self.onReload();
    }
}

@end
