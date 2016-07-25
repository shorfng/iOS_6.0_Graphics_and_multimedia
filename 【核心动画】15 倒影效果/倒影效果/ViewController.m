//
//  ViewController.m
//  倒影效果
//
//  Created by 蓝田 on 16/7/25.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "RepView.h"
#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet RepView *repView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  CAReplicatorLayer *layer = (CAReplicatorLayer *)_repView.layer;

  layer.instanceCount = 2;

  // 设置平移（向下平移）
  CATransform3D transform =
      CATransform3DMakeTranslation(0, _repView.bounds.size.height, 0);

  // 设置旋转：绕着X轴旋转（180度）
  transform = CATransform3DRotate(transform, M_PI, 1, 0, 0);

  // 设置复制层的形变（将旋转和平移的数据设置在layer上）
  layer.instanceTransform = transform;

  // 设置颜色通道的偏移量
  layer.instanceAlphaOffset = -0.2;
  layer.instanceBlueOffset = -0.5;
  layer.instanceGreenOffset = -0.5;
  layer.instanceRedOffset = -0.5;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
