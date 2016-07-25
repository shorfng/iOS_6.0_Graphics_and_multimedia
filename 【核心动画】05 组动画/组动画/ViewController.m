//
//  ViewController.m
//  组动画
//
//  Created by 蓝田 on 16/7/14.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  // 组动画：同时缩放，旋转，平移
  CAAnimationGroup *group = [CAAnimationGroup animation];

  // 缩放
  CABasicAnimation *scale = [CABasicAnimation animation];
  scale.keyPath = @"transform.scale";
  scale.toValue = @0.5;

  // 旋转（随机效果）
  CABasicAnimation *rotation = [CABasicAnimation animation];
  rotation.keyPath = @"transform.rotation";
  rotation.toValue = @(arc4random_uniform(M_PI));

  // 平移（随机效果）
  CABasicAnimation *position = [CABasicAnimation animation];
  position.keyPath = @"position";
  position.toValue =
      [NSValue valueWithCGPoint:CGPointMake(arc4random_uniform(200),
                                            arc4random_uniform(200))];

  // 放入组动画
  group.animations = @[ scale, rotation, position ];

  [_redView.layer addAnimation:group forKey:nil];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
