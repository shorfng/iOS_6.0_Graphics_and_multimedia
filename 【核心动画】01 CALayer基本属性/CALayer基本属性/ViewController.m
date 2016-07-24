//
//  ViewController.m
//  CALayer基本属性
//
//  Created by 蓝田 on 16/5/25.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

  // 创建一个redView
  UIView *redView =
      [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
  redView.backgroundColor = [UIColor redColor];
  [self.view addSubview:redView];

  // 边框宽度
  redView.layer.borderWidth = 10;
  // 边框颜色(CGColorRef类型) ，通过[UIColor xxxxColor].CGColor 转换
  redView.layer.borderColor = [UIColor whiteColor].CGColor;

  // 阴影（在CA框架中不能直接使用UIKit的数据类型）
  redView.layer.shadowOpacity = 1; //图层中的Opacity相当于view的alpha属性
  redView.layer.shadowOffset = CGSizeZero; // //阴影偏移点，CGSizeZero表示0
  //  redView.layer.shadowOffset = CGSizeMake(20, 20);
  redView.layer.shadowColor = [UIColor blueColor].CGColor; //阴影颜色
  redView.layer.shadowRadius = 50; // 阴影的圆角半径

  // 圆角半径
  redView.layer.cornerRadius = 50; // 设置控件的主层的圆角半径

  // 如有图片，一般都是显示在contents上而非主层上
  NSLog(@"%@", redView.layer.contents);

  // 超出主层边框的内容全部裁剪掉，类似于clip，使用masksToBounds阴影效果无效
  // 超出layer的部分不再显示(裁剪,设置头像的时候加上)
  redView.layer.masksToBounds = YES;

  // 大小
  redView.layer.bounds = CGRectMake(0, 0, 200, 200);

  // 位置 (默认的情况下  positon的点 表示 view中心的位置)
  redView.layer.position = CGPointMake(100, 100);

  // 设置图层内容   (将一个UIImage类型转换为CGImageRef)<c对象转换成oc对象>
  redView.layer.contents = (__bridge id)([UIImage imageNamed:@"TD"].CGImage);

  // 颜色
  redView.layer.backgroundColor = [UIColor blueColor].CGColor;

  // 图层形变：旋转和缩放
  [UIView animateWithDuration:1
                   animations:^{

                     // 旋转方法1：
                     redView.layer.transform =
                         CATransform3DMakeRotation(M_PI, 1, 1, 0);
                     // 旋转方法2：KVC
                     //                 [redView.layer setValue:@(M_PI)
                     //                 forKeyPath:@"transform.rotation"];

                     // 缩放方法1：
                     redView.layer.transform =
                         CATransform3DMakeScale(0.5, 0.5, 1);
                     // 缩放方法2：快速进行图层缩放, KVC方式，x, y同时缩放0.5
                     //                 [redView.layer setValue:@0.5
                     //                 forKeyPath:@"transform.scale"];

                   }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
