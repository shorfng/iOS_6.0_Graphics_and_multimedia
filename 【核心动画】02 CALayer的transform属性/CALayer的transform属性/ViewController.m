//
//  ViewController.m
//  CALayer的transform属性
//
//  Created by 蓝田 on 16/6/27.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) CALayer *layer;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  CALayer *layer = [[CALayer alloc] init];

  layer.bounds = CGRectMake(0, 0, 100, 100);          // 大小
  layer.position = CGPointMake(100, 100);             // 位置
  layer.backgroundColor = [UIColor redColor].CGColor; // 颜色
  layer.opacity = 1;                                  // 透明度

  [self.view.layer addSublayer:layer];

  layer.contents = (__bridge id)[UIImage imageNamed:@"me"].CGImage;

  // 给全局属性赋值
  self.layer = layer;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

  // 旋转
  self.layer.transform =
      CATransform3DRotate(self.layer.transform, M_PI_4, 0, 0, 1);

  // 平移(z轴 没反应)
  self.layer.transform =
      CATransform3DTranslate(self.layer.transform, 10, 10, 0);

  // 缩放(z轴 没反应)
  self.layer.transform = CATransform3DScale(self.layer.transform, 1, 1, 0.5);
}
@end
