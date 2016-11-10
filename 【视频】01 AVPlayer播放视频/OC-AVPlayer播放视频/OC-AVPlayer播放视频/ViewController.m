//
//  ViewController.m
//  OC-AVPlayer播放视频
//
//  Created by 蓝田 on 2016/11/9.
//  Copyright © 2016年 蓝田. All rights reserved.
//


#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (nonatomic, strong) AVPlayer *player;
@end

@implementation ViewController

#pragma mark - 懒加载
-(AVPlayer *)player{
    if (!_player) {
        
        // ① 本地媒体文件
        NSString *path = [[NSBundle mainBundle]pathForResource:@"1.mp4" ofType:nil];
        NSURL *url = [NSURL fileURLWithPath:path];
        _player = [AVPlayer playerWithURL:url];
        
        // ② 通过远程URL创建AVPlayer对象
        //  NSURL *remoteURL = [NSURL URLWithString:@"http://v1.mukewang.com/57de8272-38a2-4cae-b734-ac55ab528aa8/L.mp4"];
        //  _player = [AVPlayer playerWithURL:remoteURL];
    }
    return _player;
}

- (void)viewDidLoad{
    // 2.1 根据player对象, 创建 AVPlayerLayer 对象
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    // 2.2 设置图层 AVPlayerLayer 的大小
    layer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height * 9 / 16);
    
    // 2.3 添加到需要展示的视图上即可
    [self.view.layer addSublayer:layer];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 1.2 开始播放
    [self.player play];
}

@end
