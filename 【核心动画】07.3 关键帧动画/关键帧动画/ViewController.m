//
//  ViewController.m
//  关键帧动画
//
//  Created by 蓝田 on 16/7/13.
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
  animView.frame = CGRectMake(100, 200, 20, 20);
  animView.backgroundColor = [UIColor redColor];

  self.animView = animView;
  [self.view addSubview:animView];
}

#pragma mark - 点击屏幕调用
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

  [self positionAnim];
  [self shake];
//  [self positionAnim1];
}

#pragma mark - 1、在指定的几个点上运动
- (void)positionAnim {
  // 1.1 创建动画
  CAKeyframeAnimation *anim = [[CAKeyframeAnimation alloc] init];

  // 1.2 操作
  anim.keyPath = @"position";

  // 此代码相当于上面的两个步骤
//  CAKeyframeAnimation *anim =[CAKeyframeAnimation animationWithKeyPath:@"position"];

  // 2.1 关键帧
  NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
  NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(150, 50)];
  NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(50, 150)];
  NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(150, 150)];
  anim.values = @[ v1, v2, v3, v4 ]; // 放关键帧

  // 2.2 设置属性
  anim.fillMode =
      kCAFillModeForwards;       // 设置保存动画的最新状态,图层会保持显示动画执行后的状态
  anim.removedOnCompletion = NO; // 设置动画执行完毕之后不删除动画
  anim.duration = 3;             // 动画时间
  anim.repeatCount = INT_MAX; // 重复的次数，此处为最大(不要写0!!!!!)

  // 3.添加到某个layer对象
  [self.animView.layer addAnimation:anim forKey:nil];
}

#pragma mark - 摇晃动画
- (void)shake {

  if ([self.animView.layer animationForKey:@"shake"])
    return;

  CAKeyframeAnimation *anim =
      [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];

  anim.values = @[ @(-M_PI / 36), @(M_PI / 36), @(-M_PI / 36) ];

  anim.repeatCount = MAXFLOAT;

  [self.animView.layer addAnimation:anim forKey:@"shake"];
}

#pragma mark - 图层在指定的路径上运动
- (void)positionAnim1 {
  // 1.创建动画
  CAKeyframeAnimation *anim =
      [CAKeyframeAnimation animationWithKeyPath:@"position"];

  // 2.绘制圆形路径

  // 画圆方法1:
  UIBezierPath *path =
  [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150)
                                 radius:100
                             startAngle:0
                               endAngle:2 * M_PI
                              clockwise:1];
  anim.path = path.CGPath; // 路径

  //   画圆方法2：此种方法会提前走完一个圆，走完后会停滞一段时间
//  UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 200, 200)];
//  anim.path = path.CGPath; // 路径

  // 此代码相当于上面的两个步骤
//  anim.path =[UIBezierPath bezierPathWithOvalInRect:CGRectMake(60, 100, 200, 200)].CGPath;

  anim.duration = 2.0f;        // 持续时间
  anim.repeatCount = MAXFLOAT; // 重复次数

  // 3.添加动画
  [self.animView.layer addAnimation:anim forKey:nil];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
