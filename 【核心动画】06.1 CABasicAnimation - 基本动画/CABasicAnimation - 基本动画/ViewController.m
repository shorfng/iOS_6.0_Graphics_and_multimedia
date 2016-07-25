//
//  ViewController.m
//  CABasicAnimation - 基本动画
//
//  Created by 蓝田 on 16/7/12.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) UIView *animView;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  UIView *animView = [[UIView alloc] init];
  animView.frame = CGRectMake(100, 100, 100, 100);
  animView.backgroundColor = [UIColor redColor];

  self.animView = animView;

  [self.view addSubview:animView];
}

#pragma mark - 基本动画(CABasicAnimation)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  // 1.什么动画
  CABasicAnimation *anim = [[CABasicAnimation alloc] init];

  // 2.怎么做动画
  anim.keyPath = @"position.x"; // 修改哪个属性，此处修改的是x方向

  // 方法1：
  // anim.fromValue = @(50); // 从哪
  // anim.toValue = @(300); // 到哪

  //方法2:
  anim.byValue = @(10); // 累加

  // 核心动画结束后，不想回到原来的位置，需要以下两行代码
  anim.fillMode = kCAFillModeForwards; // 填充模式
  anim.removedOnCompletion = NO;

  // 3.对谁做动画
  [self.animView.layer addAnimation:anim forKey:nil];
}

@end
