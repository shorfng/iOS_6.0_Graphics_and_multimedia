//
//  ViewController.m
//  粒子效果
//
//  Created by 蓝田 on 16/7/24.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "DrawView.h"
#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
#pragma mark - 点击开始动画
- (IBAction)startAnim:(id)sender {
  DrawView *view = (DrawView *)self.view; // 强转的方式获取
  [view startAnim];
}

#pragma mark - 点击重绘
- (IBAction)reDraw:(id)sender {
  DrawView *view = (DrawView *)self.view;
  [view reDraw];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
