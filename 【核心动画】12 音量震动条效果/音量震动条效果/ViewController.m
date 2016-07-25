//
//  ViewController.m
//  音量震动条效果
//
//  Created by 蓝田 on 16/7/21.
//  Copyright © 2016年 Loto. All rights reserved.
//

//
//  ViewController.m
//  04-音量振动条
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UIView *lightView;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

#pragma mark - 首先创建复制layer,音乐振动条layer添加到复制layer上，然后复制子层
  // 创建复制图层（CAReplicatorLayer），可以把图层里面所有子层复制
  CAReplicatorLayer *repL = [CAReplicatorLayer layer];
  // 设置复制图层的属性
  repL.frame = _lightView.bounds;
  // 添加复制图层到lightView上
  [_lightView.layer addSublayer:repL];

#pragma mark - 先创建一个音量振动条，并且设置好动画,动画是绕着底部缩放，设置锚点
  // 创建图层
  CALayer *layer = [CALayer layer];
  // 设置图层属性
  layer.anchorPoint = CGPointMake(0.5, 1);
  layer.position = CGPointMake(15, _lightView.bounds.size.height);
  layer.bounds = CGRectMake(0, 0, 30, 150);
  layer.backgroundColor = [UIColor whiteColor].CGColor;
  // 添加图层到复制图层上
  [repL addSublayer:layer];

  // 创建动画
  CABasicAnimation *anim = [CABasicAnimation animation];
  // 动画属性
  anim.keyPath = @"transform.scale.y"; // 缩放y值
  anim.toValue = @0.1;
  anim.duration = 0.2;
  anim.repeatCount = MAXFLOAT;
  anim.autoreverses = YES; // 设置动画反转
  // 添加动画
  [layer addAnimation:anim forKey:nil];

  // 复制层中子层总数：表示复制层里面有多少个子层，包括原生子层
  repL.instanceCount = 5; // 设置5个子层，其中4个是复制层

  // 复制子层形变偏移量(不包括原生子层)：相对于原生子层x偏移，每个复制子层都是相对上一个
  // 设置复制子层的相对位置，每个x轴相差45
  repL.instanceTransform = CATransform3DMakeTranslation(45, 0, 0);

  // 设置复制子层动画延迟时长
  repL.instanceDelay = 0.1;

  // 子层颜色:会和原生子层背景色冲突，如果设置了原生子层背景色，就不需要设置这个属性
  repL.instanceColor = [UIColor blueColor].CGColor;
  // 颜色通道的偏移量:每个复制子层都是相对上一个的偏移量
  repL.instanceBlueOffset = -0.3;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
