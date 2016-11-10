//
//  ViewController.m
//  OC-视频截图
//
//  Created by 蓝田 on 2016/11/10.
//  Copyright © 2016年 蓝田. All rights reserved.
//

// 为了简化代码，只做截图功能，不附加播放器功能

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 视频截图
- (IBAction)star:(UIButton *)sender {
    
    // ① 本地媒体文件
    NSString *path = [[NSBundle mainBundle]pathForResource:@"1.mp4" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    // 创建AVAsset对象,指定素材
    AVAsset *asset = [AVAsset assetWithURL:url];
    
    // ② 通过远程URL, 创建控制器 MPMoviePlayerViewController
    // NSURL *remoteURL = [NSURL URLWithString:@"http://v1.mukewang.com/3e35cbb0-c8e5-4827-9614-b5a355259010/L.mp4"];
    // AVAsset *asset = [AVAsset assetWithURL:remoteURL];
    
    // 1.创建截图对象
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    
    // 2.开始截图（参数1：Times表示要截取的视频的时间，必须是对象，如果用在播放器中，则此处应是当前视频播放的时间）
    [gen generateCGImagesAsynchronouslyForTimes:@[@(20.0)]
                              completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
                                  
                                  // 把截图显示在imageView上的操作放在主线程（更新UI）
                                  dispatch_sync(dispatch_get_main_queue(), ^{
                                      // 类型转换
                                      self.imageView.image = [UIImage imageWithCGImage:image];
                                  });
                                  
                              }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
