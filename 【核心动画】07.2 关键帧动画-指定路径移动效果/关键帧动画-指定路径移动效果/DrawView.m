//
//  DrawView.m
//  关键帧动画-指定路径移动效果
//
//  Created by 蓝田 on 16/7/13.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "DrawView.h"

@interface DrawView ()
@property(nonatomic, strong) UIBezierPath *path;
@end

@implementation DrawView

#pragma mark - 开始点击屏幕
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  // 获取 touch 对象
  UITouch *touch = [touches anyObject];

  // 获取手指的触摸点
  CGPoint curP = [touch locationInView:self];

  // 创建路径
  UIBezierPath *path = [UIBezierPath bezierPath];
  _path = path;

  // 设置起点
  [path moveToPoint:curP];
}

#pragma mark - 在屏幕移动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  // touch
  UITouch *touch = [touches anyObject];

  // 获取手指的触摸点
  CGPoint curP = [touch locationInView:self];

  [_path addLineToPoint:curP];

  [self setNeedsDisplay];
}

#pragma mark - 手指抬起的时候
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  // 给imageView 添加核心动画
  CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];

  anim.keyPath = @"position";

  anim.path = _path.CGPath; // 转换成 CGPath

  anim.duration = 1;

  anim.repeatCount = MAXFLOAT;

  // 获取子控件的第一个 view，的图层，再添加动画
  [[[self.subviews firstObject] layer] addAnimation:anim forKey:nil];
}

- (void)drawRect:(CGRect)rect {
  [_path stroke];
}

@end
