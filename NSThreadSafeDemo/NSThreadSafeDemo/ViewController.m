//
//  ViewController.m
//  NSThreadSafeDemo
//
//  Created by IvanDing on 16/5/18.
//  Copyright © 2016年 IvanDing. All rights reserved.
//
//  此demo用于展示使用NSThread线程安全

#import "ViewController.h"

@interface ViewController ()

// 存钱
@property (nonatomic, strong) NSThread * saveThread;
// 取钱
@property (nonatomic, strong) NSThread * drawThread;
// 存款
@property (nonatomic, assign) int depositMoney;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 初始化状态
    [self initStatus];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 启动线程
    [self startThread];
}

/**
 *  初始化状态
 */
- (void)initStatus {
    // 设置存款
    self.depositMoney = 5000;
    // 创建存取钱线程
    self.saveThread = [[NSThread alloc] initWithTarget:self selector:@selector(saveAndDraw) object:nil];
    self.saveThread.name = @"save";
    self.drawThread = [[NSThread alloc] initWithTarget:self selector:@selector(saveAndDraw) object:nil];
    self.drawThread.name = @"draw";
}

/**
 *  开启线程
 */
- (void)startThread {
    // 开启存取钱线程
    [self.saveThread start];
    [self.drawThread start];
}

/**
 *  存取钱操作
 */
- (void)saveAndDraw {
    while(1) {
        // 互斥锁
        @synchronized (self) {
            if(self.depositMoney > 3000) {
                [NSThread sleepForTimeInterval:0.05];
                if([[NSThread currentThread].name isEqualToString:@"save"]) {
                    self.depositMoney += 100;
                } else {
                    self.depositMoney -= 100;
                }
                NSLog(@"currentThread: %@, depositMoney: %d", [NSThread currentThread].name, self.depositMoney);
            } else {
                NSLog(@"no money");
                return;
            }
        }
    }
}

@end
