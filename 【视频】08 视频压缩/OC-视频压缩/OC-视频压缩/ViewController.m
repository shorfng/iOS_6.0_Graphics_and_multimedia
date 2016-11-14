//
//  ViewController.m
//  OC-视频压缩
//
//  Created by 蓝田 on 2016/11/14.
//  Copyright © 2016年 蓝田. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 1.获取手机上的视频
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 1.1 获取手机相册
    UIImagePickerController *vc = [[UIImagePickerController alloc]init];
    
    // 设置来源
    vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // 设置类型
    vc.mediaTypes = [UIImagePickerController  availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    // 1.2 设置代理
    vc.delegate = self;
    
    // 1.3 展示界面
    [self presentViewController:vc animated:YES completion:nil];
}

// 1.4 实现 UIImagePickerControllerDelegate 代理方法
// 获取所点击的图片or视频 （实现代理方法之后,界面不会退出）
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"%@",info);
    
    // 2.进行导出 压缩
    
    // 2.1 创建导出对象（通过 UIImagePickerControllerMediaURL 获取到点击的视频）
    NSURL *url = info[UIImagePickerControllerMediaURL];
    // 指定素材
    AVAsset *asset = [AVAsset assetWithURL:url];
    // 设置导出的类型
    AVAssetExportSession *session = [[AVAssetExportSession alloc]initWithAsset:asset
                                                                    presetName:AVAssetExportPresetLowQuality];
    
    
    // 2.2 设置导出存放的地方
    // 获取沙盒路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    // 设置保存的视频的路径（包括视频名）
    path = [path stringByAppendingPathComponent:@"123.mp4"];
    // 设置导出位置
    session.outputURL = [NSURL fileURLWithPath:path];
    
    // 设置导出的视频类型
    session.outputFileType = AVFileTypeQuickTimeMovie;
    
    //2.3 导出,开始压缩
    [session exportAsynchronouslyWithCompletionHandler:^{
        NSLog(@"导出完成");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
