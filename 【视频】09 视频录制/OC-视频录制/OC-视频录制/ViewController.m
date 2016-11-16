//
//  ViewController.m
//  OC-视频录制
//
//  Created by 蓝田 on 2016/11/16.
//  Copyright © 2016年 蓝田. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVCaptureFileOutputRecordingDelegate>
@property (nonatomic,strong)AVCaptureMovieFileOutput *output;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 开始录制视频
- (IBAction)start:(UIButton *)sender {
    // 1.创建输入对象
    // 获取麦克风
    AVCaptureDevice *audioDevice = [AVCaptureDevice  defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDeviceInput *audioInput = [[AVCaptureDeviceInput alloc]initWithDevice:audioDevice error:nil];
    
    // 获取摄像头
    AVCaptureDevice *videoDevice = [AVCaptureDevice  defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *videoInput = [[AVCaptureDeviceInput alloc]initWithDevice:videoDevice error:nil];
    
    // 2.创建输出对象
    AVCaptureMovieFileOutput *output = [[AVCaptureMovieFileOutput alloc]init];
    self.output = output;
    
    // 3.创建会话连接输入和输出
    AVCaptureSession *session = [[AVCaptureSession alloc]init];
    
    // 判断是否可以添加到会话
    if ([session canAddInput:videoInput]) {
        [session addInput:videoInput];
    }
    
    if ([session canAddInput:audioInput]) {
        [session addInput:audioInput];
    }
    
    if ([session canAddOutput:output]) {
        [session addOutput:output];
    }
    
    // 4.添加到图层
    AVCaptureVideoPreviewLayer *layer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:session];
    layer.frame = CGRectMake(15,30,300, [UIScreen mainScreen].bounds.size.height-80);
    [self.view.layer addSublayer:layer];
    
    // 5.开始会话
    [session startRunning];
    
    // 6.设置视频的存放位置
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    path = [path stringByAppendingPathComponent:@"123.mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    // 7.开始录制
    [output startRecordingToOutputFileURL:url recordingDelegate:self];
}

#pragma mark - 停止录制视频
- (IBAction)stop:(UIButton *)sender {
    [self.output stopRecording];
}

#pragma mark - 代理方法：开始录制视频
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
    
    NSLog(@"开始录制视频");
}

#pragma mark - 代理方法：停止录制视频
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    
    NSLog(@"停止录制视频");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
