//
//  ViewController.m
//  TimeConsumingDemo
//
//  Created by IvanDing on 16/5/17.
//  Copyright © 2016年 IvanDing. All rights reserved.
//
//  此demo用于展示单线程耗时操作阻塞线程

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 *  按钮点击事件
 */
- (IBAction)btnAction:(id)sender {
    // 耗时操作
    [self timeConsuming];
}

/**
 *  耗时操作
 */
- (void)timeConsuming {
    // 用循环模拟耗时操作
    for (int i = 0; i < 100000; i++) {
        // [NSThread currentThread] 为获取当前
        NSLog(@"timeConsuming in %@, times: %d", [NSThread currentThread], i);
    }
}

@end
