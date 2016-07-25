//
//  ViewController.m
//  CALayer的创建
//
//  Created by 蓝田 on 16/6/30.
//  Copyright © 2016年 Loto. All rights reserved.
//

#define degree2angle(angle) ((angle)*M_PI / 180)
#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) CALayer *layer;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  // frame => 用 bounds & position
  UIView *redView =
      [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];

  // 背景色
  redView.backgroundColor = [UIColor redColor];

  // 边框
  redView.layer.borderWidth = 10;
  // borderColor 是一个 CGColor类型，通过[UIColor xxxxColor].CGColor 转换
  redView.layer.borderColor = [UIColor whiteColor].CGColor;

  // 阴影
  redView.layer.shadowOffset = CGSizeZero;
  redView.layer.shadowColor = [UIColor blueColor].CGColor;
  redView.layer.shadowOpacity = 1;
  redView.layer.shadowRadius = 50; //半径

  // 圆角
  redView.layer.cornerRadius = 50;
  redView.layer.masksToBounds = YES; //超出layer 的部分剪切

  // 大小
  redView.layer.bounds = CGRectMake(0, 0, 200, 200);

  // 位置 (默认的情况下  positon的点 表示 view中心的位置)
  redView.layer.position = CGPointMake(100, 100);

  // 内容   (将一个UIImage类型转换为CGImageRef)
  redView.layer.contents = (__bridge id)([UIImage imageNamed:@"TD"].CGImage);

  // 颜色
  redView.layer.backgroundColor = [UIColor blueColor].CGColor;

  // 将自定义layer添加到视图（图层是可以嵌套的）
  [self.view addSubview:redView];

  self.layer = redView.layer;
}

#pragma mark - 在CALayer头文件中所有标注Animatable的属性，都是可以动画的
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

  // 获取触摸对象
  UITouch *touch = touches.anyObject;
  // 获取手指的位置
  CGPoint location = [touch locationInView:self.view];
  // position 设置图层的位置
  self.layer.position = location;

  // 修改图层属性
  // 问题：同时指定transform，前面的会被后面的覆盖
  // 用"大招" KVC来解决，可以做到形变参数的叠加
  // 1.缩放
  CGFloat scale = (arc4random_uniform(5) + 1) / 10.0 + 0.5;
  //    self.layer.transform = CATransform3DMakeScale(scale, scale, 0);
  [self.layer setValue:@(scale) forKeyPath:@"transform.scale"];

  // 2. 旋转69
  CGFloat rotate = degree2angle(arc4random_uniform(360));
  //    self.layer.transform = CATransform3DMakeRotation(rotate, 0, 0, 1);
  [self.layer setValue:@(rotate) forKeyPath:@"transform.rotation.y"];

  // 3. 透明度
  CGFloat alpha = (arc4random_uniform(5) + 1) / 10.0 + 0.5;
  //    self.layer.opacity = alpha;
  [self.layer setValue:@(alpha) forKeyPath:@"opacity"];

  // 4. 设置圆角半径
  CGFloat r = arc4random_uniform(self.layer.bounds.size.width * 0.5);
  self.layer.cornerRadius = r;

  // 5. 设置边线
  self.layer.borderColor = [self randomColor].CGColor;
  self.layer.borderWidth = 3.0;
}

- (UIColor *)randomColor {

  CGFloat r = arc4random_uniform(256) / 255.0;
  CGFloat b = arc4random_uniform(256) / 255.0;
  CGFloat g = arc4random_uniform(256) / 255.0;

  return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

@end
