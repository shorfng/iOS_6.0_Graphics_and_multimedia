//
//  ViewController.m
//  OC-MPMoviePlayerViewController播放视频
//
//  Created by 蓝田 on 2016/11/9.
//  Copyright © 2016年 蓝田. All rights reserved.
//


#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()
@property (nonatomic, strong) MPMoviePlayerViewController *playerVC;
@end

@implementation ViewController

-(MPMoviePlayerViewController *)playerVC
{
    if (!_playerVC) {
        // ① 本地媒体文件
        // 方法1：
        NSString *path = [[NSBundle mainBundle]pathForResource:@"1.mp4" ofType:nil];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        // 方法2：
        // NSURL *url = [[NSBundle mainBundle]URLForResource:@"1.mp4" withExtension:nil];
        
        _playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
        
        
        // ② 通过远程URL, 创建控制器 MPMoviePlayerViewController
        // NSURL *remoteURL = [NSURL URLWithString:@"http://v1.mukewang.com/57de8272-38a2-4cae-b734-ac55ab528aa8/L.mp4"];
        // _playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:remoteURL];
    }
    return _playerVC;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 2. 直接模态弹出该控制器(或者: 设置播放视图frame, 添加到需要展示的视图上)
    [self presentViewController:self.playerVC
                       animated:YES completion:^{
                           // 3. 开始播放
                           [self.playerVC.moviePlayer play];
                       }];
}

@end

