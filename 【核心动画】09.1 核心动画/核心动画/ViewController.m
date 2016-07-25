//
//  ViewController.m
//  核心动画
//
//  Created by 蓝田 on 16/7/15.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  CABasicAnimation *anim = [CABasicAnimation animation];

  anim.keyPath = @"position";

  anim.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 400)];

  // 注意：取消反弹代码必须放在图层添加动画之前。
  anim.removedOnCompletion = NO;

  // 设置保存动画的最新状态,图层会保持显示动画执行后的状态
  anim.fillMode = kCAFillModeForwards;

  //（不需要遵守协议）设置代理，动画执行完毕后会调用delegate的animationDidStop:finished:
  anim.delegate = self;

  [_redView.layer addAnimation:anim forKey:nil];
}

#pragma mark - 动画完成的时候调用
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
  // 打印图层的位置的CGPoint
  NSLog(@"动画完成:%@", NSStringFromCGPoint(_redView.layer.position));
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 打印图层的位置的CGPoint
  NSLog(@"原始位置:%@", NSStringFromCGPoint(_redView.layer.position));
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end

// 结论：核心动画一切都是假象，并不会真实的改变图层的属性值，如果以后做动画的时候，不需要与用户交互，通常用核心动画（如：转场动画）。
