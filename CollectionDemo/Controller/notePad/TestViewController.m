//
//  TestViewController.m
//  CollectionDemo
//
//  Created by guowei on 15/8/8.
//  Copyright (c) 2015年 guowei. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UITextView *textV = [[UITextView alloc] initWithFrame:CGRectMake(10, 100, 300, 80) textContainer:nil];
    textV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textV];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}


@end
