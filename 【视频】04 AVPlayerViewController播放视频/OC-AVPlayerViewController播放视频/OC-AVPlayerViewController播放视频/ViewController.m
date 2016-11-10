//
//  ViewController.m
//  OC-AVPlayerViewController播放视频
//
//  Created by 蓝田 on 2016/11/9.
//  Copyright © 2016年 蓝田. All rights reserved.
//


#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>


@interface ViewController ()
@property (nonatomic, strong) AVPlayerViewController *playerVC;
@end

@implementation ViewController

-(AVPlayerViewController *)playerVC
{
    if (!_playerVC) {
        
        // ① 本地媒体文件
        NSString *path = [[NSBundle mainBundle]pathForResource:@"1.mp4" ofType:nil];
        NSURL *url = [NSURL fileURLWithPath:path];
        AVPlayer *player = [AVPlayer playerWithURL:url];
        
        // ② 通过远程URL创建AVPlayer
        //  NSURL *remoteURL = [NSURL URLWithString:@"http://v1.mukewang.com/57de8272-38a2-4cae-b734-ac55ab528aa8/L.mp4"];
        //  AVPlayer *player = [AVPlayer playerWithURL:remoteURL];
        
        // 2.根据AVPlayer, 创建AVPlayerViewController控制器
        _playerVC = [[AVPlayerViewController alloc] init];
        _playerVC.player = player;
        
        // 设置画中画(ipad)
        // _playerVC.allowsPictureInPicturePlayback = YES;
        
    }
    return _playerVC;
}

// 3. 方式1：设置播放视图frame, 添加播放视图到要显示的视图
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置播放视图的frame
    self.playerVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height * 9 / 16);
    
    // 添加播放视图到要显示的视图
    [self.view addSubview:self.playerVC.view];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if(self.presentedViewController) return;
    
    // 3. 方式2：直接弹出此控制器
    [self presentViewController:self.playerVC animated:YES completion:nil];
    
    // 4.开始播放
    [self.playerVC.player play];
}


@end
