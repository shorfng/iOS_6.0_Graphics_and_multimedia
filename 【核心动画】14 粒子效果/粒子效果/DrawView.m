//
//  DrawView.m
//  粒子效果
//
//  Created by 蓝田 on 16/7/24.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "DrawView.h"

@interface DrawView ()
@property(nonatomic, strong) UIBezierPath *path;    // 路径
@property(nonatomic, weak) CALayer *dotLayer;       // 点图层
@property(nonatomic, weak) CAReplicatorLayer *repL; // 复制层
@end

@implementation DrawView

#pragma mark - 1、加载完xib调用，创建复制层
- (void)awakeFromNib {
  // 创建复制层
  CAReplicatorLayer *repL = [CAReplicatorLayer layer];
  // 设置复制层属性
  repL.frame = self.bounds;
  // 添加复制层到控件的layer上
  [self.layer addSublayer:repL];

  _repL = repL;
}

#pragma mark - 2、调用drawRect
- (void)drawRect:(CGRect)rect {
  [_path stroke];
}

#pragma mark - 3、点击屏幕
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  // 获取touch对象
  UITouch *touch = [touches anyObject];
  // 获取当前触摸点
  CGPoint curP = [touch locationInView:self];
  // 设置起点
  [self.path moveToPoint:curP];
}

#pragma mark - 4、懒加载路径（目的是为了在不点击重绘的情况下，将所有的线添加到一条路径上去）
// 因为核心动画只能设置一个路径，因此只能创建一个路径，懒加载路径。
- (UIBezierPath *)path {
  if (_path == nil) {
    _path = [UIBezierPath bezierPath];
  }
  return _path;
}

static int _instansCount = 0;
#pragma mark - 5、手指在屏幕上移动的时候
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  // 获取touch对象
  UITouch *touch = [touches anyObject];
  // 获取当前触摸点
  CGPoint curP = [touch locationInView:self];
  // 添加线到某个点
  [_path addLineToPoint:curP];
  // 重绘
  [self setNeedsDisplay];

  _instansCount++;
}

#pragma mark - 6、点击开始动画（重写开始动画的方法）
- (void)startAnim {
  _dotLayer.hidden = NO; // 开始动画的时候显示图层

  // 创建帧动画
  CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];

  // 动画属性
  anim.keyPath = @"position";
  anim.path = _path.CGPath;
  anim.duration = 3;
  anim.repeatCount = MAXFLOAT;

  // 添加动画到 dotLayer 图层上
  [self.dotLayer addAnimation:anim forKey:nil];

  // 复制子层的数(如果复制的子层有动画，先添加动画，在复制)
  _repL.instanceCount = _instansCount;
  // 设置图层延时动画
  _repL.instanceDelay = 0.2;
}

#pragma mark - 7、懒加载点图层
- (CALayer *)dotLayer {
  if (_dotLayer == nil) {
    // 创建粒子图层
    CALayer *layer = [CALayer layer];

    // 设置图层属性
    CGFloat wh = 10;
    layer.frame = CGRectMake(0, -1000, wh, wh);
    layer.cornerRadius = wh / 2;
    layer.backgroundColor = [UIColor blueColor].CGColor;

    // 添加图层到复制层上
    [_repL addSublayer:layer];

    _dotLayer = layer;
  }
  return _dotLayer;
}

#pragma mark - 8、点击重绘（重写重绘方法）
- (void)reDraw {
  _path = nil;            // 清空绘图信息
  [self setNeedsDisplay]; // 重绘

  // 把图层移除父控件，复制层也会移除。
  [_dotLayer removeFromSuperlayer];
  _dotLayer = nil;   // 清空点图层
  _instansCount = 0; // 清空子层总数
}

@end
