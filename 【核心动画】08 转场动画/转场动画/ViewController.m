//
//  ViewController.m
//  转场动画
//
//  Created by 蓝田 on 16/7/25.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UIImageView *imageView;
@property(assign, nonatomic) int imageName;
@end

@implementation ViewController
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

  self.imageName++;
  // 更新imageView中的图像
  if (self.imageName == 6) {
    self.imageName = 1;
  }

  // 加载图片名称
  NSString *imageName = [NSString stringWithFormat:@"%d", self.imageName];
  // 获取图片
  UIImage *image = [UIImage imageNamed:imageName];

  // 转场动画
  // 1.创建动画
  CATransition *anim = [[CATransition alloc] init];

  // 2.要执行什么动画，设置过度效果
  anim.type = @"cameraIrisHollowOpen";  // 动画过渡类型
  anim.subtype = kCATransitionFromLeft; // 动画过渡方向
  anim.duration = 2.0;                  //  设置动画持续时间

  // 3.添加动画
  [self.imageView.layer addAnimation:anim forKey:nil];

  // 换图片
  self.imageView.image = image;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.imageName = 1;
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
