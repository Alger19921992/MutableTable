//
//  MTTableViewCell.h
//  MutableTable
//
//  Created by pengzhu on 2017/7/10.
//  Copyright © 2017年 Alger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTModel.h"

@interface MTTableViewCell : UITableViewCell

@property (nonatomic,copy) void (^onReload)();

@property (nonatomic,assign) BOOL isLoading;

- (void)showWithData:(MTModel *)data;

@end
