//
//  ViewController.m
//  NSThreadCommunicationDemo
//
//  Created by IvanDing on 16/5/18.
//  Copyright © 2016年 IvanDing. All rights reserved.
//
//  此demo用于展示使用NSThread线程间通信

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 下载图片
    [self downloadImage];
}

/**
 *  下载图片
 */
- (void)downloadImage {
    // 创建线程下载图片
    [NSThread detachNewThreadSelector:@selector(downloadImageInThread) toTarget:self withObject:nil];
}

/**
 *  线程中下载图片操作
 */
- (void)downloadImageInThread {
    NSLog(@"come in sub thread -- %@", [NSThread currentThread]);
    // 获取图片url
    NSURL *url = [NSURL URLWithString:@"http://img.ycwb.com/news/attachement/jpg/site2/20110226/90fba60155890ed3082500.jpg"];
    // 计算耗时
    NSDate *begin = [NSDate date];
    // 使用CoreFoundation计算耗时 CFDate
    CFTimeInterval beginInCF = CFAbsoluteTimeGetCurrent();
    // 从url读取数据(下载图片) -- 耗时操作
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    NSDate *end = [NSDate date];
    CFTimeInterval endInCF= CFAbsoluteTimeGetCurrent();
    // 计算时间差
    NSLog(@"time difference -- %f", [end timeIntervalSinceDate:begin]);
    NSLog(@"time difference inCF -- %f", endInCF - beginInCF);
    // 通过二进制data创建image
    UIImage *image = [UIImage imageWithData:imageData];
    
    // 回到主线程进行图片赋值和界面刷新
    [self performSelectorOnMainThread:@selector(backToMainThread:) withObject:image waitUntilDone:YES];
    // 这里也可以使用imageView的set方法进行操作
//    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
}

/**
 *  回到主线程的操作
 */
- (void)backToMainThread:(UIImage *)image {
    NSLog(@"back to main thread --- %@", [NSThread currentThread]);
    // 赋值图片到imageview
    self.imageView.image = image;
}

@end
