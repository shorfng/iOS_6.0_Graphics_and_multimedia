//
//  ViewController.m
//  活动指示器效果
//
//  Created by 蓝田 on 16/7/21.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UIView *gray;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

#pragma mark - 创建复制图层
  CAReplicatorLayer *repL = [CAReplicatorLayer layer];
  repL.frame = _gray.bounds;
  [_gray.layer addSublayer:repL];

#pragma mark - 创建一个矩形图层，设置缩放动画。
  CALayer *layer = [CALayer layer];

  // 设置属性
  layer.transform = CATransform3DMakeScale(0, 0, 0);
  layer.position = CGPointMake(_gray.bounds.size.width / 2, 20);
  layer.bounds = CGRectMake(0, 0, 10, 10);
  layer.backgroundColor = [UIColor grayColor].CGColor;

  // 添家图层
  [repL addSublayer:layer];

  // 设置缩放动画
  CABasicAnimation *anim = [CABasicAnimation animation];

  anim.keyPath = @"transform.scale";
  anim.fromValue = @1; // 动画Value值从1到0变化
  anim.toValue = @0;
  anim.repeatCount = MAXFLOAT;
  CGFloat duration = 1;
  anim.duration = duration;

  [layer addAnimation:anim forKey:nil];

#pragma mark - 复制矩形图层，并且设置每个复制层的角度形变
  int count = 20;

  CGFloat angle = M_PI * 2 / count; // 设置子层形变角度
  repL.instanceCount = count;       // 设置子层总数
  repL.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);

#pragma mark - 设置复制动画延长时间（需要保证第一个执行完毕之后，绕一圈刚好又是从第一个执行，因此需要把动画时长平均分给每个子层）
  // 公式:子层动画延长时间 = 动画时长 / 子层总数
  // 假设有两个图层，动画时间为1秒，延长时间就为0.5秒。当第一个动画执行到一半的时候（0.5），第二个开始执行。第二个执行完
  repL.instanceDelay = duration / count;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
