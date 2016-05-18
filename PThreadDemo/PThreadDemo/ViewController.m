//
//  ViewController.m
//  PThreadDemo
//
//  Created by IvanDing on 16/5/17.
//  Copyright © 2016年 IvanDing. All rights reserved.
//
//  此demo用于展示pthread基本使用

#import "ViewController.h"
#import <pthread.h>

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
    [self pthread];
}

/**
 *  使用pthread创建线程
 */
- (void)pthread {
    pthread_t thread = NULL;
    id str = @"i'm pthread param";
    pthread_create(&thread, NULL, operate, (__bridge void *)(str));
}

/**
 *  pthread创建线程回调函数
 */
void *operate(void *param) {
    NSString *str = (__bridge NSString *)(param);
    // 用循环模拟耗时操作
    for (int i = 0; i < 100000; i++) {
        // [NSThread currentThread] 为获取当前
        NSLog(@"timeConsuming in %@, times: %d, param: %@", [NSThread currentThread], i, str);
    }
    pthread_exit((void*)0);
}

@end
