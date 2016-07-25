//
//  ViewController.m
//  关键帧动画-抖动效果
//
//  Created by 蓝田 on 16/7/13.
//  Copyright © 2016年 Loto. All rights reserved.
//

#define angle2radion(a) ((a) / 180.0 * M_PI) // 角度转弧度

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  // 添加核心动画
  CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];

  // 旋转
  anim.keyPath = @"transform.rotation";
  anim.values =
      @[ @(angle2radion(-5)), @(angle2radion(5)), @(angle2radion(-5)) ];

  // 设置动画重复次数
  anim.repeatCount = MAXFLOAT;

  [_imageView.layer addAnimation:anim forKey:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // 设置锚点：图层左上角
  _imageView.layer.anchorPoint = CGPointZero;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
