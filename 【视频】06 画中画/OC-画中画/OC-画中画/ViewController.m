//
//  ViewController.m
//  OC-画中画
//
//  Created by 蓝田 on 2016/11/10.
//  Copyright © 2016年 蓝田. All rights reserved.
//


// 画中画功能只支持iPad air2之后的iPad机型

#import "ViewController.h"
#import <AVKit/AVKit.h>  // 框架
#import <AVFoundation/AVFoundation.h>  // AVPlayer

@interface ViewController ()<AVPlayerViewControllerDelegate>
@property (nonatomic,strong)AVPlayerViewController *AVPlayerVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)AVPlayerViewController:(UIButton *)sender {
    // 1.创建播放控制器
    AVPlayerViewController *vc = [[AVPlayerViewController alloc]init];
    self.AVPlayerVC = vc;
    
    // 设置代理
    vc.delegate = self;
    
    // 创建URL
    NSString *path = [[NSBundle mainBundle]pathForResource:@"1.mp4" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    // 创建播放器
    AVPlayer *player = [[AVPlayer alloc]initWithURL:url];
    vc.player = player;
    
    // 是否显示控制按钮
    //vc.showsPlaybackControls = NO;
    
    // 2.播放
    [player play];
    
    // 3.展示界面
    [self presentViewController:vc animated:YES completion:nil];
    
    // 4.注册通知中心 接受通知(AVPlayerItemDidPlayToEndTimeNotification)
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didPlayToEndTime)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil];
}

// 接收到通知会来到此方法 (效果：切换下一个视频)
- (void)didPlayToEndTime{
    
    // 创建URL，更换视频
    NSString *path = [[NSBundle mainBundle]pathForResource:@"2.mp4" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    // 直接 换掉 vc的 player
    AVPlayer *player = [[AVPlayer alloc]initWithURL:url];
    
    // 播放
    [player play];
    
    // 设置为替换后的新player
    self.AVPlayerVC.player  = player;
}

#pragma mark - AVPlayerViewControllerDelegate代理方法（对用户画中画的操作进行监听）
// 将要开始画中画时调用的方法
- (void)playerViewControllerWillStartPictureInPicture:(AVPlayerViewController *)playerViewController{
    NSLog(@"1将要开始画中画");
}

// 已经开始画中画时调用的方法
- (void)playerViewControllerDidStartPictureInPicture:(AVPlayerViewController *)playerViewController{
    NSLog(@"2已经开始画中画");
}

// 开启画中画失败调用的方法
- (void)playerViewController:(AVPlayerViewController *)playerViewController failedToStartPictureInPictureWithError:(NSError *)error{
    NSLog(@"3开启画中画失败调");
}

// 将要停止画中画时调用的方法
- (void)playerViewControllerWillStopPictureInPicture:(AVPlayerViewController *)playerViewController{
    NSLog(@"4将要停止画中画");
}

// 已经停止画中画时调用的方法
- (void)playerViewControllerDidStopPictureInPicture:(AVPlayerViewController *)playerViewController{
    NSLog(@"5已经停止画中画");
}

// 是否在开始画中画时自动将当前的播放界面dismiss掉 返回YES则自动dismiss 返回NO则不会自动dismiss
- (BOOL)playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart:(AVPlayerViewController *)playerViewController{
    NSLog(@"6自动将当前的播放界面dismiss掉");
    return YES;
}

// 用户点击还原按钮，从画中画模式还原回app内嵌模式时调用的方法
- (void)playerViewController:(AVPlayerViewController *)playerViewController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL restored))completionHandler{
    NSLog(@"7从画中画模式还原回app内嵌模式");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
