//
//  ViewController.m
//  NSThreadStatusDemo
//
//  Created by IvanDing on 16/5/18.
//  Copyright © 2016年 IvanDing. All rights reserved.
//
//  此demo用于展示使用NSThread线程状态

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 创建线程
    [self createThread];
}

/**
 *  创建线程
 */
- (void)createThread {
    // 创建线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadMethod) object:nil];
    thread.name = @"i'm a new thread";
    // 启动线程
    [thread start];
}

/**
 *  线程方法
 */
- (void)threadMethod {
    NSLog(@"thread is create -- the name is: \"%@\"", [NSThread currentThread].name);
    // 线程阻塞 -- 延迟到某一时刻 --- 这里的时刻是3秒以后
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    NSLog(@"sleep end");
    NSLog(@"sleep again");
    // 线程阻塞 -- 延迟多久 -- 这里延迟2秒
    [NSThread sleepForTimeInterval:2];
    NSLog(@"sleep again end");
    
    for (int i = 0 ; i < 100; i++) {
        NSLog(@"thread working");
        if(30 == i) {
            NSLog(@"thread will dead");
            [[NSThread currentThread] cancel];
        }
        if([[NSThread currentThread] isCancelled]) {
            // 结束线程
//            [NSThread exit];
            return;
        }
    }
}

@end
