//
//  ViewController.m
//  OW_LunBoQiExcenple
//
//  Created by 上海银来（集团）有限公司 on 16/4/18.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "ViewController.h"
#import "OW_LunBoQi.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    OW_LunBoQi * turnView = [OW_LunBoQi ow_turnImage];
//    加载图片数组   和处理点击事件
    [turnView ow_loadDataSource:@[] ClickImg:^(NSInteger index) {
        
    }];
    [self.view addSubview:turnView];
}


@end
