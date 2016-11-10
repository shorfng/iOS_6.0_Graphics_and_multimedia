//
//  ViewController.m
//  OC-MPMoviePlayerController播放视频
//
//  Created by 蓝田 on 2016/11/9.
//  Copyright © 2016年 蓝田. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h> // 视频播放的框架（已过期）

@interface ViewController ()
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@end

@implementation ViewController

-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        
        // ① 本地媒体文件
        NSString *path = [[NSBundle mainBundle]pathForResource:@"1.mp4" ofType:nil];
        NSURL *url = [NSURL fileURLWithPath:path];
        _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
        
        // ② 通过远程URL, 创建控制器 MPMoviePlayerController
        // NSURL *remoteURL = [NSURL URLWithString:@"http://v1.mukewang.com/57de8272-38a2-4cae-b734-ac55ab528aa8/L.mp4"];
        // _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:remoteURL];
    }
    return _moviePlayer;
}

// 2. 设置播放视图frame, 添加到需要展示的视图上
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置播放视图的frame
    self.moviePlayer.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height * 9 / 16);
    
    /*
     MPMovieControlStyleNone,       // 不显示控制台(没有播放控制控件)
     MPMovieControlStyleEmbedded,   // 默认(嵌入式播放控件。没有Done按钮)
     MPMovieControlStyleFullscreen  // 显示全部控制台(全屏播放，有播放进度、Done按钮和快进等控件)
     */
    // 设置控制台的样式
    self.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    
    // 添加播放视图到要显示的视图
    [self.view addSubview:self.moviePlayer.view];
    
    // 注册通知中心 接受通知(MPMoviePlayerPlaybackDidFinishNotification)
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerPlaybackDidFinish)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
}

// 接收到通知会来到此方法 (效果：切换下一个视频)
- (void)moviePlayerPlaybackDidFinish{
    
    // 创建URL，更换视频
    NSString *path = [[NSBundle mainBundle]pathForResource:@"2.mp4" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    // 将下一个视频的URL添加到contentURL
    self.moviePlayer.contentURL = url;
    
    // 播放
    [self.moviePlayer play];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 3.播放 (此控制器不是视图控制器, 不能弹出)
    [self.moviePlayer play];
}

@end
