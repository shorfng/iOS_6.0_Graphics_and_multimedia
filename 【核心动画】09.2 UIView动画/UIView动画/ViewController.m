//
//  ViewController.m
//  UIView动画
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

  [UIView animateWithDuration:0.25
      animations:^{
        _redView.layer.position = CGPointMake(150, 400);
      }
      completion:^(BOOL finished) {
        // 动画完成的时候，打印图层的位置的CGPoint
        NSLog(@"动画完成:%@", NSStringFromCGPoint(_redView.layer.position));
      }];
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

// 结论：UIView动画必须通过修改属性的真实值，才有动画效果。
