//
//  ViewController.m
//  CABasicAnimation - 基本动画案例
//
//  Created by 蓝田 on 16/7/12.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UIImageView *imageV;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  // 创建动画
  CABasicAnimation *anim = [CABasicAnimation animation];

  // 修改哪个属性产生动画（只能是layer属性）
  anim.keyPath = @"transform.scale"; // 缩放
  // 设置值
  anim.toValue = @0.5; // 表示缩放0.5

  // 设置动画执行次数
  anim.repeatCount = MAXFLOAT;

  // 取消动画反弹（设置动画完成的时候不要移除动画）
  anim.removedOnCompletion = NO;

  // 设置动画执行完成要保持最新的效果
  anim.fillMode = kCAFillModeForwards;

  // 添加动画
  [_imageV.layer addAnimation:anim forKey:nil];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}
@end
