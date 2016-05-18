//
//  ViewController.m
//  NSThreadDemo
//
//  Created by IvanDing on 16/5/18.
//  Copyright © 2016年 IvanDing. All rights reserved.
//
//  此demo用于展示使用NSThread创建线程

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 隐式创建并启动线程
    [self createThreadWithImplicit];
    // 使用NSThread类方法显式创建并启动线程
//    [self createThreadWithClassMethod];
    // 使用init方法显式创建线程
//    [self createThreadWithInit];
}

/**
 *  隐式创建并启动线程
 */
- (void)createThreadWithImplicit {
    // 隐式创建并启动线程
    [self performSelectorInBackground:@selector(threadMethod3:) withObject:@"implicitMethod"];
}

/**
 *  使用NSThread类方法显式创建并启动线程
 */
- (void)createThreadWithClassMethod {
    // 使用类方法创建线程并自动启动线程
    [NSThread detachNewThreadSelector:@selector(threadMethod2:) toTarget:self withObject:@"fromClassMethod"];
}

/**
 *  使用init方法显式创建线程
 */
- (void)createThreadWithInit {
    // 创建线程
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(threadMethod1) object:nil];
    // 设置线程名
    [thread1 setName:@"thread1"];
    // 设置优先级 优先级从0到1 1最高
    [thread1 setThreadPriority:0.9];
    // 启动线程
    [thread1 start];
}

- (void)threadMethod1 {
    NSLog(@"sub thread1 -- %@", [NSThread currentThread]);
}

- (void)threadMethod2:(id)obj {
    NSLog(@"sub thread2 -- %@ --- %@", [NSThread currentThread], obj);
}

- (void)threadMethod3:(id)obj {
    NSLog(@"sub thread3 -- %@ --- %@", [NSThread currentThread], obj);
}

@end
