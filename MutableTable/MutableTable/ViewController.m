//
//  ViewController.m
//  MutableTable
//
//  Created by pengzhu on 2017/7/10.
//  Copyright © 2017年 Alger. All rights reserved.
//

#import "ViewController.h"
#import "MTTableViewCell.h"
#import "MTRequest.h"
#import "MTResponse.h"
#import "MTApplication.h"

@interface ViewController ()

@property (nonatomic,strong) UITableView *mutableTable;
@property (nonatomic,assign) int finishCount;
@property (nonatomic,strong) MTModel *model1;
@property (nonatomic,strong) MTModel *model2;
@property (nonatomic,strong) MTModel *model3;
@property (nonatomic,strong) MTModel *model4;
@property (nonatomic,strong) MTModel *model5;

@end

@interface ViewController (TableDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController
@synthesize mutableTable;
@synthesize finishCount;
@synthesize model1;
@synthesize model2;
@synthesize model3;
@synthesize model4;
@synthesize model5;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"MutableTable"];
    [self setUpView];
    [self loadData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setUpView {
    if (mutableTable == nil) {
        mutableTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        mutableTable.separatorStyle = UITableViewCellSelectionStyleNone;
        mutableTable.delegate = self;
        mutableTable.dataSource = self;
    }
    [self.view addSubview:mutableTable];
}

- (void)loadData {
    __weak id weakSelf = self;
    dispatch_queue_t queue = dispatch_queue_create("loadData.queue", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i < 5; i ++) {
        dispatch_async(queue, ^{
            [[MTApplication sharedApplication] postWithRequest:[[MTRequest alloc] init] onSuccess:^(MTResponse *response) {
                [weakSelf setDataWithIndex:i data:response.data];
                [weakSelf loadCellAtIndex:i];
            } onFailure:^{
                [weakSelf setDataWithIndex:i data:nil];
                [weakSelf loadCellAtIndex:i];
            }];
        });
    }
}

- (void)setDataWithIndex:(int)index data:(MTModel *)data {
    switch (index) {
        case 0:
            model1 = data;
            break;
        case 1:
            model2 = data;
            break;
        case 2:
            model3 = data;
            break;
        case 3:
            model4 = data;
            break;
        case 4:
            model5 = data;
            break;
            
        default:
            break;
    }
}

- (void)reloadDataAtIndex:(int)index {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [[MTApplication sharedApplication] postWithRequest:[[MTRequest alloc] init] onSuccess:^(MTResponse *response) {
            [self setDataWithIndex:index data:response.data];
            [self reloadCellAtIndex:index];
        } onFailure:^{
            [self setDataWithIndex:index data:nil];
            [self reloadCellAtIndex:index];
        }];
    });
}

- (void)reloadCellAtIndex:(int)index {
    dispatch_async(dispatch_get_main_queue(), ^{
        [mutableTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationMiddle];
    });
}

- (void)loadCellAtIndex:(int)index {
    dispatch_async(dispatch_get_main_queue(), ^{
        finishCount += 1;
        [mutableTable insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation ViewController (TableDelegate)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return finishCount;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak id weakSelf = self;
    static NSString *cellIdentifier = @"cellIdentifier";
    MTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MTTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    cell.onReload = ^() {
        [weakSelf reloadDataAtIndex:(short)indexPath.row];
    };
    switch (indexPath.row) {
        case 0:
            cell.backgroundColor = [UIColor greenColor];
            [cell showWithData:model1];
            break;
        case 1:
            cell.backgroundColor = [UIColor redColor];
            [cell showWithData:model2];
            break;
        case 2:
            cell.backgroundColor = [UIColor grayColor];
            [cell showWithData:model3];
            break;
        case 3:
            cell.backgroundColor = [UIColor orangeColor];
            [cell showWithData:model4];
            break;
        case 4:
            cell.backgroundColor = [UIColor blueColor];
            [cell showWithData:model5];
            break;
            
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end
